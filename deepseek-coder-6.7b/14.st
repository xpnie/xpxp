plc
PROGRAM Program0
VAR_GLOBAL
    MEW : REAL; // Measured External Working Value (input)
    SP : REAL;  // Set Point (predetermined value to switch on/off OUT)
    HYS : REAL; // Hysteresis in % of SP (predetermined value)
    OUT : BOOL; // Output (output)
END_VAR

FUNCTION FC1001 : BOOL
// This function compares MEW with SP considering the hysteresis. 
// If MEW is within HYS% of SP, the function returns TRUE else FALSE.
VAR
    P_HYS: REAL; // Proportional Hysteresis Value
END_VAR
BEGIN
    // Calculate the proportional hysteresis value
    P_HYS := SP * (1 + HYS/100); 
    
    // Compare MEW with the set point considering the hysteresis
    IF (MEW >= (SP - P_HYS)) AND (MEW <= (SP + P_HYS)) THEN
        FC1001 := TRUE; // Return TRUE if MEW is within SP ± HYS%
    ELSE
        FC1001 := FALSE; // Else return FALSE
    END_IF;
END_FUNCTION

PROGRAM main (*TODO: Add your comment *)
BEGIN
   // Initialisation of variables.
   MEW := 0.0; 
   SP := 50.0;
   HYS := 10.0;
   
   OUT := FC1001(MEW,SP,HYS); // Invoke the function and assign its return value to OUT variable.
END_PROGRAM