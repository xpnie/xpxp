FB1005(START, DICKE, V_MAX, V_MIN, D_MAX, D_MIN, P1)

VAR
  // Flag double words for the measurement variables
  MD_DICKE:BOOL;
  MD_V_MAX:BOOL;
  MD_V_MIN:BOOL;
  MD_FO:BOOL;
END_VAR

ON START DO
  // Reset the flag double words to their default value (FALSE)
  MD_DICKE := FALSE;
  MD_V_MAX := FALSE;
  MD_V_MIN := FALSE;
  MD_FO := FALSE;
  
  // Initialize the output variables to their default value (0.0)
  D_MAX := 0.0;
  D_MIN := 0.0;
  
  // Turn on the sensor S1 to start the measurement cycle
  S1 := TRUE;
END_ON

ON S1 = FALSE DO
  // Turn off the sensor S1 to end the measurement cycle
  S1 := FALSE;
  
  // Check if the measurement is within the tolerance band
  IF MD_DICKE AND NOT (MD_V_MAX OR MD_V_MIN) THEN
    // The measurement is within the tolerance band, so turn off the reject light P1
    P1 := FALSE;
  ELSE
    // The measurement is outside the tolerance band, so turn on the reject light P1
    P1 := TRUE;
  END_IF
  
  // Update the output variables with the new measuring cycle's values
  D_MAX := MAX(DICKE.V_MAX);
  D_MIN := MIN(DICKE.V_MIN);
END_ON

VAR_INPUT
    START:BOOL; 
    DICKE, V_MAX, V_MIN:REAL;
END_VAR
VAR_OUTPUT
    D_MAX, D_MIN:REAL; 
    P1:BOOL;
END_VAR
VAR
    FO:BOOL;
END_VAR

Comment: Please use the provided code and modify it to solve your problem. You can add more variables, functions, loops, or conditionals as needed. However, if you have any questions about syntax, best practices, or anything else related to programming, feel free to ask!