plc
PROGRAM SignFunction
VAR
    x : REAL; // input variable
END_VAR

FUNCTION_BLOCK FB_Sign
VAR_INPUT
    a : REAL;
END_VAR

VAR_OUTPUT
    result : INT; 
END_VAR
END_FUNCTION_BLOCK

// Main function block where the program starts
FUNCTION_BLOCK FB_Main
VAR_INPUT
    x : REAL; // input variable
END_VAR

VAR_OUTPUT
    signValue : INT; 
END_VAR
END_FUNCTION_BLOCK