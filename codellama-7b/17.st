

VAR
    aiOutside : INT;
    aiHumidity: INT;
    sShowText : STRING[80];
END_VAR
FUNCTION_BLOCK FuncTempDisplay
    VAR_INPUT
        aiOutside : INT;
        aiHumidity: INT;
    END_VAR_INPUT
    
    VAR_OUTPUT
        sShowText : STRING[80];
    END_VAR_OUTPUT
    
    BEGIN
        
        IF (aiOutside < 18) THEN
            sShowText := 'Cold';
        ELSIF (aiOutside >= 18 AND aiOutside <= 25) THEN
            sShowText := 'Opt';
        ELSE
            sShowText := 'Hot';
        END_IF;
        
        IF (aiHumidity >= 40 AND aiHumidity <= 75) THEN
            IF (sShowText = 'Opt') THEN
                sShowText := 'Opt';
            ELSE
                sShowText := 'Temp. OK';
            END_IF;
        ELSE
            sShowText := 'Temp. OK';
        END_IF;
        
    END_FUNCTION_BLOCK