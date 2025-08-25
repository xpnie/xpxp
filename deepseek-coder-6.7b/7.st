plc
PROGRAM MyProgram
VAR
    // Array declaration
    aWeights : ARRAY[0..4] OF INT;
    
    // Counter variable
    iCnt : USINT;
    
    // Summation and average variables
    sumWeight : LINT;
    avgWeight : INT;
END_VAR

FUNCTION CalculateAverage: INT
    VAR
        tempSum : LINT;
    END_VAR
    
    tempSum := 0;
    FOR iCnt := 0 TO 4 DO // Iterating over the array elements
        tempSum += aWeights[iCnt]; // Adding up all weights
    END_FOR
    
    CalculateAverage := tempSum / 5; // Calculating average weight
END_FUNCTION

// Main program function
FUNCTION _Main : BOOL
BEGIN
    // Assuming aWeights array is filled with some values at the beginning of this function
   avgWeight := CalculateAverage(); // Calling our function and storing result in avgWeight variable
END_FUNCTION