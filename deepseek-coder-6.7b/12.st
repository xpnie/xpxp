plc
PROGRAM HyperbolicSine
    VAR
        X : REAL; (* Input variable *)
        Temp1, Temp2 : REAL; (* Temporary variables to hold intermediate results *)
        Result : REAL; (* Output variable for the result *)
    END_VAR
    
    (* Hyperbolic Sine Function using Exponential Function *)
    HSINE := EXP(X) / (EXP(X) + EXP(-X)) * 2.0;
END_PROGRAM