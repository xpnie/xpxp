FUNCTION_BLOCK INTERLOCK
VAR_INPUT
    I1 : BOOL;
    I2 : BOOL;
    TL : TIME;
END_VAR
VAR_OUTPUT
    Q1 : BOOL;
    Q2 : BOOL;
END_VAR
VAR
    T1 : TOF;
    T2 : TOF;
    t_start : TOF;
    time_count : INT := 0;
END_VAR

DO
    IF NOT I1 AND NOT T1 THEN
        T1 := #t;
    END_IF;

    IF NOT I2 AND NOT T2 THEN
        T2 := #t;
    END_IF;

    IF I1 AND NOT T1 THEN
        t_start := #t;
        time_count := 0;
    END_IF;

    IF I2 AND NOT T2 THEN
        t_start := #t;
        time_count := 0;
    END_IF;

    IF I1 AND (T1 - t_start >= TL) AND NOT Q2 THEN
        Q1 := TRUE;
        T1 := #t;
        time_count := 0;
    END_IF;

    IF I2 AND (T2 - t_start >= TL) AND NOT Q1 THEN
        Q2 := TRUE;
        T2 := #t;
        time_count := 0;
    END_IF;

    IF NOT I1 AND Q1 THEN
        T1 := #t;
    END_IF;

    IF NOT I2 AND Q2 THEN
        T2 := #t;
    END_IF;

    IF (I1 OR I2) AND (time_count > 0) THEN
        time_count := time_count - 1;
    END_IF;

END_DO;