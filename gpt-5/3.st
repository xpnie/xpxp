FUNCTION_BLOCK FB_Fibonacci
VAR_INPUT
    X : INT;
END_VAR
VAR
    t1 : DINT; // Current Fibonacci number F(n)
    t2 : DINT; // Helper holding F(n+1) during iteration
    x_tmp : INT; // Clamped copy of X used as loop counter
END_VAR

// Clamp input to safe range to avoid DINT overflow (F(46) fits in 32-bit signed)
IF X < 0 THEN
    x_tmp := 0;
ELSIF X > 46 THEN
    x_tmp := 46;
ELSE
    x_tmp := X;
END_IF

// Initialize base values: F(0) = 0, F(1) = 1
t1 := 0;
t2 := 1;

// Iteratively compute Fibonacci using in-place update without extra temp variable
WHILE x_tmp > 0 DO
    t2 := t1 + t2;   // t2 becomes F(n) + F(n+1) = F(n+2)
    t1 := t2 - t1;   // t1 becomes previous t2 = F(n+1)
    x_tmp := x_tmp - 1;
END_WHILE
END_FUNCTION_BLOCK