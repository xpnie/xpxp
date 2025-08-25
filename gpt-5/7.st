FUNCTION_BLOCK FB_CraneLoad
VAR CONSTANT
    MAX_INDEX: USINT := 4; // Highest index (0..4 -> 5 load receptors)
END_VAR
VAR
    aWeights : ARRAY[0..MAX_INDEX] OF INT; // Analog inputs 0..32767
    iCnt : USINT;                          // Loop counter
    sumWeight : DINT;                      // Total load (use DINT to avoid overflow)
    avgWeight : INT;                       // Average load per receptor
END_VAR

// Reset sum each cycle
sumWeight := DINT#0;

// Sum all load receptor values using FOR loop
FOR iCnt := USINT#0 TO MAX_INDEX DO
    sumWeight := sumWeight + DINT(aWeights[iCnt]);
END_FOR

// Compute average: total divided by number of receptors (MAX_INDEX + 1)
avgWeight := INT(sumWeight / (DINT(MAX_INDEX) + DINT#1));

END_FUNCTION_BLOCK