FUNCTION BLOCK SignFunction :

VAR_INPUT
    x : REAL;
END_VAR

VAR
    result : REAL := 0.0;
END_VAR

BEGIN
    CASE x OF
        -1.0 : result := -1.0;
        0.0 : result := 0.0;
        1.0 : result := 1.0;
        ELSE : result := 0.0;
    END_CASE
END_FUNCTION