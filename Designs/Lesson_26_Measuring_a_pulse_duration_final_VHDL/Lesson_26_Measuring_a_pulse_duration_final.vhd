------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (29/12/2020, 12:44:04)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;


ENTITY Lesson_26_Measuring_a_pulse_duration_final IS
  PORT( 
    --------------------------------------> Inputs:
    iCLK:         IN  std_logic;
    iEN:          IN  std_logic;
    inRES:        IN  std_logic;
    --------------------------------------> Outputs:
    oSER:         OUT std_logic;
    oBSY:         OUT std_logic;
    oRES:         OUT std_logic_vector( 3 downto 0 ) 
    ------------------------------------------------------
    );
END Lesson_26_Measuring_a_pulse_duration_final;


ARCHITECTURE structural OF Lesson_26_Measuring_a_pulse_duration_final IS 

  ----------------------------------------> Components:
  COMPONENT NOT_gate IS
    PORT( I: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT AND2_gate IS
    PORT( I0,I1: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT DnetFF IS
    PORT( D, Ck   : IN std_logic;
          nCL, nPR: IN std_logic;
          Q, nQ   : OUT std_logic );
  END COMPONENT;
  --
  COMPONENT JKpetFF IS
    PORT( J, K, Ck: IN std_logic;
          nCL, nPR: IN std_logic;
          Q, nQ   : OUT std_logic );
  END COMPONENT;

  ----------------------------------------> Finite State Machine(s):
  COMPONENT Fsm1_Lesson_26_Pulse_Measure_FSM_A IS
    PORT( ----------------------------------->Clock & Reset:
          Ck:    IN std_logic;
          Reset: IN std_logic;
          ----------------------------------->Inputs:
          i_EN:  IN std_logic;
          i_ETX: IN std_logic;
          ----------------------------------->Outputs:
          o_TRG: OUT std_logic;
          o_CL:  OUT std_logic;
          o_BSY: OUT std_logic
          -------------------------------------------
          );
  END COMPONENT;
  --
  COMPONENT Fsm2_Lesson_26_Pulse_Measure_FSM_B IS
    PORT( ----------------------------------->Clock & Reset:
          Ck:    IN std_logic;
          Reset: IN std_logic;
          ----------------------------------->Inputs:
          i_TRG: IN std_logic;
          i_C0:  IN std_logic;
          i_C1:  IN std_logic;
          i_C2:  IN std_logic;
          ----------------------------------->Outputs:
          o_SER: OUT std_logic;
          o_ETX: OUT std_logic
          -------------------------------------------
          );
  END COMPONENT;

  ----------------------------------------> Signals:
  SIGNAL S001: std_logic;
  SIGNAL S002: std_logic;
  SIGNAL S003: std_logic;
  SIGNAL S004: std_logic;
  SIGNAL S005: std_logic;
  SIGNAL S006: std_logic;
  SIGNAL S007: std_logic;
  SIGNAL S008: std_logic;
  SIGNAL S009: std_logic;
  SIGNAL S010: std_logic;
  SIGNAL S011: std_logic;
  SIGNAL S012: std_logic;
  SIGNAL S013: std_logic;
  SIGNAL S014: std_logic;
  SIGNAL S015: std_logic;
  SIGNAL S016: std_logic;
  SIGNAL S017: std_logic;
  SIGNAL S018: std_logic;

  ----------------------------------------> Not Connected Pins:
  SIGNAL ncp6_C003: std_logic;
  SIGNAL ncp4_C116: std_logic;
  SIGNAL ncp7_B1_C002: std_logic;
  SIGNAL ncp7_B1_C006: std_logic;


BEGIN -- structural

  ----------------------------------------> Input:
  S001 <= iCLK;
  S002 <= iEN;
  S008 <= inRES;

  ----------------------------------------> Output:
  oSER <= S010;
  oBSY <= S006;
  oRES(0) <= S012;
  oRES(1) <= S013;
  oRES(2) <= S014;
  oRES(3) <= ncp4_C116;

  ----------------------------------------> Constants:
  S004 <= '1';
  S017 <= '1';

  ----------------------------------------> Component Mapping:
  C002: Fsm1_Lesson_26_Pulse_Measure_FSM_A PORT MAP ( S001, S008, 
                                                      S005, S009, 
                                                      S011, S003, 
                                                      S006 );
  C003: DnetFF PORT MAP ( S002, S001, S008, S004, S005, ncp6_C003 );
  C071: NOT_gate PORT MAP ( S003, S007 );
  C078: Fsm2_Lesson_26_Pulse_Measure_FSM_B PORT MAP ( S001, S008, 
                                                      S011, S012, 
                                                      S013, S014, 
                                                      S010, S009 );
  B1_C001: JKpetFF PORT MAP ( S018, S018, S001, S007, S017, S013, 
                              S016 );
  B1_C002: JKpetFF PORT MAP ( S005, S005, S001, S007, S017, S012, 
                              ncp7_B1_C002 );
  B1_C004: AND2_gate PORT MAP ( S018, S013, S015 );
  B1_C006: JKpetFF PORT MAP ( S015, S015, S001, S007, S017, S014, 
                              ncp7_B1_C006 );
  B1_C117: AND2_gate PORT MAP ( S005, S012, S018 );

END structural;
