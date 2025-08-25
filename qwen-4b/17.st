vbnet
VAR
    aiOutside  : INT;;
    aiHumidity: INT;;
    sShowText  : STRING[80];;
END_VAR

IF (aiOutside < 18) THEN
    sShowText = "Cold";
END IF

IF (aiHumidity > 75) OR (aiHumidity < 40)) THEN
    sShowText = "Opt";
END IF

IF NOT ((aiOutside >= 18) AND (aiOutside <= 25)))) THEN
    sShowText = "Hot";
END IF