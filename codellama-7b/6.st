FUNCTION_BLOCK LiftCrane
VAR
  CONSTANT
    WAIT : UINT := 0;
    TOP_POSITION : UINT := 1;
    BOTTOM_POSITION : UINT := 2;
    GETBOX : UINT := 3;
    UNLOAD_POSITION : UINT := 4;
    UNLOAD_BOX : UINT := 5;
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

IF diConvTop = TRUE THEN
  ConvTopOn := TRUE;
END_IF

IF diConvBottom = TRUE THEN
  ConvBottomOn := TRUE;
END_IF

IF selectLift = TOP_POSITION THEN
  doLiftTop := TRUE;
END_IF

IF selectLift = BOTTOM_POSITION THEN
  doLiftBottom := TRUE;
END_IF

IF selectLift = GETBOX THEN
  doConvLift := TRUE;
END_IF

IF selectLift = UNLOAD_POSITION THEN
  doLiftUnload := TRUE;
END_IF

IF diBoxLift = TRUE THEN
  doConvLift := FALSE;
END_IF

IF diLiftTop = TRUE THEN
  ConvTopOn := FALSE;
END_IF

IF diLiftBottom = TRUE THEN
  ConvBottomOn := FALSE;
END_IF

IF diLiftUnload = TRUE THEN
  doConvLift := FALSE;
END_IF