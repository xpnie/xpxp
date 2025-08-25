plc
PROGRAM MainProgram
VAR
    aNumbers: ARRAY [0..99] OF INT := [123, 456, 789, ...]; (* Array of random numbers *)
    nCnt: INT;                                         (* Loop counter *)
END_VAR

BEGIN
    FOR nCnt := 0 TO MAXNUMBERS DO                      (* Initialize array with random values *)
        aNumbers[nCnt] := RANDOM(1, 5000);
    END_FOR
    
    nCnt := 0;                                          (* Reset counter for loop *)
    
    REPEAT                                            (* Loop to search for number *)
        IF aNumbers[nCnt] = 10 THEN                     (* Abort condition 1: found the number *)
            EXIT;
        END_IF
        
        IF nCnt = MAXNUMBERS THEN                       (* Abort condition 2: reached end of list *)
            EXIT;
        END_IF
        
        nCnt := nCnt + 1;                              (* Increment counter *)
    UNTIL
        TRUE;                                           (* This is always true, so the loop will exit when one of the conditions are met *)
    END_REPEAT
    
    IF aNumbers[nCnt] <> 10 AND nCnt <> MAXNUMBERS THEN(* Check if we exited due to reaching end of list *)
        (* Number 10 not found in array, do something else. e.g., Display message *)
        PRINT 'Number 10 was not found.'
    END_IF;
END_PROGRAM