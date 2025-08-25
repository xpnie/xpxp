PROGRAM SigmoidFB;

VAR
  x : REAL;
  y : REAL;
  e : REAL;
  p : REAL;

VAR_INPUT
  X : REAL;
END_VAR;

BEGIN
  e := exp(-X);
  p := 1 / (1 + e);
  y := 4.9 * p - 2.5;
END_PROGRAM;