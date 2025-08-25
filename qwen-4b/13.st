// Declare variables
VAR CONSTANT
    MAXNUMBERS  : UINT  := 99;        
VAR
    aNumbers  : ARRAY[0..MAXNUMBERS] OF INT;
    nCnt  : INT;

// Write the core logic to precisely meet all functional requirements, paying close attention to edge cases and safety principles.

// Implement two abort conditions: if the number 10 is found, the search is aborted. However, it is possible that the number does not exist in the list. Therefore, both abort conditions must be implemented correctly.

// Follow the rules mentioned in the task:

// 1. variables should be declared between VAR and END_VAR:
//        Declare variables
VAR CONSTANT
    MAXNUMBERS  : UINT  := 99;
        
VAR
    aNumbers  : ARRAY[0..MAXNUMBERS] OF INT;
    nCnt  : INT;

// 2. when using control structures do not forget END_<controll structure>:
//        Control structures
END_VAR