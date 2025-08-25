plc
PROGRAM LeapYearProgram
VAR
    YEAR : INT; (* Input Variable *)
    IS_LEAP : BOOL; (* Output Variable to indicate whether the input year is a leap year or not *)
END_VAR

FUNCTION CheckLeapYear: BOOL (* Function to check if a given year is a leap year *)
VAR_INPUT
    YearToCheck : INT; (* The year to check *)
END_VAR
VAR
    DivisibleBy4 : BOOL; (* Indicates whether the year can be divided by 4 without a remainder *)
    DivisibleBy100 : BOOL; (* Indicates whether the year can be divided by 100 without a remainder *)
    DivisibleBy400 : BOOL; (* Indicates whether the year can be divided by 400 without a remainder *)
END_VAR
BEGIN
    DivisibleBy4 := YearToCheck MOD 4 = 0; (* Check if divisible by 4 *)
    DivisibleBy100 := YearToCheck MOD 100 = 0; (* Check if divisible by 100 *)
    DivisibleBy400 := YearToCheck MOD 400 = 0; (* Check if divisible by 400 *)
    
    IF DivisibleBy4 THEN (* If the year can be divided by 4, then it's a leap year unless: *)
        IF NOT DivisibleBy100 OR DivisibleBy400 THEN (* - It can also be divided by 100 but not by 400 *)
            CheckLeapYear := TRUE; (* Then it is a leap year. *)
        ELSE (* Otherwise, it's not a leap year *)
            CheckLeapYear := FALSE;
        END_IF;
    ELSE (* If the year cannot be divided by 4, then it's not a leap year *)
        CheckLeapYear := FALSE;
    END_IF;
END_FUNCTION

(* Main program part to use the function and set the output variable according to its return value *)
BEGIN
    IS_LEAP := CheckLeapYear(YEAR); (* Calling the function with input year and storing its result in IS_LEAP *)
END_PROGRAM