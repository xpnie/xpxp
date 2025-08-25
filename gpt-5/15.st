FUNCTION FC1002 : BOOL
VAR_INPUT
	E_A, SENSOR: BOOL;
	ZEITW: TIME;
END_VAR
VAR_IN_OUT
	ZEIT:TON;
	P_HU, P_AL: BOOL;
END_VAR

(* Drive timer based on system enable and sensor *)
ZEIT(IN := (E_A AND SENSOR), PT := ZEITW);

(* Alarm latch logic *)
IF NOT E_A THEN
	P_AL := FALSE;
ELSE
	IF P_AL THEN
		P_AL := TRUE; (* keep latched until system is turned off *)
	ELSIF ZEIT.Q THEN
		P_AL := TRUE; (* latch alarm after sustained detection *)
	ELSE
		P_AL := FALSE;
	END_IF
END_IF

(* Horn logic: active only during early detection window *)
IF E_A THEN
	IF SENSOR AND NOT P_AL THEN
		P_HU := TRUE;
	ELSE
		P_HU := FALSE;
	END_IF
ELSE
	P_HU := FALSE;
END_IF

(* Function return indicates system ON status *)
FC1002 := E_A;