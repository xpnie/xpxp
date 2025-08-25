plc
PROGRAM MyProgram
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
    selectLift: UINT := WAIT;
    ConvTopOn: BOOL := FALSE;
    ConvBottomOn: BOOL := FALSE;
END_VAR

BEGIN
    CASE selectLift OF 
        WAIT:
            (* Wait for lift request *)
            IF diConvTop OR diConvBottom THEN // if any of the conveyors are activated, stop them and move to requested position
                ConvTopOn := FALSE;
                doConvTop := FALSE;
                
                ConvBottomOn := FALSE;
                doConvBottom := FALSE;
                
                IF diConvTop THEN // if top conveyor is activated, go to bottom and vice versa
                    selectLift := BOTTOM_POSITION; 
                ELSE
                    selectLift := TOP_POSITION; 
                END_IF
            END_IF
        TOP_POSITION:
            (* Lift at top position *)
            IF NOT diConvTop THEN // if the conveyor is deactivated, stop it and start moving to unload position
                doLiftUnload := TRUE; 
                
                ConvBottomOn := FALSE;
                doConvBottom := FALSE;
                
                selectLift := UNLOAD_POSITION; // change state to unloading position
            END_IF
        BOTTOM_POSITION:
            (* Lift at bottom position *)
            IF NOT diConvBottom THEN // if the conveyor is deactivated, stop it and start moving to unload position
                doLiftUnload := TRUE; 
                
                ConvTopOn := FALSE;
                doConvTop := FALSE;
                
                selectLift := UNLOAD_POSITION; // change state to unloading position
            END_IF
        UNLOAD_POSITION:
            (* Lift at unload position *)
            IF diBoxLift THEN // if box is in lift, start moving back to initial positions
                doConvLift := FALSE; 
                
                selectLift := WAIT; // change state to waiting for requests
            END_IF
    END_CASE;
END_PROGRAM