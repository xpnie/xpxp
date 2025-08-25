VAR
    aiLevel: INT;
    PercentLevel: UINT;
    doLow: BOOL;
    doOk: BOOL;
    doHigh: BOOL;
    doAlarm: BOOL;
END_VAR

PROGRAM filllevelcheck
// convert the input level to a percentage value between 0 and 100
PercentLevel := INT (aiLevel / 32767.0 * 100);
// check for low, ok, and high levels
CASE PercentLevel OF
    // low level case
    0..30:
        doLow := TRUE;
        doOk := FALSE;
        doHigh := FALSE;
    // ok level case
    31..70:
        doLow := FALSE;
        doOk := TRUE;
        doHigh := FALSE;
    // high level case
    71..100:
        doLow := FALSE;
        doOk := FALSE;
        doHigh := TRUE;
END_CASE
// check for alarm condition
IF PercentLevel <= 1 THEN
    doAlarm := TRUE;
END_IF;
ENDPROGRAM