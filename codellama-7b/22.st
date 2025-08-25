FUNCTION_BLOCK MoveArm
VAR
    MoveToWorkCmd : BOOL;  // Momentary push button command to start moving towards the Work position
    MoveToHomeCmd : BOOL;  // Momentary push button command to start moving towards the Home position
    AtWorkSensor : BOOL;  // Sensor that is TRUE only when the arm is at the Work position
    AtHomeSensor : BOOL;  // Sensor that is TRUE only when the arm is at the Home position
    MovementPermitted : BOOL;  // Global safety signal. The arm is only allowed to move if this signal is TRUE
    
    MotorForward : BOOL;  // Energizes the motor to move the arm towards the Work position
    MotorReverse : BOOL;  // Energizes the motor to move the arm towards the Home position
END_VAR
IF MoveToWorkCmd THEN
    IF NOT AtHomeSensor AND MovementPermitted THEN
        MotorForward := TRUE;
        WHILE (NOT AtWorkSensor) AND MovementPermitted DO
            MotorForward := TRUE;
        END_WHILE;
    END_IF;
END_IF;
IF MoveToHomeCmd THEN
    IF NOT AtWorkSensor AND MovementPermitted THEN
        MotorReverse := TRUE;
        WHILE (NOT AtHomeSensor) AND MovementPermitted DO
            MotorReverse := TRUE;
        END_WHILE;
    END_IF;
END_IF;
IF NOT(MotorForward OR MotorReverse) THEN
    IF NOT AtWorkSensor AND NOT AtHomeSensor AND MovementPermitted THEN
        MotorForward := FALSE;
        MotorReverse := FALSE;
    END_IF;
END_IF;