VAR
    X : REAL;
END_VAR

VAR_OUTPUT
    Y : REAL;
END_VAR

VAR
    half_pi : REAL := 1.5707963267948966; // approximation of pi/2
    factor : REAL;
END_VAR

PROGRAM HyperbolicSine
BEGIN
    IF X < -100 OR X > 100 THEN
        Y := 0; // output is undefined for extreme values
    ELSE
        factor := exp(2 * half_pi * X);
        Y := (exp(X) - factor) / (exp(X) + factor);
    END_IF;
END_PROGRAM