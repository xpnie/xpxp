plc
PROGRAM FibonacciProgram
// Input variables
VAR_INPUT
    X : INT; // the number to calculate fibonacci for
END_VAR

// Internal variables
VAR
    t1 : DINT;
    t2 : DINT;
    x_tmp : INT;
END_VAR

BEGIN
    IF X > 0 THEN BEGIN 
        // Base case for Fibonacci (F(0) = 0, F(1) = 1)
        t1 := 0;
        t2 := 1;
        
        FOR i:=2 TO X DO BEGIN   // Iterative calculation of fibonacci number
            x_tmp := t1 + t2;    
            t1 := t2;              
            t2 := x_tmp;            
        END_FOR
    END
END_IF
END_PROGRAM