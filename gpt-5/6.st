FUNCTION_BLOCK FB_CraneLift
VAR CONSTANT
    WAIT : UINT:= 0;
    TOP_POSITION : UINT:= 1;
    BOTTOM_POSITION : UINT:= 2;
    GETBOX : UINT:= 3;
    UNLOAD_POSITION : UINT:= 4;
    UNLOAD_BOX : UINT:= 5;
END_VAR

VAR
    (*-- digital outputs*)
    doConvTop: BOOL;
    doConvBottom: BOOL;
    doConvLift: BOOL;
    doLiftTop: BOOL;
    doLiftBottom: BOOL;
    doLiftUnload: BOOL;
    (*-- digital inputs*)
    diConvTop: BOOL;
    diConvBottom: BOOL;
    diLiftTop: BOOL;
    diLiftBottom: BOOL;
    diLiftUnload: BOOL;
    diBoxLift: BOOL;
    (*-- status variables*)
    selectLift: UINT;
    ConvTopOn: BOOL;
    ConvBottomOn: BOOL;
END_VAR

(* Default outputs to safe state *)
doLiftTop := FALSE;
doLiftBottom := FALSE;
doLiftUnload := FALSE;
doConvLift := FALSE;

(* Source conveyors: run while light barrier is free *)
ConvTopOn := NOT diConvTop;
ConvBottomOn := NOT diConvBottom;
doConvTop := ConvTopOn;
doConvBottom := ConvBottomOn;

(* State machine *)
IF selectLift = WAIT THEN
    (* Request lift based on waiting crate(s); priority: top then bottom *)
    IF diConvTop THEN
        selectLift := TOP_POSITION;
    ELSIF diConvBottom THEN
        selectLift := BOTTOM_POSITION;
    END_IF

ELSIF selectLift = TOP_POSITION THEN
    IF diLiftTop THEN
        selectLift := GETBOX;
    ELSE
        doLiftTop := TRUE;
    END_IF

ELSIF selectLift = BOTTOM_POSITION THEN
    IF diLiftBottom THEN
        selectLift := GETBOX;
    ELSE
        doLiftBottom := TRUE;
    END_IF

ELSIF selectLift = GETBOX THEN
    (* Pull crate onto lift until fully on the lift *)
    IF diBoxLift THEN
        doConvLift := FALSE;
        selectLift := UNLOAD_POSITION;
    ELSE
        doConvLift := TRUE;
    END_IF

ELSIF selectLift = UNLOAD_POSITION THEN
    IF diLiftUnload THEN
        selectLift := UNLOAD_BOX;
    ELSE
        doLiftUnload := TRUE;
    END_IF

ELSIF selectLift = UNLOAD_BOX THEN
    (* Convey crate off the lift until it has left *)
    IF NOT diBoxLift THEN
        doConvLift := FALSE;
        selectLift := WAIT;
    ELSE
        doConvLift := TRUE;
    END_IF

ELSE
    (* Fallback to safe idle *)
    selectLift := WAIT;
END_IF
END_FUNCTION_BLOCK