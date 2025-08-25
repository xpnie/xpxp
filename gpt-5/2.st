FUNCTION_BLOCK FB_BinomialCoefficient
VAR_INPUT
    N : INT;
    K : INT;
    i : INT;
END_VAR
VAR_OUTPUT
    C : ULINT;
    Valid : BOOL;
    Error : BOOL;
    ErrorID : UINT;
END_VAR
VAR
    nEff : UDINT;
    kEff : UDINT;
    j : UDINT;
    res : ULINT;
    numTerm : ULINT;
    denTerm : ULINT;
    gcd : ULINT;
    temp : ULINT;
    rem : ULINT;
END_VAR

(* Default outputs *)
Error := FALSE;
Valid := FALSE;
ErrorID := UINT#0;
C := ULINT#0;

(* Validate inputs *)
IF (N < 0) OR (K < 0) THEN
    Error := TRUE;
    ErrorID := UINT#10; (* Negative inputs not allowed *)
    RETURN;
END_IF

IF K > N THEN
    Error := TRUE;
    ErrorID := UINT#11; (* K must be <= N *)
    RETURN;
END_IF

(* Prepare effective parameters and use symmetry k = min(K, N-K) *)
nEff := UDINT(N);
kEff := UDINT(K);
IF kEff > (nEff - kEff) THEN
    kEff := nEff - kEff;
END_IF

res := ULINT#1;

(* Trivial cases *)
IF kEff = UDINT#0 THEN
    C := res; (* C(N,0) = 1 *)
    Valid := TRUE;
    RETURN;
END_IF

(* Multiplicative method with GCD reduction to control growth:
   res = product_{j=1..k} (n-k+j)/j
*)
FOR j := UDINT#1 TO kEff DO
    numTerm := ULINT(nEff - kEff + j);  (* numerator term *)
    denTerm := ULINT(j);                 (* denominator term *)

    (* Reduce (res, denTerm) by their GCD *)
    gcd := res;
    temp := denTerm;
    WHILE temp <> ULINT#0 DO
        rem := gcd MOD temp;
        gcd := temp;
        temp := rem;
    END_WHILE
    IF gcd > ULINT#1 THEN
        res := res / gcd;
        denTerm := denTerm / gcd;
    END_IF

    (* Reduce (numTerm, denTerm) by their GCD *)
    gcd := numTerm;
    temp := denTerm;
    WHILE temp <> ULINT#0 DO
        rem := gcd MOD temp;
        gcd := temp;
        temp := rem;
    END_WHILE
    IF gcd > ULINT#1 THEN
        numTerm := numTerm / gcd;
        denTerm := denTerm / gcd;
    END_IF

    (* Apply the reduced multiply/divide step *)
    res := res * numTerm;
    res := res / denTerm;
END_FOR

C := res;
Valid := TRUE
END_FUNCTION_BLOCK