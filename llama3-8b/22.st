PROGRAM FB_AerospaceArm;

VAR_INPUT
    MoveToWorkCmd : BOOL;
    MoveToHomeCmd : BOOL;
    AtWorkSensor   : BOOL;
    AtHomeSensor   : BOOL;
    MovementPermitted : BOOL;

VAR_OUTPUT
    MotorForward  : BOOL;
    MotorReverse  : BOOL;

VAR
    armPosition : BOOL; // Internal variable to track the current arm position

PROGRAM
BEGIN
    armPosition := FALSE; // Initialize arm position as unknown

    WHILE TRUE DO
    BEGIN
        IF MoveToWorkCmd AND NOT armPosition THEN
            MotorForward := TRUE;
        ELSE
            MotorForward := FALSE;

        IF MoveToHomeCmd AND NOT armPosition THEN
            MotorReverse := TRUE;
        ELSE
            MotorReverse := FALSE;

        IF AtWorkSensor AND armPosition THEN
            MotorForward := FALSE; // Arm reached Work position, stop movement

        IF AtHomeSensor AND armPosition THEN
            MotorReverse := FALSE; // Arm reached Home position, stop movement

        IF NOT MovementPermitted THEN
            MotorForward := FALSE;
            MotorReverse := FALSE; // Stop all movement if not permitted

        armPosition := (MotorForward OR MotorReverse); // Update arm position based on motor state
    END;

ENDPROGRAM FB_AerospaceArm.