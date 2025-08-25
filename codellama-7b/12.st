FUNCTION FB_HYP_SINE(X: REAL) : REAL;
    VAR
        y: REAL;
    END_VAR
    y := EXP(1.0* X * LN(X));
END_FUNCTION;