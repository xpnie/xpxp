FUNCTION_BLOCK FB_FindNumberWithAbort
VAR CONSTANT
    MAXNUMBERS : UINT := 99;
END_VAR
VAR
    aNumbers : ARRAY[0..MAXNUMBERS] OF INT; // Input list of numbers (0..99)
    nCnt : INT;                             // Index/result: 0..99 if found; 100 if not found
END_VAR

// Initialize index
nCnt := 0;

// Search through the list with two abort conditions:
// 1) EXIT when number 10 is found.
// 2) Terminate when end of list is reached (nCnt > MAXNUMBERS).
REPEAT
    IF aNumbers[nCnt] = 10 THEN
        EXIT;
    END_IF
    nCnt := nCnt + 1;
UNTIL nCnt > INT(MAXNUMBERS) END_REPEAT;