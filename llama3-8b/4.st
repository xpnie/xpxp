VAR
    aiLevel : INT;
    PercentLevel : UINT;
    doLow : BOOL;
    doOk : BOOL;
    doHigh : BOOL;
    doAlarm : BOOL;
END_VAR

PROGRAM FillLevelCheck
    VAR_INPUT
        level : INT
    END_VAR

    CASE
        WHEN level < 327 && level > 0 THEN
            PercentLevel := (level * 100) / 32767
        ELSE
            PercentLevel := 0
    END_CASE

    CASE
        WHEN PercentLevel <= 1 THEN
            doAlarm := TRUE
            doLow := FALSE
            doOk := FALSE
            doHigh := FALSE
        WHEN PercentLevel > 1 && PercentLevel <= 66.67 THEN
            doOk := TRUE
            doLow := FALSE
            doAlarm := FALSE
            doHigh := FALSE
        WHEN PercentLevel > 66.67 THEN
            doHigh := TRUE
            doLow := FALSE
            doOk := FALSE
            doAlarm := FALSE
    END_CASE

END_PROGRAM