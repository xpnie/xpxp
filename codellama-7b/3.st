FUNCTION_BLOCK Fibonacci
VAR_INPUT
    X : INT;
END_VAR
VAR
    t1 : DINT;
    t2 : DINT;
    x_tmp : INT;
END_VAR

    BEGIN
        CASE (X) OF
            0: RETURN 0;
            1: RETURN 1;
            ELSE
                t1 := X - 1;
                t2 := X - 2;
                x_tmp := Fibonacci(t1) + Fibonacci(t2);
                RETURN x_tmp;
        END_CASE;
    END_FUNCTION_BLOCK;