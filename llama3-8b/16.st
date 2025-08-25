PROGRAM Traffic_Light;

VAR
    North_green         : BOOL;
    North_yellow       : BOOL;
    North_red           : BOOL;
    East_green          : BOOL;
    East_yellow         : BOOL;
    East_red             : BOOL;
    T1                   : TON;
END_VAR

PROGRAM
BEGIN
    // Initialize all lights off
    North_green := FALSE;
    North_yellow := FALSE;
    North_red     := FALSE;
    East_green    := FALSE;
    East_yellow   := FALSE;
    East_red       := FALSE;

    T1.Preset(0);
    T1.RisingEdgeTime := 10000;

    WHILE T1.Q :=# TRUE DO
        CASE T1.T
            OF 0 TO 5000 : 
                North_green := TRUE;
                North_yellow := FALSE;
                North_red     := FALSE;
                East_green    := FALSE;
                East_yellow   := FALSE;
                East_red       := TRUE;
            OF 5000 TO 5500 :
                North_green := TRUE;
                North_yellow := TRUE;
                North_red     := FALSE;
                East_green    := FALSE;
                East_yellow   := FALSE;
                East_red       := TRUE;
            OF 5500 TO 9500 : 
                North_green := FALSE;
                North_yellow := FALSE;
                North_red     := TRUE;
                East_green    := TRUE;
                East_yellow   := FALSE;
                East_red       := FALSE;
            OF 9500 TO 10000 :
                North_green := FALSE;
                North_yellow := FALSE;
                North_red     := TRUE;
                East_green    := FALSE;
                East_yellow   := TRUE;
                East_red       := FALSE
        END_CASE
    END_WHILE
END_PROGRAM