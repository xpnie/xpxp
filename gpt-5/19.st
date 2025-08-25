FUNCTION_BLOCK FB1005
VAR_INPUT
    START:BOOL; 
    DICKE, V_MAX, V_MIN:REAL;
END_VAR
VAR_OUTPUT
    D_MAX, D_MIN:REAL; 
    P1:BOOL;
END_VAR
VAR
    FO:BOOL;
END_VAR

(* Rising edge detection of START: initialize new measurement cycle *)
IF (START AND NOT FO) THEN
    (* Initialize min/max with first sample of the new cycle *)
    D_MAX := DICKE;
    D_MIN := DICKE;
END_IF

(* While measuring, continuously update min/max *)
IF START THEN
    IF DICKE > D_MAX THEN
        D_MAX := DICKE;
    END_IF
    IF DICKE < D_MIN THEN
        D_MIN := DICKE;
    END_IF
END_IF

(* Evaluate reject light based on tolerance band.
   Safety: If V_MIN > V_MAX (invalid band), force reject. *)
IF V_MIN <= V_MAX THEN
    P1 := (D_MIN < V_MIN) OR (D_MAX > V_MAX);
ELSE
    P1 := TRUE;
END_IF

(* Store previous START state for edge detection *)
FO := START
END_FUNCTION_BLOCK