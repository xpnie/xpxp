FUNCTION_BLOCK FB_TrafficLight
VAR
    North_green : BOOL;
    North_yellow : BOOL;
    North_red : BOOL;
    East_green : BOOL;
    East_yellow : BOOL;
    East_red : BOOL;
    T1 : TON;
END_VAR

(* Free-running 10s cycle using TON *)
T1(IN := NOT T1.Q, PT := T#10s);

(* Default all off *)
North_green := FALSE;
North_yellow := FALSE;
North_red := FALSE;
East_green := FALSE;
East_yellow := FALSE;
East_red := FALSE;

(* Phase selection based on elapsed time *)
IF (T1.ET < T#5s) THEN
    (* 0ms - 5000ms *)
    North_green := TRUE;
    East_red := TRUE;
ELSIF (T1.ET < T#5500ms) THEN
    (* 5000ms - 5500ms *)
    North_yellow := TRUE;
    East_red := TRUE;
ELSIF (T1.ET < T#9500ms) THEN
    (* 5500ms - 9500ms *)
    North_red := TRUE;
    East_green := TRUE;
ELSE
    (* 9500ms - 10000ms *)
    North_red := TRUE;
    East_yellow := TRUE;
END_IF;

END_FUNCTION_BLOCK