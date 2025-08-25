PROGRAM BinomialCoefficient;

VAR
    n : INT;
    k : INT;
    i : INT;
    result : INT;
    binomCoeff : INT;

VAR_OUTPUT
    output : INT;

BEGIN
    IF (n < 0) OR (k < 0) THEN
        output := -1; // invalid input
    ELSIF (k > n) THEN
        output := 0; // k is greater than n, coefficient is 0
    ELSE
        binomCoeff := 1;
        FOR i FROM 0 TO k DO
            IF (k - i) < (n - i) THEN
                binomCoeff := binomCoeff * (n - i);
            ELSE
                binomCoeff := binomCoeff * ((n - i) / (i + 1));
            END_IF;
        output := binomCoeff;
    END_IF;

END_PROGRAM;