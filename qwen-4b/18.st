FUNCTION FC1003(VAR_INPUT) RETURNS VOID
BEGIN
    // Input validation
    IF NOT VAR_INPUT.IN_MAX >= VAR_INPUT.IN_MIN >= 0 THEN
        TYPE_ERROR("Invalid input values for function FC1003()."));
    END

    // Output calculation
    OUT_R = (VAR_INPUT.IN_MAX - VAR_INPUT.IN__MIN) / 2;

    // Edge case handling (temperature is too high or too low))
BEGIN
    IF OUT_R > OUT_MAX THEN
        OUT_ERROR("Temperature output value exceeds maximum allowed temperature of 40C."))
        OUT_ MAX = OUT_R;
    END

    // Safety principle handling (temperature sensor may fail to supply accurate values))
BEGIN
    IF NOT VAR_INPUT.VAR_INPUT THEN
        TYPE_ERROR("Invalid input values for function FC1003()."));
    END

    // Temperature range mapping (temperature output value mapped to temperature range from -20C to 40C))
BEGIN
    IF OUT_R > OUT_ MAX THEN
        OUT_ERROR("Temperature output value exceeds maximum allowed temperature of 40C."));
    END

    // Return statement usage (return statement used to return to main method))
BEGIN
    RETURN;
END