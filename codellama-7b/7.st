FUNCTION_BLOCK CalculateTotalLoad
VAR_INPUT
    aWeights : ARRAY[0..MAX_INDEX] OF INT;
    iCnt : USINT;
END_VAR
VAR
    sumWeight : DINT;
    avgWeight : INT;
END_VAR
BEGIN
    // Calculate the total load by adding all individual loads together
    FOR i := 0 TO iCnt - 1 DO
        sumWeight += aWeights[i];
    END_FOR;
    
    // Calculate the average weight by dividing the total load by the number of load receptors
    avgWeight := sumWeight / (iCnt + 0);
END_FUNCTION_BLOCK