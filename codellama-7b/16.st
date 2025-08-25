FUNCTION_BLOCK PLC_TrafficLight
VAR
    North_green : BOOL;
    North_yellow : BOOL;
    North_red : BOOL;
    East_green : BOOL;
    East_yellow : BOOL;
    East_red : BOOL;
    T1 : TON;
END_VAR

IF (T1 = 0MS) THEN
    North_green := TRUE;
    East_red := TRUE;
END_IF;

IF (T1 > 0MS AND T1 < 5000MS) THEN
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := TRUE;
    East_green := FALSE;
    East_yellow := FALSE;
    East_red := TRUE;
END_IF;

IF (T1 > 5000MS AND T1 < 5500MS) THEN
    North_green := FALSE;
    North_yellow := TRUE;
    North_red := FALSE;
    East_green := FALSE;
    East_yellow := FALSE;
    East_red := TRUE;
END_IF;

IF (T1 > 5500MS AND T1 < 9500MS) THEN
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := TRUE;
    East_green := FALSE;
    East_yellow := TRUE;
    East_red := FALSE;
END_IF;

IF (T1 > 9500MS AND T1 < 10000MS) THEN
    North_green := FALSE;
    North_yellow := FALSE;
    North_red := TRUE;
    East_green := TRUE;
    East_yellow := FALSE;
    East_red := FALSE;
END_IF;