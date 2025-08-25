FUNCTION_BLOCK FB_WeatherStation
VAR
    aiOutside : INT;       // Outside temperature [°C], read from analog input
    aiHumidity: INT;       // Relative humidity [%]
    sShowText : STRING[80];// Display text for house
END_VAR

// Temperature classification with nested humidity evaluation
IF aiOutside < 18 THEN
    // Below comfort temperature
    sShowText := 'Cold';
ELSIF aiOutside > 25 THEN
    // Above comfort temperature
    sShowText := 'Hot';
ELSE
    // Temperature within 18..25°C: evaluate humidity
    IF (aiHumidity >= 40) AND (aiHumidity <= 75) THEN
        sShowText := 'Opt';
    ELSE
        sShowText := 'Temp. OK';
    END_IF
END_IF