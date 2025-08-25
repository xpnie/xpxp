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
    state : INT := 110; // standby
    last : TIME;
    tx : TIME;
    last_change : TIME;
    timer1 : TON;
    timer2 : TON;
    oil_temp_last : BOOL;
    cycles2 : UDINT;
END_VAR

PROGRAM
BEGIN
    PRE_HEAT := FALSE;
    IGNITE := FALSE;
    MOTOR := FALSE;
    COIL1 := FALSE;
    COIL2 := FALSE;
    FAIL := FALSE;
    KWH := 0;
    
    WHILE TRUE DO
        IF NOT OVER_TEMP AND IN THEN
            state := 111; // startup sequence
            PRE_HEAT := TRUE;
            timer1 := t#0s;
        END_IF;
        
        IF PRE_HEAT AND OIL_TEMP THEN
            state := 112; // burner runs on stage 1
            MOTOR := TRUE;
            timer2 := t#0s;
        END_IF;
        
        IF NOT FLAME AND timer2 > PRE_VENT_TIME THEN
            FAIL := TRUE;
            STATUS := 3;
        END_IF;
        
        IF FLAME AND timer1 > SAFETY_TIME THEN
            FAIL := TRUE;
            STATUS := 4;
        END_IF;
        
        IF RST THEN
            state := 110; // standby
            last_change := t#0s;
        END_IF;
        
        IF NOT OVER_TEMP AND RST_TIMER AND timer2 > LOCKOUT_TIME THEN
            state := 110; // standby
            last_change := t#0s;
        END_IF;
        
        IF MULTIPLE_IGNITION AND FLAME THEN
            IGNITE := TRUE;
            timer1 := t#0s;
        END_IF;
        
        IF STAGE2 AND state = 112 THEN
            state := 113; // burner runs at stage 2
            COIL2 := TRUE;
        END_IF;
        
        IF NOT FLAME AND timer1 > POST_IGNITE_TIME THEN
            IGNITE := FALSE;
            MOTOR := FALSE;
            COIL1 := FALSE;
            COIL2 := FALSE;
        END_IF;
        
    END_WHILE;

END_PROGRAM;