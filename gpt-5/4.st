FUNCTION_BLOCK FB_FillLevelCheck
VAR
    aiLevel : INT;
    PercentLevel : UINT;
    doLow : BOOL;
    doOk : BOOL;
    doHigh : BOOL;
    doAlarm : BOOL;
END_VAR

(* Scale raw input (0..32767) to 0..100% with clamping *)
IF aiLevel <= 0 THEN
    PercentLevel := 0;
ELSIF aiLevel >= 32767 THEN
    PercentLevel := 100;
ELSE
    PercentLevel := UINT((UDINT(aiLevel) * UDINT(100)) / UDINT(32767));
END_IF
END_IF

(* Alarm if below 1% *)
doAlarm := (PercentLevel < 1);

(* Default outputs *)
doLow := FALSE;
doOk := FALSE;
doHigh := FALSE;

(* Range classification using CASE *)
CASE PercentLevel OF
    0..20:
        doLow := TRUE;
    21..80:
        doOk := TRUE;
    81..100:
        doHigh := TRUE;
ELSE
    (* Should not occur due to clamping above *)
END_CASE
END_FUNCTION_BLOCK