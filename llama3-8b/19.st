FUNCTION_BLOCK FB1005

VAR_INPUT
    START: BOOL;
    DICKE: REAL;
    V_MAX: REAL;
    V_MIN: REAL;
END_VAR

VAR_OUTPUT
    D_MAX: REAL;
    D_MIN: REAL;
    P1: BOOL;
END_VAR

VAR
    FO: BOOL;
    M_MAX: REAL;
    M_MIN: REAL;
    THICKNESS: REAL;
END_VAR

PROGRAM
    IF START THEN
        M_MAX := 0.0;
        M_MIN := 0.0;
    END_IF;

    IF DICKE > 0.0 THEN
        THICKNESS := ABS(DICKE - (V_MAX + V_MIN) / 2.0);
        IF THICKNESS > M_MAX THEN
            M_MAX := THICKNESS;
        END_IF;
        IF THICKNESS < M_MIN THEN
            M_MIN := THICKNESS;
        END_IF;
    END_IF;

    D_MAX := M_MAX;
    D_MIN := M_MIN;

    IF (M_MAX > V_MAX OR M_MIN < V_MIN) THEN
        P1 := TRUE;
    ELSE
        P1 := FALSE;
    END_IF;
END_PROGRAM.