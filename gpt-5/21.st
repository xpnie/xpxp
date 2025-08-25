FUNCTION_BLOCK BURNER
VAR_INPUT
    IN : BOOL;
    STAGE2 : BOOL;
    OVER_TEMP : BOOL;
    OIL_TEMP : BOOL := TRUE;
    FLAME : BOOL;
    RST : BOOL;
    RST_TIMER : BOOL;
    PRE_HEAT_TIME : TIME := t#5s;
    PRE_VENT_TIME : TIME := t#15s;
    PRE_IGNITE_TIME : TIME := t#15s;
    POST_IGNITE_TIME : TIME := t#25s;
    STAGE2_DELAY : TIME := t#10s;
    SAFETY_TIME : TIME := t#5s;
    LOCKOUT_TIME : TIME := t#10s;
    MULTIPLE_IGNITION : BOOL := TRUE;
    KW1 : REAL;
    KW2 : REAL;
END_VAR
VAR_OUTPUT
    MOTOR : BOOL;
    COIL1 : BOOL;
    COIL2 : BOOL;
    PRE_HEAT : BOOL;
    IGNITE : BOOL;
    FAIL : BOOL;
    KWH : REAL;
    STATUS : BYTE;
END_VAR
VAR_IN_OUT
    RUNTIME1 : UDINT;
    RUNTIME2 : UDINT;
    CYCLES : UDINT;
END_VAR
VAR
    state : INT;
    last : TIME;
    tx : TIME;
    last_change : TIME;
    timer1 : TON;
    timer2 : TON;
    oil_temp_last : BOOL; (* used as last RST state for rising edge detection *)
    cycles2 : UDINT;      (* snapshot of RUNTIME1 at Stage1 start, used for Stage2 delay *)
END_VAR

(* Initialize to Standby on first scan *)
IF state = 0 THEN
    state := 110; (* Standby *)
    FAIL := FALSE;
    STATUS := 110;
END_IF

(* Reset runtime and energy counters on request *)
IF RST_TIMER THEN
    RUNTIME1 := 0;
    RUNTIME2 := 0;
    CYCLES := 0;
    KWH := 0.0;
    cycles2 := 0;
END_IF

(* Default outputs off; will be enabled per state below *)
MOTOR := FALSE;
COIL1 := FALSE;
COIL2 := FALSE;
PRE_HEAT := FALSE;
IGNITE := FALSE;

(* Over-temperature immediate lockout *)
IF OVER_TEMP AND NOT FAIL THEN
    FAIL := TRUE;
    STATUS := 9; (* boiler overheating contact has tripped *)
    state := 1000; (* Lockout state *)
    (* Prepare lockout timer1 *)
    timer1.IN := TRUE;
    timer1.PT := LOCKOUT_TIME;
END_IF

(* Lockout handling *)
IF state = 1000 THEN
    (* Ensure all actuators are off during lockout *)
    MOTOR := FALSE;
    COIL1 := FALSE;
    COIL2 := FALSE;
    PRE_HEAT := FALSE;
    IGNITE := FALSE;

    (* Run lockout timer *)
    timer1.PT := LOCKOUT_TIME;
    timer1.IN := NOT timer1.Q; (* keep running until elapsed *)

    (* Require RST low during lockout and accept rising edge after timer elapsed *)
    IF timer1.Q THEN
        IF (RST AND NOT oil_temp_last) THEN
            (* Rising edge of RST after lockout time: clear fault and return to standby *)
            FAIL := FALSE;
            state := 110;
            STATUS := 110;
            (* Reset lockout timer *)
            timer1.IN := FALSE;
        END_IF
    END_IF
ELSE
    (* Main sequence state machine when not in lockout *)
    IF state = 110 THEN
        (* Standby *)
        STATUS := 110;
        (* Wait for start command and no over-temp *)
        IF IN AND NOT OVER_TEMP THEN
            (* Start pre-heat phase *)
            state := 111;
            PRE_HEAT := TRUE;
            timer1.IN := TRUE;
            timer1.PT := PRE_HEAT_TIME;
        END_IF

    ELSIF state = 111 THEN
        (* Pre-heat *)
        STATUS := 111;
        PRE_HEAT := TRUE;

        (* Fault if flame detected during pre-heat *)
        IF FLAME THEN
            FAIL := TRUE;
            STATUS := 2;
            state := 1000;
            (* Start lockout timer *)
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        ELSIF OIL_TEMP THEN
            (* Oil temperature reached: proceed to motor pre-ventilation *)
            PRE_HEAT := FALSE;
            state := 115;
            MOTOR := TRUE;
            (* Determine ignition lead time (clamped to PRE_VENT_TIME) *)
            tx := PRE_IGNITE_TIME;
            IF tx > PRE_VENT_TIME THEN
                tx := PRE_VENT_TIME;
            END_IF
            (* First pre-ventilation interval: until ignition turn-on *)
            timer1.IN := TRUE;
            timer1.PT := PRE_VENT_TIME - tx;
        ELSIF timer1.Q AND (NOT OIL_TEMP) THEN
            (* Pre-heat timeout without oil temp *)
            FAIL := TRUE;
            STATUS := 1;
            state := 1000;
            (* Start lockout timer *)
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        END_IF

    ELSIF state = 115 THEN
        (* Pre-ventilation part 1: fan only until ignition turn-on *)
        STATUS := 111;
        MOTOR := TRUE;
        (* Fault if flame during aeration *)
        IF FLAME THEN
            FAIL := TRUE;
            STATUS := 3;
            state := 1000;
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        ELSIF timer1.Q THEN
            (* Turn on ignition and wait remaining time to open valve *)
            state := 116;
            MOTOR := TRUE;
            IGNITE := TRUE;
            (* tx holds the ignition lead time *)
            timer1.IN := TRUE;
            timer1.PT := tx;
        END_IF

    ELSIF state = 116 THEN
        (* Pre-ventilation part 2: ignition running, waiting to open valve *)
        STATUS := 111;
        MOTOR := TRUE;
        IGNITE := TRUE;
        (* Fault if flame during aeration *)
        IF FLAME THEN
            FAIL := TRUE;
            STATUS := 3;
            state := 1000;
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        ELSIF timer1.Q THEN
            (* Open oil valve and start safety timer *)
            state := 130;
            MOTOR := TRUE;
            COIL1 := TRUE;
            IGNITE := TRUE;
            timer1.IN := TRUE;
            timer1.PT := SAFETY_TIME;
        END_IF

    ELSIF state = 130 THEN
        (* Oil valve open, safety time for flame establishment *)
        STATUS := 111;
        MOTOR := TRUE;
        COIL1 := TRUE;
        IGNITE := TRUE;

        IF FLAME THEN
            (* Successful flame: go to Stage 1 run *)
            state := 112;
            CYCLES := CYCLES + 1;
            cycles2 := RUNTIME1; (* snapshot for Stage2 delay *)
            (* Begin post-ignition hold *)
            timer1.IN := TRUE;
            timer1.PT := POST_IGNITE_TIME;
        ELSIF timer1.Q THEN
            (* Safety time expired without flame *)
            FAIL := TRUE;
            STATUS := 4;
            state := 1000;
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        END_IF

    ELSIF state = 112 THEN
        (* Burner runs on Stage 1 *)
        STATUS := 112;
        MOTOR := TRUE;
        COIL1 := TRUE;
        (* Post-ignition handling *)
        IF NOT timer1.Q THEN
            IGNITE := TRUE;
        ELSE
            IGNITE := FALSE;
            timer1.IN := FALSE; (* stop post-ignition timer once complete *)
        END_IF

        (* Stage 2 auto activation after delay when requested *)
        IF STAGE2 THEN
            IF (RUNTIME1 >= cycles2 + (TIME_TO_UDINT(STAGE2_DELAY) / 1000)) THEN
                state := 113;
                (* keep IGNITE as per post-ignition timer state *)
            END_IF
        END_IF

        (* Flame loss handling *)
        IF NOT FLAME THEN
            IF MULTIPLE_IGNITION THEN
                state := 160; (* Re-ignition Stage 1 *)
                IGNITE := TRUE;
                timer1.IN := TRUE;
                timer1.PT := SAFETY_TIME;
            ELSE
                FAIL := TRUE;
                STATUS := 5;
                state := 1000;
                timer1.IN := TRUE;
                timer1.PT := LOCKOUT_TIME;
            END_IF
        END_IF

    ELSIF state = 113 THEN
        (* Burner runs on Stage 2 *)
        STATUS := 113;
        MOTOR := TRUE;
        COIL1 := TRUE;
        COIL2 := TRUE;
        (* Post-ignition handling continues if active *)
        IF NOT timer1.Q THEN
            IGNITE := TRUE;
        ELSE
            IGNITE := FALSE;
            timer1.IN := FALSE;
        END_IF

        (* Allow dropping back to Stage 1 if STAGE2 request is removed *)
        IF NOT STAGE2 THEN
            state := 112;
        END_IF

        (* Flame loss handling *)
        IF NOT FLAME THEN
            IF MULTIPLE_IGNITION THEN
                state := 161; (* Re-ignition Stage 2 *)
                IGNITE := TRUE;
                timer1.IN := TRUE;
                timer1.PT := SAFETY_TIME;
            ELSE
                FAIL := TRUE;
                STATUS := 5;
                state := 1000;
                timer1.IN := TRUE;
                timer1.PT := LOCKOUT_TIME;
            END_IF
        END_IF

    ELSIF state = 160 THEN
        (* Re-ignition attempt on Stage 1 *)
        STATUS := 112;
        MOTOR := TRUE;
        COIL1 := TRUE;
        IGNITE := TRUE;
        IF FLAME THEN
            (* Flame re-established: continue run with post-ignition *)
            state := 112;
            timer1.IN := TRUE;
            timer1.PT := POST_IGNITE_TIME;
        ELSIF timer1.Q THEN
            (* Re-ignition failed *)
            FAIL := TRUE;
            STATUS := 5;
            state := 1000;
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        END_IF

    ELSIF state = 161 THEN
        (* Re-ignition attempt on Stage 2 *)
        STATUS := 113;
        MOTOR := TRUE;
        COIL1 := TRUE;
        COIL2 := TRUE;
        IGNITE := TRUE;
        IF FLAME THEN
            (* Flame re-established: continue run with post-ignition *)
            state := 113;
            timer1.IN := TRUE;
            timer1.PT := POST_IGNITE_TIME;
        ELSIF timer1.Q THEN
            (* Re-ignition failed *)
            FAIL := TRUE;
            STATUS := 5;
            state := 1000;
            timer1.IN := TRUE;
            timer1.PT := LOCKOUT_TIME;
        END_IF
    END_IF
END_IF

(* Second counter and energy metering *)
(* Generate 1-second tick while burner is in either stage or during re-ignition attempts *)
timer2.PT := T#1s;
IF (state = 112) OR (state = 113) OR (state = 160) OR (state = 161) THEN
    timer2.IN := NOT timer2.Q;
ELSE
    timer2.IN := FALSE;
END_IF

(* Execute timers *)
timer1();
timer2();

(* On 1-second tick, accumulate runtimes and energy *)
IF timer2.Q THEN
    IF (state = 112) OR (state = 160) THEN
        RUNTIME1 := RUNTIME1 + 1;
        KWH := KWH + (KW1 / 3600.0);
    ELSIF (state = 113) OR (state = 161) THEN
        RUNTIME2 := RUNTIME2 + 1;
        KWH := KWH + (KW2 / 3600.0);
    END_IF
END_IF

(* Update previous RST state for rising edge detection *)
oil_temp_last := RST;