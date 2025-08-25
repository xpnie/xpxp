plc
FUNCTION FC1003 
	VAR_INPUT 
		IN_R : REAL; (* Input real number *)
		IN_MAX, IN_MIN : REAL; (* Input min/max range for conversion *)
		OUT_MAX, OUT_MIN : REAL; (* Output min/max range for conversion *)
	END_VAR 

	VAR_OUTPUT 
		OUT_R : REAL; (* Result real number *)
		FEH : BOOL; (* Error flag indicating out-of-range *)
	END<｜begin▁of▁sentence｜>END_VAR 

	VAR_TEMP 
		DIFF1, DIFF2 : REAL; (* Temporary variables for scale calculation *)
		scl_factor : REAL; (* Scaling factor *)
		rescaled : REAL; (* Input rescaled to original range *)
	END<｜begin▁of▁sentence｜>END_VAR 

	// Calculate scaling factor
	scl_factor := (OUT_MAX - OUT_MIN) / (IN_MAX - IN_MIN);
  
	// Rescale input value from its original range into the new one
	rescaled := scl_factor * (IN_R - IN_MIN) + OUT_MIN;
   
	(* Check if result is within output range *)
	IF ((rescaled < OUT_MIN) OR (rescaled > OUT_MAX)) THEN 
		// If not, set error flag and return
		FEH := TRUE;
	ELSE 
		OUT_R := rescaled;
	END_IF; 
  
	// Return result and error flag to caller
	RETURN;
END_FUNCTION