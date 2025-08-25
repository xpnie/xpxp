plaintext
PROGRAM MyProgram
VAR
    VAR_INPUT
        Start_Loop : BOOL; // start the timer when this is false
        Sensed_Car : BOOL; 
        Sensed_App : BOOL;
        Auth : STRING(10); // max length of 10 chars, adjust as necessary
    END_VAR
    
    VAR_OUTPUT
        Gate_Open : BOOL; // indicates whether the gate is open
        Close_Gate_Inst : BOOL; // set this to TRUE when you want to close the gate manually
    END_VAR
    
    CONSTANT
        my_defined_str : STRING(4) := 'abcd'; 
    END_CONSTANT
        
    VAR
        one_hour : TIME := T#1h; // time span of 1 hour
        One_Hour_Timer : TON; // timer that will reset after 1 hour
    END_VAR
END_PROGRAM