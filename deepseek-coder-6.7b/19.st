plaintext
PROGRAM Program1

FUNCTION_BLOCK FB1005
    (* VARIABLES DECLARATION *)
    VAR_INPUT
        START : BOOL;   // Start input for measurement cycle 
        DICKE, V_MAX, V_MIN: REAL;  // Plate thickness and tolerance band values
    END_VAR
    
    VAR_OUTPUT
        D_MAX, D_MIN: REAL;  // Outputs for the maximum (D_MAX) and minimum (D_MIN) plate thickness
        P1: BOOL;   // Reject light P1 output
    END_VAR
    
    VAR
        FO: BOOL;  // Flag to indicate if a measurement is currently ongoing
        M_MAX, M_MIN : REAL;  // Maximum and minimum plate thickness during measurement cycle
    END_VAR
END_FUNCTION_BLOCK

(* FUNCTION BLOCK IMPLEMENTATION *)
PROGRAM Main
BEGIN
    (* Initialization of function block FB1005 *)
    FB1005(START := FALSE, DICKE := 0.0, V_MAX := 0.0, V_MIN := 0.0); 
    
    (* Program main loop *)
    WHILE TRUE DO
        IF FB1005.START = TRUE THEN
            FO := TRUE;   // Start a measurement cycle
            
            M_MAX := DICKE;  // Initialize maximum plate thickness to current measured value
            M_MIN := DICKE;  // Initialize minimum plate thickness to current measured value
        END_IF;
        
        IF FO = TRUE THEN    // If a measurement cycle is ongoing
            FB1005.D_MAX := M_MAX;   // Output the maximum plate thickness
            FB1005.D_MIN := M_MIN;   // Output the minimum plate thickness
            
            IF (M_MAX > V_MAX) OR (M_MIN < V_MIN) THEN  // If current measurement violates tolerance band
                FB1005.P1 := TRUE;    // Switch on reject light P1
            END_IF;
        ELSE   // Else if no measurement cycle is ongoing, reset outputs
            FB1005.D_MAX := 0.0;
            FB1005.D_MIN := 0.0;
            FB1005.P1 := FALSE;
        END_IF;
        
        // Update maximum and minimum plate thickness for next measurement cycle
        M_MAX := MAX(M_MAX, DICKE);   
        M_MIN := MIN(M_MIN, DICKE); 
    END_WHILE;
END PROGRAM