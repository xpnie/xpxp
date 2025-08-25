// Function block to control two alarms represented by xAlarm1 and xAlarm2 using the signals xAllOn and xAllOff.
FUNCTION_BLOCK AlarmController
VAR
	xAllOn : BOOL;
	xAllOff : BOOL;

	xAlarm1 : BOOL;
    xAlarm2 : BOOL;
END_VAR

IF (xAllOn) THEN
	xAlarm1 := TRUE;
	xAlarm2 := TRUE;
ELSIF (xAllOff) THEN
	xAlarm1 := FALSE;
	xAlarm2 := FALSE;
ELSE
	// Do nothing.
END_IF

// Return to the main method.
RETURN;