FUNCTION_BLOCK FB_GateController
VAR
    Start_Loop : BOOL := FALSE;
    one_hour : TIME := T#1h;
    One_Hour_Timer : TON;
    Gate_Open : BOOL := FALSE;
    Close_Gate_Inst : BOOL := FALSE;
    Sensed_Car : BOOL := FALSE;
    Sensed_Car_Inst : BOOL := FALSE;
    Sensed_App : BOOL := FALSE;
    Mobile_Inst : BOOL := FALSE;
    Auth : STRING;
    my_defined_str : STRING := 'abcd';
END_VAR

(* Start the one-hour timer when Start_Loop is FALSE *)
One_Hour_Timer(IN := NOT Start_Loop, PT := one_hour);

(* Open gate on valid authorization and presence of app or car *)
IF (Auth = my_defined_str) THEN
    IF (Sensed_App OR Sensed_Car) THEN
        Gate_Open := TRUE;
    END_IF
END_IF

(* Close gate on timer timeout (use Sensed_Car_Inst as previous Q memory for rising edge) *)
IF (One_Hour_Timer.Q AND NOT Sensed_Car_Inst) THEN
    IF Gate_Open THEN
        Close_Gate_Inst := TRUE;
        Gate_Open := FALSE;
    ELSE
        Close_Gate_Inst := FALSE;
    END_IF
    Sensed_Car_Inst := TRUE;
ELSE
    Close_Gate_Inst := FALSE;
    IF NOT One_Hour_Timer.Q THEN
        Sensed_Car_Inst := FALSE;
    END_IF
END_IF