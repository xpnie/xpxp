plc
PROGRAM Program0
VAR
    VAR_INPUT  at %IX0.0 : INT; (* Analog input for fill level *)
    VAR_OUTPUT at %QX0.0 : BOOL; (* Output for low fill level *)
    VAR_OUTPUT at %QX0.1 : BOOL; (* Output for ok fill level *)
    VAR_OUTPUT at %QX0.2 : BOOL; (* Output for high fill level *)
    
    aiLevel  : INT;       (* Analog input value *)
    PercentLevel  : UINT; (* Fill level in percent *)
    doLow  : BOOL;        (* Low fill level output indicator *)
    doOk  : BOOL;         (* Ok fill level output indicator *)
    doHigh  : BOOL;       (* High fill level output indicator *)
    doAlarm  : BOOL;      (* Alarm sounder simulation *)
END_VAR

BEGIN_PROGRAM
    aiLevel := INT_TO_UINT(aiLevel);   (* Conversion from INT to UINT type *)
    
    PercentLevel := (aiLevel / 32767) * 100;   (* Convert the analog value to percent representation *)
    
    doAlarm := FALSE;   (* Initialize alarm indicator *)
    
    CASE PercentLevel OF
        0 .. 99: (* If fill level is below 1% *)
            doLow := TRUE;
            doOk := FALSE;
            doHigh := FALSE;
            doAlarm := TRUE;
        100 .. 254: (* If fill level is between 1% and 99.99% *)
            doLow := FALSE;
            doOk := TRUE;
            doHigh := FALSE;
            doAlarm := FALSE;
        255 .. 32767: (* If fill level is above 99.99% *)
            doLow := FALSE;<｜begin▁of▁sentence｜>
            doOk := FALSE;
            doHigh := TRUE;
            doAlarm := FALSE;
    END_CASE;
END_PROGRAM Program0