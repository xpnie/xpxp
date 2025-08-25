FUNCTION FC1003 : VOID
VAR_INPUT
    IN_R:REAL;
    IN_MAX, IN_MIN:REAL;
    OUT_MAX, OUT_MIN:REAL;
END_VAR
VAR_OUTPUT
    OUT_R:REAL;
    FEH:BOOL;
END_VAR
VAR_TEMP
    DIFF1, DIFF2:REAL;
END_VAR
BEGIN
   DIFF1 := (IN_MAX - IN_MIN) / 255; //Calculate the range of the input sensor
   DIFF2 := (OUT_MAX - OUT_MIN) / (IN_MAX - IN_MIN); //Calculate the range of the output
   OUT_R := ((IN_R * DIFF2) + (OUT_MIN)) - 1; // Calculate the temperature in the output range
   IF (OUT_R > OUT_MAX) THEN  FEH := TRUE; END_IF;
   IF (OUT_R < OUT_MIN) THEN  FEH := FALSE; END_IF;
END_FUNCTION