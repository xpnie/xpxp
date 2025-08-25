VAR
   Start_Loop : BOOL := FALSE;
   one_hour : TIME := T#1h;
   One_Hour_Timer : TON;
   Gate_Open : BOOL := FALSE;
   Close_Gate_Inst : BOOL := FALSE;
   Sensed_Car : BOOL := FALSE;
   Sensed_Car_Inst : BOOL := FALSE;
   Sensed_App : BOOL := FALSE;
   Mobile_Inst : BOOL := FALSE;
   Auth : STRING;
   my_defined_str : STRING := 'abcd';
END_VAR

PROGRAM
   Start_Loop := FALSE;
   One_Hour_Timer := TON(one_hour);
   
   IF (Start_Loop = FALSE) THEN 
      Start_Loop := TRUE;
      One_Hour_Timer.ENABLE := TRUE;
   END_IF;
   
   IF (One_Hour_Timer.Q <> 0 AND Sensed_Car = TRUE AND Auth = my_defined_str) THEN 
      Gate_Open := TRUE;
      Close_Gate_Inst := FALSE;
   ELSIF (One_Hour_Timer.Q <> 0 AND Sensed_App = TRUE AND Auth = my_defined_str) THEN 
      Gate_Open := TRUE;
      Close_Gate_Inst := FALSE;
   ELSIF (One_Hour_Timer.Q <> 0 AND Sensed_Car = FALSE AND Sensed_App = FALSE) THEN 
      Close_Gate_Inst := TRUE;
   END_IF;
   
END_PROGRAM