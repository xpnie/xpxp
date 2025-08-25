VAR
	xAllOn : BOOL;
	xAllOff : BOOL;
	xAlarm1 : BOOL;
	xAlarm2 : BOOL;
END_VAR

PROGRAM
	IF (xAllOn) THEN
		xAlarm1 := TRUE;
		xAlarm2 := TRUE;
	END_IF;

	IF (xAllOff) THEN
		xAlarm1 := FALSE;
		xAlarm2 := FALSE;
	END_IF;
END_PROGRAM;