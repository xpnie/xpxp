plc
PROGRAM Sigmoid
VAR
    // Input variable for input data X
    input : REAL; END_VAR
    
    // Output variable for result Y
    output : REAL; END_VAR
END_VAR
    // Variables used in the sigmoid calculation 
    temp1, temp2: REAL; 
    numerator: LREAL;
    denominator: LREAL;
    
BEGIN
    // Calculation of sigmoid value
    temp1 := EXP(input);
    temp2 := 1 + temp1;
        
    numerator := temp1;
    denominator := temp2 * temp2;
     
    output := numerator / denominator; 
END_PROGRAM