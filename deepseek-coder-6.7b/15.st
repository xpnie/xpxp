plc
PROGRAM FC1002
VAR_INPUT
	E_A, SENSOR: BOOL; // Input switch and sensor states
END_VAR
VAR
	ZEIT:TON; // Timer to measure time
	ALARM :BOOL; // Flag for alarm state
	TEMP_HU, TEMP_AL:BOOL; // Temporary variables for P_HU and P_AL
END_VAR
VAR_OUTPUT
	P_HU, P_AL: BOOL; // Output states of horn and alarm
END_VAR
BEGIN
	// Initialize the timer and output states at start
	ZEIT(IN:= E_A); 
	TEMP_HU := FALSE;
	TEMP_AL := FALSE;

	// Check if sensor detects approaching object or person
	IF SENSOR = TRUE THEN
		// If detected, turn on TEMP_HU and start timer
		TEMP_HU := TRUE; 
		ZEIT(P:= TRUE);
		
		// Turn off alarm if exists
		TEMP_AL := FALSE;

		// Check if the detection persists for more than 3 seconds
		IF ZEIT.Q THEN 
			TEMP_HU := FALSE; // If yes, turn off TEMP_HU
			TEMP_AL := TRUE; // and activate alarm
		END_IF
	ELSE // If no detection, reset timer and alarm (if any)
		ZEIT(P:= FALSE); 
		TEMP_AL := FALSE;
	END_IF;

	// Assign temporary variables to output states
	P_HU := TEMP_HU; 
	P_AL := TEMP_AL;
END_PROGRAM