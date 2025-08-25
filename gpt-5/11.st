FUNCTION Sign : INT
VAR_INPUT
    x : REAL;
END_VAR
IF x > 0.0 THEN
    Sign := 1;
ELSIF x < 0.0 THEN
    Sign := -1;
ELSE
    Sign := 0;
END_IF;
RETURN;
END_FUNCTION