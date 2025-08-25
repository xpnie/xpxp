(* --- Standard Solution for Robotic Arm Safe Move --- *)
FUNCTION_BLOCK FB_RoboticArm_SafeMove
VAR_INPUT
    MoveToWorkCmd   : BOOL; // Command to move to the Work position (momentary button)
    MoveToHomeCmd   : BOOL; // Command to move to the Home position (momentary button)
    AtWorkSensor    : BOOL; // TRUE when the arm is at the Work position
    AtHomeSensor    : BOOL; // TRUE when the arm is at the Home position
    MovementPermitted : BOOL; // Global safety signal, TRUE when movement is allowed
END_VAR
VAR_OUTPUT
    MotorForward    : BOOL; // Output to drive the motor towards Work position
    MotorReverse    : BOOL; // Output to drive the motor towards Home position
END_VAR
VAR
    // Internal latches to keep the movement active after a button press
    bMoveForwardActive : BOOL;
    bMoveHomeActive    : BOOL;
END_VAR


// --- Logic Body ---

// --- Forward Movement Logic (to Work Position) ---
// SET condition: If the "Move to Work" button is pressed AND the arm is not already there
// AND the safety condition is met, then SET the forward movement latch.
IF MoveToWorkCmd AND NOT AtWorkSensor AND MovementPermitted THEN
    bMoveForwardActive := TRUE;
END_IF;

// RESET condition: If the arm reaches the Work sensor, OR if the "Move to Home" button is pressed,
// OR if the safety permit is lost, then RESET the forward movement latch.
IF AtWorkSensor OR MoveToHomeCmd OR NOT MovementPermitted THEN
    bMoveForwardActive := FALSE;
END_IF;


// --- Reverse Movement Logic (to Home Position) ---
// SET condition: If the "Move to Home" button is pressed AND the arm is not already there
// AND the safety condition is met, then SET the reverse movement latch.
IF MoveToHomeCmd AND NOT AtHomeSensor AND MovementPermitted THEN
    bMoveHomeActive := TRUE;
END_IF;

// RESET condition: If the arm reaches the Home sensor, OR if the "Move to Work" button is pressed,
// OR if the safety permit is lost, then RESET the reverse movement latch.
IF AtHomeSensor OR MoveToWorkCmd OR NOT MovementPermitted THEN
    bMoveHomeActive := FALSE;
END_IF;


// --- Motor Output Logic ---
// The motor outputs are only active if their respective latch is set AND the global safety permit is TRUE.
MotorForward := bMoveForwardActive AND MovementPermitted;
MotorReverse := bMoveHomeActive AND MovementPermitted;

END_FUNCTION_BLOCK