FUNCTION FC1001 : BOOL
VAR_INPUT
	MEW: REAL; // Measured value
	SP: REAL;  // Switching value (setpoint)
	HYS: REAL; // Hysteresis in percent of |SP|
END_VAR
VAR_IN_OUT
 	OUT:BOOL;  // Latched output state
END_VAR
VAR
 	P_HYS: REAL; // Absolute hysteresis value derived from percent
END_VAR

// Calculate absolute hysteresis; ensure non-negative percentage
IF HYS < 0.0 THEN
	P_HYS := 0.0;
ELSE
	P_HYS := ABS(SP) * HYS * 0.01;
END_IF

// Hysteresis behavior:
// - Turn ON when measured value exceeds SP
// - Turn OFF when measured value falls below SP - P_HYS
// - Otherwise, retain previous state to avoid fluttering
IF MEW > SP THEN
	OUT := TRUE;
ELSIF MEW < (SP - P_HYS) THEN
	OUT := FALSE;
END_IF

// Function result mirrors the output state
FC1001 := OUT;
RETURN;