plc
PROGRAM MyProgram
VAR
    // Global Variables
	xAllOn : BOOL;
	xAlarm1: BOOL := FALSE;
	xAlarm2: BOOL := FALSE;
	xAllOff: BOOL;
END_VAR

// Initialize your variables here (if any)
// For example, xAllOn := TRUE;

FUNCTION_BLOCK FbUpdateAlarms
VAR_INPUT 
    inAlarm1: BOOL;
    inAlarm2: BOOL;
END_VAR
VAR_OUTPUT 
    outAlarm1 : BOOL;
    outAlarm2 : BOOL;
END_VAR
BEGIN
    // Update the alarms based on the input values
    IF (inAlarm1 = TRUE) THEN 
        outAlarm1 := TRUE;
    END_IF;
    
    IF (inAlarm2 = TRUE) THEN 
        outAlarm2 := TRUE;
    END_IF;
END_FUNCTION_BLOCK

// Create a new FB for updating alarms
FbUpdateAlarms(xAllOn, xAllOff, xAlarm1, xAlarm2);