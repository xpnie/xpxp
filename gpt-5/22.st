FUNCTION_BLOCK FB_ArmHomeWorkController
VAR_INPUT
    MoveToWorkCmd    : BOOL; // Momentary command to move towards Work position
    MoveToHomeCmd    : BOOL; // Momentary command to move towards Home position
    AtWorkSensor     : BOOL; // TRUE only when arm is exactly at Work position
    AtHomeSensor     : BOOL; // TRUE only when arm is exactly at Home position
    MovementPermitted: BOOL; // Global safety interlock; movement allowed only if TRUE
END_VAR
VAR_OUTPUT
    MotorForward : BOOL; // Energize motor towards Work
    MotorReverse : BOOL; // Energize motor towards Home
END_VAR
VAR
    prevMoveToWorkCmd : BOOL; // Previous state for rising edge detection
    prevMoveToHomeCmd : BOOL; // Previous state for rising edge detection
    riseWork          : BOOL; // Rising edge of MoveToWorkCmd
    riseHome          : BOOL; // Rising edge of MoveToHomeCmd
    forwardLatched    : BOOL; // Latched request to move forward (to Work)
    reverseLatched    : BOOL; // Latched request to move reverse (to Home)
END_VAR

// Rising edge detection for commands
riseWork := MoveToWorkCmd AND NOT prevMoveToWorkCmd;
riseHome := MoveToHomeCmd AND NOT prevMoveToHomeCmd;

// Safety interlock handling and core sequencing
IF NOT MovementPermitted THEN
    // Immediate stop and require new command after safety returns
    forwardLatched := FALSE;
    reverseLatched := FALSE;
ELSE
    // Auto-stop when target position sensor becomes TRUE
    IF AtWorkSensor THEN
        forwardLatched := FALSE;
    END_IF;
    IF AtHomeSensor THEN
        reverseLatched := FALSE;
    END_IF;

    // Process new commands (momentary). Opposite direction is canceled.
    // If both commands occur simultaneously, Home has priority (processed last).
    IF riseWork AND NOT AtWorkSensor THEN
        forwardLatched := TRUE;
        reverseLatched := FALSE;
    END_IF;

    IF riseHome AND NOT AtHomeSensor THEN
        reverseLatched := TRUE;
        forwardLatched := FALSE;
    END_IF;
END_IF;

// Output interlocks: Never allow both directions active, and do not drive if already at target
MotorForward := MovementPermitted AND forwardLatched AND NOT AtWorkSensor AND NOT reverseLatched;
MotorReverse := MovementPermitted AND reverseLatched AND NOT AtHomeSensor AND NOT forwardLatched;

// Update previous states for edge detection
prevMoveToWorkCmd := MoveToWorkCmd;
prevMoveToHomeCmd := MoveToHomeCmd;
END_FUNCTION_BLOCK