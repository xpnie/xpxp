PROGRAM SignFunc;

VAR
    x : REAL;
    sign_x : REAL;
BEGIN
    IF x > 0 THEN
        sign_x := x
    ELSE
        IF x < 0 THEN
            sign_x := -x
        ELSE
            sign_x := 0;
    END_IF;
END_PROGRAM;