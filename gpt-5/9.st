FUNCTION_BLOCK FB_LeapYearCheck
VAR_INPUT
    YEAR : INT;
END_VAR
VAR_OUTPUT
    IsLeapYear : BOOL;
END_VAR

IF YEAR > 0 THEN
    IF YEAR MOD 4 = 0 THEN
        IF YEAR MOD 100 = 0 THEN
            IF YEAR MOD 400 = 0 THEN
                IsLeapYear := TRUE;
            ELSE
                IsLeapYear := FALSE;
            END_IF
        ELSE
            IsLeapYear := TRUE;
        END_IF
    ELSE
        IsLeapYear := FALSE;
    END_IF
ELSE
    IsLeapYear := FALSE;
END_IF