FUNCTION_BLOCK FB_Sinh
VAR
    X : REAL;
END_VAR

(* Compute hyperbolic sine of X in-place using the exponential function.
   Includes simple saturation and piecewise evaluation to mitigate overflow. *)

(* Soft-limit X to a safe computational range for REAL to reduce overflow risk *)
X := LIMIT(-88.0, X, 88.0);

IF X > 80.0 THEN
    (* For large positive X, sinh(X) ≈ 0.5 * exp(X) *)
    X := 0.5 * EXP(X);
ELSIF X < -80.0 THEN
    (* For large negative X, sinh(X) ≈ -0.5 * exp(-X) *)
    X := -0.5 * EXP(-X);
ELSE
    (* General case: sinh(X) = (e^X - e^-X) / 2 *)
    X := 0.5 * (EXP(X) - EXP(-X));
END_IF

END_FUNCTION_BLOCK