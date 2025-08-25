PROGRAM CalculateFibonacci;

VAR_INPUT
    X : INT;
END_VAR

VAR
    t1 : DINT := 0;
    t2 : DINT := 1;
    x_tmp : INT;
END_VAR

FUNCTIOIN fib : INT
    VAR
        i : INT;
    END_VAR
    i := 0;
    WHILE i < X DO
        fib := t1 + t2;
        t1 := t2;
        t2 := fib;
        i := i + 1;
    END_WHILE
END_FUNCTION

VAR_OUTPUT
    Result : INT;
END_VAR

PROGRAM
BEGIN
    IF X > 1 THEN
        Result := fib;
    ELSEIF X = 0 OR X = 1 THEN
        Result := X;
    ELSE
        Result := -1; // invalid input
    END_IF;
END_PROGRAM;