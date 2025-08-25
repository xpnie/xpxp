FUNCTION_BLOCK INTERLOCK
VAR_INPUT
    I1 : BOOL;
    I2 : BOOL;
    TL : TIME;
END_VAR
VAR_OUTPUT
    Q1 : BOOL;
    Q2 : BOOL;
END_VAR
VAR
    T1 : TOF;
    T2 : TOF;
END_VAR

(* Clamp the dead time to a minimum of 0 ms *)
IF TL < T#0ms THEN
    T1.PT := T#0ms;
    T2.PT := T#0ms;
ELSE
    T1.PT := TL;
    T2.PT := TL;
END_IF;

(* Timers monitor the opposite output to enforce dead time after switch-off *)
T1.IN := Q2; (* Blocks Q1 while Q2 is TRUE or has been TRUE within TL *)
T2.IN := Q1; (* Blocks Q2 while Q1 is TRUE or has been TRUE within TL *)

(* Execute timers *)
T1();
T2();

(* Interlock logic with deterministic priority to Q1 when both are eligible *)
IF (I1 AND NOT T1.Q) THEN
    Q1 := TRUE;
    Q2 := FALSE;
ELSIF (I2 AND NOT T2.Q) THEN
    Q1 := FALSE;
    Q2 := TRUE;
ELSE
    Q1 := FALSE;
    Q2 := FALSE;
END_IF;