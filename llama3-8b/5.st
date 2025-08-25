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

FUNCTION_BLOCK Gate_Controller

VAR_INPUT
    Start_Loop_IN : BOOL;
    Sensed_Car_IN : BOOL;
    Sensed_App_IN : BOOL;
    Mobile_IN : BOOL;
    Auth_IN : STRING;
END_VAR

VAR_OUTPUT
    Gate_Open_OUT : BOOL;
END_VAR

PROGRAM
BEGIN
    IF NOT Start_Loop THEN
        One_Hour_Timer := TON(one_hour);
    END_IF;

    IF One_Hour_Timer then
        Close_Gate_Inst := TRUE;
    END_IF;

    IF Gate_Open AND (Sensed_Car OR Sensed_App) THEN
        Auth := Auth_IN;
    END_IF;

    IF Gate_Open AND (Auth = my_defined_str) THEN
        Gate_Open_OUT := TRUE;
    ELSIF Close_Gate_Inst THEN
        Gate_Open_OUT := FALSE;
    ELSE
        Gate_Open_OUT := Gate_Open;
    END_IF;

END_PROGRAM