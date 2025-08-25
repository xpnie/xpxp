FUNCTION_BLOCK FB_AlarmManager
VAR
	xAllOn : BOOL;
	xAllOff : BOOL;

	xAlarm1 : BOOL;
    xAlarm2 : BOOL;
END_VAR

IF xAllOff THEN
	xAlarm1 := FALSE;
	xAlarm2 := FALSE;
	xAllOff := FALSE;
	xAllOn := FALSE;
ELSIF xAllOn THEN
	xAlarm1 := TRUE;
	xAlarm2 := TRUE;
	xAllOn := FALSE;
END_IF

END_FUNCTION_BLOCK