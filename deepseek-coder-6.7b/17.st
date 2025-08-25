PLC
PROGRAM WeatherStationProgram
VAR
    // Variables for temperature and humidity
    aiOutside : INT;   // Analog input for outside temperature
    aiHumidity: INT;  // Analog input for humidity
    
    // String variable to display the text message
    sShowText : STRING(80);
END_VAR

// Main program function
FUNCTION WeatherStationProgram : BOOL
BEGIN
    CASE aiOutside OF
        1..17:   sShowText := 'Cold';  // If temperature is below 18°C
        18..25:  sShowText := 'Opt';   // If temperature is between 18°C and 25°C
        ELSE:    sShowText := 'Hot';   // If temperature is above 25°C
    END_CASE
    
    CASE aiHumidity OF                   // Nested case for humidity
        40..75 WHEN EQUAL aiOutside:18..25, (OTHERS) : sShowText := 'Opt';  // If temperature is between 18°C and 25°C and humidity is between 40% and 75%, display "Opt"
        ELSE:                                  // Otherwise, for other cases of humidity and temperature
            CASE aiOutside OF
                1..17:   sShowText := 'Temp. OK';  // If temperature is below 18°C
                ELSE:    sShowText := 'Temp. OK';  // If temperature is above 25°C
            END_CASE
        (OTHERS) : sShowText := 'Invalid humidity input';   // For invalid humidity inputs
    END_CASE
    
    WeatherStationProgram := TRUE;
END_FUNCTION