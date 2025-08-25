FUNCTION_BLOCK LambertW
VAR_INPUT
  X : REAL;
END_VAR
VAR
  w : REAL;
  i : INT;
  we : REAL;
  w1e : REAL;
  ewx : REAL;
  last : DWORD;
END_VAR

  (* Initialize variables *)
  w := 0.0;
  i := 0;
  we := X;
  w1e := 1.0;
  ewx := X;

  (* Iterate until convergence is reached *)
  WHILE (ABS(w - w1e) > 1E-12 AND i < 50) DO
    w1e := w;
    we := we * ABS(we);
    ewx := X / we;
    w := w + ewx;
    last := last + 1;
    i := i + 1;
  END_WHILE;

  (* Return the result *)
  RETURN w;
END_FUNCTION_BLOCK;