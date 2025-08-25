PLC_Programming
FUNCTION BLOCK fbMoveArm
VAR_INPUT
	MoveToWorkCmd : BOOL; // Move towards Work position command
	MoveToHomeCmd : BOOL; // Move towards Home position command
	AtWorkSensor : BOOL;  // Sensor indicating the arm is at the Work position
	AtHomeSensor : BOOL;  // Sensor indicating the arm is at the Home position
	MovementPermitted : BOOL; // Global safety signal allowing movement
END_VAR

VAR_OUTPUT
	MotorForward : BOOL; // Controls motor to move towards Work position
	MotorReverse : BOOL; // Controls motor to move towards Home position
END_VAR

// Store the previous command status for cancellation logic
VAR
	PrevMoveToWorkCmd : BOOL; 
	PrevMoveToHomeCmd : BOOL; 
END_VAR

IF MovementPermitted THEN
	// Cancel movement in opposite direction if current command is pressed
	MotorForward := (NOT PrevMoveToHomeCmd) AND MoveToWorkCmd;
	MotorReverse := (NOT PrevMoveToWorkCmd) AND MoveToHomeCmd;

	// Remember the status of current commands for cancellation logic
	PrevMoveToWorkCmd := MoveToWorkCmd;
	PrevMoveToHomeCmd := MoveToHomeCmd;
ELSE // If movement is not permitted, stop motors immediately
	MotorForward := FALSE;
	MotorReverse := FALSE;
END_IF

// Stop motor if at the target position
MotorForward := MotorForward AND (NOT AtWorkSensor);
MotorReverse := MotorReverse AND (NOT AtHomeSensor);
END_FUNCTION_BLOCK