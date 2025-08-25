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

(* Initialize error flag *)
FEH := FALSE;

(* Calculate input and output spans *)
DIFF1 := IN_MAX - IN_MIN;
DIFF2 := OUT_MAX - OUT_MIN;

(* Validate input span to avoid division by zero *)
IF ABS(DIFF1) <= 1.0e-30 THEN
    FEH := TRUE;
    OUT_R := OUT_MIN; (* Safe fallback output *)
    RETURN;
END_IF

(* Normalize input to 0..1 with saturation *)
OUT_R := (IN_R - IN_MIN) / DIFF1;
IF OUT_R < 0.0 THEN
    OUT_R := 0.0;
ELSIF OUT_R > 1.0 THEN
    OUT_R := 1.0;
END_IF

(* Scale to output range *)
OUT_R := OUT_MIN + OUT_R * DIFF2;

END_FUNCTION