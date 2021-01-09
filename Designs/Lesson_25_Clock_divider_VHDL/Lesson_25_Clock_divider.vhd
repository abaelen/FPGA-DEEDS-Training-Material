------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (8/01/2021, 18:35:37)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;


ENTITY Lesson_25_Clock_divider IS
  PORT( 
    --------------------------------------> Inputs:
    iEn:          IN  std_logic;
    iCLK:         IN  std_logic;
    iLD:          IN  std_logic;
    --------------------------------------> Outputs:
    oPulse16:     OUT std_logic;
    oQ:           OUT std_logic_vector( 3 downto 0 );
    oClk16:       OUT std_logic 
    ------------------------------------------------------
    );
END Lesson_25_Clock_divider;


ARCHITECTURE structural OF Lesson_25_Clock_divider IS 

  ----------------------------------------> Components:
  COMPONENT NOT_gate IS
    PORT( I: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT EXOR2_gate IS
    PORT( I0,I1: IN std_logic;
          O: OUT std_logic );
  END COMPONENT;
  --
  COMPONENT DpetFF IS
    PORT( D, Ck   : IN std_logic;
          nCL, nPR: IN std_logic;
          Q, nQ   : OUT std_logic );
  END COMPONENT;
  --
  COMPONENT Counter4 IS
    PORT( Ck : IN std_logic;
          nCL: IN std_logic;
          LD : IN std_logic;
          ENP: IN std_logic;
          ENT: IN std_logic;
          UD : IN std_logic;
          P3 : IN std_logic;
          P2 : IN std_logic;
          P1 : IN std_logic;
          P0 : IN std_logic;
          Q3 : OUT std_logic;
          Q2 : OUT std_logic;
          Q1 : OUT std_logic;
          Q0 : OUT std_logic;
          Tc : OUT std_logic );
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

  ----------------------------------------> Not Connected Pins:
  SIGNAL ncp6_C196: std_logic;


BEGIN -- structural

  ----------------------------------------> Input:
  S001 <= iEn;
  S007 <= iCLK;
  S014 <= iLD;

  ----------------------------------------> Output:
  oPulse16 <= S008;
  oQ(0) <= S003;
  oQ(1) <= S004;
  oQ(2) <= S005;
  oQ(3) <= S006;
  oClk16 <= S012;

  ----------------------------------------> Constants:
  S010 <= '1';
  S002 <= '1';
  S009 <= '0';

  ----------------------------------------> Component Mapping:
  C002: Counter4 PORT MAP ( S007, S010, S014, S001, S001, S009, 
                            S002, S002, S002, S002, S006, S005, 
                            S004, S003, S008 );
  C196: DpetFF PORT MAP ( S011, S007, S010, S013, S012, ncp6_C196 );
  C226: EXOR2_gate PORT MAP ( S012, S008, S011 );
  C246: NOT_gate PORT MAP ( S014, S013 );

END structural;
