plaintext
PROGRAM MyProgram
VAR
    // Instantiate our interlock function block
    InterlockFb : INTERLOCK;
    
    // Declare the inputs I1, I2 and TL
    I1 : BOOL;
    I2 : BOOL;
    TL : TIME := T#5s;  // Dead time of 5 seconds
END_VAR

FUNCTION_BLOCK INTERLOCK
    VAR_INPUT
        I1 : BOOL;
        I2 : BOOL;
        TL : TIME;
    END_VAR
    
    VAR_OUTPUT
        Q1 : BOOL;
        Q2 : BOOL;
    END_VAR
    
    VAR
        T1 : TOF; // Time of FAlse for Q1
        T2 : TOF; // Time of False for Q2
    END_VAR
    
    IF I1 AND NOT Q1 THEN // If input is TRUE and output is FALSE, set Q1 to TRUE after dead time TL
        Q1(PT:=TL);
    ELSE
        Q1 := FALSE; // Reset Q1 if inputs are FALSE or already at TRUE for longer than deadtime TL
    END_IF;
    
    IF I2 AND NOT Q2 THEN // Same logic applies to Q2
        Q2(PT:=TL);
    ELSE
        Q2 := FALSE; 
    END_IF;
END_FUNCTION_BLOCK

// Connections between PLC inputs and FB variables
I1 := DI[0]; // Connecting a digital input DI[0] to I1
I2 := DI[1]; // Connecting another digital input DI[1] to I2

InterlockFb(I1:=I1, I2:=I2, TL:=TL);  // Instantiating the FB in a way that its inputs correspond to our declared variables

Q1 := InterlockFb.Q1;  // Connecting the output Q1 of the function block back to an output on the PLC
Q2 := InterlockFb.Q2;  // Same logic applies for Q2
END_PROGRAM