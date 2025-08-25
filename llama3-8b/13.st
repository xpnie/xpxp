VAR 
    nCnt : INT;
    nMaxNumber : UINT := 99;
    nSelectedNumber : INT;
    bFound : BOOL;
END_VAR

VAR_INPUT
    aNumbers : ARRAY[0..nMaxNumber] OF INT;
END_VAR

VAR_OUTPUT
    nSelectedNumber : INT;
    bFound : BOOL;
END_VAR

DO 
    nCnt := 0;
    bFound := FALSE;
    
    REPEAT 
        IF NOT bFound THEN
            nCnt := nCnt + 1;
            IF aNumbers[nCnt] = 10 THEN
                bFound := TRUE;
                EXIT;
            END_IF;            
        END_IF;
        
        UNTIL nCnt > nMaxNumber OR bFound;

    IF bFound THEN 
        nSelectedNumber := 10;
    ELSE 
        nSelectedNumber := -1; // or any other value indicating "not found"
    END_IF;
END_DO