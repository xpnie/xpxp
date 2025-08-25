FUNCTION_BLOCK FB_LambertW
VAR_INPUT
    X : REAL;
END_VAR
VAR
    w : REAL;
    i : INT;
    we : REAL;
    w1e : REAL;
    ewx : REAL;
    last : DWORD;
END_VAR

(* Handle domain boundary and initial guess *)
ewx := -EXP(-1.0);
IF X <= ewx THEN
    (* At or below the branch point, return -1 on principal branch *)
    w := -1.0;
ELSE
    (* Initial guess selection *)
    IF X < -0.3 THEN
        (* Near the branch point use a square-root based approximation *)
        we := EXP(1.0) * X + 1.0;
        IF we > 0.0 THEN
            w := -1.0 + SQRT(2.0 * we);
        ELSE
            w := -0.5;
        END_IF
    ELSIF X < 3.0 THEN
        (* Moderate values: log1p approximation *)
        w := LN(1.0 + X);
    ELSE
        (* Large values: asymptotic expansion *)
        w := LN(X) - LN(LN(X));
    END_IF

    (* Halley's method iterations *)
    FOR i := 0 TO 19 DO
        (* f = w*exp(w) - x *)
        ewx := EXP(w);
        we := w * ewx;
        w1e := we - X;

        (* denom = exp(w)*(w+1) - (w+2)*f/(2*(w+1)) *)
        ewx := (ewx * (w + 1.0)) - ((w + 2.0) * w1e) / (2.0 * (w + 1.0));

        (* Update: w := w - f/denom *)
        w1e := w1e / ewx;
        w := w - w1e;

        (* Convergence check *)
        IF ABS(w1e) <= 1.0E-6 * (1.0 + ABS(w)) THEN
            EXIT;
        END_IF
    END_FOR
END_IF
END_FUNCTION_BLOCK