FUNCTION FC1002 :BOOL
VAR_INPUT
	E_A, SENSOR: BOOL;
	ZEITW: TIME;
END_VAR
VAR_IN_OUT
	ZEIT:TON;
	P_HU, P_AL: BOOL;
END_VAR

BEGIN
IF E_A THEN (*If the monitoring system is on*)
		IF SENSOR THEN (*If an object or person has been detected*)
			IF (ZEIT-ZEITW) > 3000 THEN(* If the detection has lasted longer than 3 seconds*)
				P_HU := FALSE; (*Turn off horn warning signal*)
				P_AL := TRUE;(*Switch on alarm*)
			ELSE
				P_HU := TRUE; (*Turn on horn warning signal*)
				P_AL := FALSE;(*Switch off alarm*)
			ENDIF
		ENDIF
	ENDIF
END_IF

RETURN P_HU;(*Returns the current state of the horn warning signal*)

END_FUNCTION