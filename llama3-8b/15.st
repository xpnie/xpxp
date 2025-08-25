FUNCTION FC1002 :BOOL
VAR_INPUT
	E_A, SENSOR: BOOL;
	ZEITW: TIME;
END_VAR
VAR
	zeit := 0;
END_VAR
VAR_IN_OUT
	ZEIT: TON;
	P_HU, P_AL: BOOL;
END_VAR

IF E_A THEN
	IF SENSOR THEN
		zeit := TIMET#(ZEITW);
		LOOP zeit < 3000 DO
			P_HU := TRUE;
			TIMET#(ZEIT) +:= 100; // Simulate sensor update (100ms)
		REPEAT
		ELOOP
		P_AL := FALSE;
		zeit := TIMET#(ZEITW);
	END_IF
ELSIF zeit > 0 THEN
	P_AL := TRUE;
ELSE
	P_HU := FALSE;
	P_AL := FALSE;
ENDIF