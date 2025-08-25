plaintext
PROGRAM TrafficLightProgram
VAR
    // Inputs
	VAR_INPUT
        Timer : UDINT; (* Global timer, should be running and updating every 1ms *)
    END_VAR
    
    VAR_OUTPUT
        North_green : BOOL;
        North_yellow : BOOL;
        North_red : BOOL;
        East_green : BOOL;
        East_yellow : BOOL;
        East_red : BOOL;
    END_VAR
    
END_VAR

IF Timer > 0 AND Timer < 500 THEN (* 1st cycle: North light is green, East light is red *)
    North_green := TRUE;
    North_yellow := FALSE;
    North_red := FALSE;
    East_green := FALSE;
    East_yellow := FALSE;
    East_red := TRUE;
ELSIF Timer > 500 AND Timer < 950 THEN (* 2nd cycle: Yellow light for North *)
    North_green := FALSE;
    North_yellow := TRUE;
    North_red := FALSE;
    East_green := FALSE;
    East_yellow := FALSE;
    East_red := TRUE;
ELSIF Timer > 950 AND Timer < 1000 THEN (* 3rd cycle: North light is red, East light is green *)
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := TRUE;
    East_green := TRUE;
    East_yellow := FALSE;
    East_red := FALSE;
ELSIF Timer > 1000 AND Timer < 1500 THEN (* 4th cycle: Yellow light for East *)
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := TRUE;
    East_green := FALSE;
    East_yellow := TRUE;
    East_red := FALSE;
ELSE (* Reset all lights at the end of cycle *)
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := FALSE;
    East_green := FALSE;
    East_yellow := FALSE;
    East_red := TRUE;
END_IF;
END_PROGRAM