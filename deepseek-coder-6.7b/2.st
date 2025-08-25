plc
PROGRAM BinomialCoefficient
    VAR_INPUT 
        N : INT; // Total number of items
        K : INT; // Number of items to choose
        i : INT; // Loop counter
    END_VAR
    
    VAR
        result : LONG := 1; // Result will be stored here
    END_VAR
    
BEGIN
    FOR i := 1 TO (K) DO // From 1 to K, both inclusive
        result := result * ((N + i - K) DIV i); // Calculate n*(n-1)*...(n-k+1)/k
    END_FOR;
END_PROGRAM