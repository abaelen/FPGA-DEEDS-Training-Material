------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (27/12/2020, 15:48:37)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;


ENTITY Lesson_13_2bit_comparator IS
  PORT( 
    --------------------------------------> Inputs:
    iA1:          IN  std_logic;
    iB0:          IN  std_logic;
    iB1:          IN  std_logic;
    iA0:          IN  std_logic;
    --------------------------------------> Outputs:
    oG:           OUT std_logic;
    oE:           OUT std_logic;
    oL:           OUT std_logic 
    ------------------------------------------------------
    );
END Lesson_13_2bit_comparator;


ARCHITECTURE structural OF Lesson_13_2bit_comparator IS 

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
  COMPONENT OR2_gate IS
    PORT( I0,I1: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT OR3_gate IS
    PORT( I0,I1,I2: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT OR4_gate IS
    PORT( I0,I1,I2,I3: IN std_logic;
          O: OUT std_logic );
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
  SIGNAL S019: std_logic;
  SIGNAL S020: std_logic;
  SIGNAL S021: std_logic;
  SIGNAL S022: std_logic;
  SIGNAL S023: std_logic;
  SIGNAL S024: std_logic;
  SIGNAL S025: std_logic;
  SIGNAL S026: std_logic;
  SIGNAL S027: std_logic;
  SIGNAL S028: std_logic;
  SIGNAL S029: std_logic;
  SIGNAL S030: std_logic;


BEGIN -- structural

  ----------------------------------------> Input:
  S006 <= iA1;
  S004 <= iB0;
  S003 <= iB1;
  S005 <= iA0;

  ----------------------------------------> Output:
  oG <= S018;
  oE <= S027;
  oL <= S030;

  ----------------------------------------> Component Mapping:
  C134: NOT_gate PORT MAP ( S005, S008 );
  C135: NOT_gate PORT MAP ( S004, S001 );
  C136: NOT_gate PORT MAP ( S003, S002 );
  C169: NOT_gate PORT MAP ( S006, S007 );
  C370: AND2_gate PORT MAP ( S002, S001, S009 );
  C379: AND2_gate PORT MAP ( S003, S001, S017 );
  C388: AND2_gate PORT MAP ( S002, S004, S025 );
  C397: AND2_gate PORT MAP ( S003, S004, S012 );
  C406: AND2_gate PORT MAP ( S006, S005, S026 );
  C407: AND2_gate PORT MAP ( S007, S005, S011 );
  C408: AND2_gate PORT MAP ( S006, S008, S010 );
  C409: AND2_gate PORT MAP ( S007, S008, S022 );
  C431: AND2_gate PORT MAP ( S009, S022, S019 );
  C432: AND2_gate PORT MAP ( S017, S010, S013 );
  C433: AND2_gate PORT MAP ( S025, S011, S014 );
  C448: AND2_gate PORT MAP ( S012, S026, S015 );
  C454: OR4_gate PORT MAP ( S013, S014, S019, S015, S027 );
  C470: OR2_gate PORT MAP ( S011, S026, S016 );
  C478: AND2_gate PORT MAP ( S017, S016, S020 );
  C526: AND2_gate PORT MAP ( S009, S021, S023 );
  C530: NOT_gate PORT MAP ( S022, S021 );
  C540: AND2_gate PORT MAP ( S026, S025, S024 );
  C541: OR3_gate PORT MAP ( S024, S020, S023, S018 );
  C569: NOT_gate PORT MAP ( S027, S028 );
  C570: NOT_gate PORT MAP ( S018, S029 );
  C571: AND2_gate PORT MAP ( S029, S028, S030 );

END structural;
