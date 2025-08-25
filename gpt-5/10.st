FUNCTION_BLOCK FB_Sigmoid
VAR_INPUT
    X : REAL;
END_VAR
VAR_OUTPUT
    Y : REAL;
END_VAR
VAR
    z : LREAL;    // Intermediate exponential value
    t : LREAL;    // Temporary result in LREAL for precision
END_VAR

// Numerically stable sigmoid implementation:
// if x >= 0: sigmoid(x) = 1 / (1 + exp(-x))
// else:       sigmoid(x) = exp(x) / (1 + exp(x))
IF X >= 0.0 THEN
    z := EXP(LREAL(-X));
    t := 1.0 / (1.0 + z);
    Y := REAL(t);
ELSE
    z := EXP(LREAL(X));
    t := z / (1.0 + z);
    Y := REAL(t);
END_IF
END_FUNCTION_BLOCK