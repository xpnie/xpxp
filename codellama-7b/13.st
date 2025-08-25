VAR CONSTANT
    MAXNUMBERS : UINT := 99;
END_VAR
VAR
    aNumbers : ARRAY[0..MAXNUMBERS] OF INT;
    nCnt : INT;
END_VAR
REPEAT
    FOR nCnt := 0 TO MAXNUMBERS - 1 DO
        IF aNumbers[nCnt] = 10 THEN
            EXIT;
        END_IF;
    END_FOR;
UNTIL nCnt = MAXNUMBERS;
IF nCnt < MAXNUMBERS THEN
    EXIT;
END_IF;
VAR_OUTPUT
    selectedNumber : INT := aNumbers[nCnt];
END_VAR;
