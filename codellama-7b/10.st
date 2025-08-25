plc
FUNCTION sigmoid(X: REAL): REAL

VAR
    A, B, C, D, E: REAL;

BEGIN
    A := 1 / (1 + EXP(-X));
    B := (1 + A) / 2;
    C := (1 - A) / 2;
    D := A * A;
    E := SQRT(D);

    RETURN B + C * E;
END_FUNCTION