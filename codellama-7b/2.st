// Function Block for Binomial Coefficient Calculation
FUNCTION_BLOCK binomialCoefficient
    VAR
        N : INT; // Number of items in the set
        K : INT; // Number of elements to select from the set
        i : INT; // Counter variable
        result : LREAL; // Result of the calculation
    END_VAR
    
    IF (K > N) THEN RETURN 0; END_IF;
    IF (N = K OR K = 0) THEN RETURN 1; END_IF;
    
    i := K - 1;
    result := N;
    WHILE (i >= 1) DO
        result := result * (N - i);
        i := i - 1;
    END_WHILE;
    
    RETURN result / FACT(K);
END_FUNCTION_BLOCK