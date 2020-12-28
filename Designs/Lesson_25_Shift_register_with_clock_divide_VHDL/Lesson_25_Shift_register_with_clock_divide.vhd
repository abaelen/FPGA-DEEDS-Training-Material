------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (28/12/2020, 16:24:04)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;


ENTITY Lesson_25_Shift_register_with_clock_divide IS
  PORT( 
    --------------------------------------> Inputs:
    iInL:         IN  std_logic;
    iCLK:         IN  std_logic;
    iEn:          IN  std_logic;
    iS8:          IN  std_logic_vector( 7 downto 0 );
    --------------------------------------> Outputs:
    oQ0:          OUT std_logic;
    oL:           OUT std_logic_vector( 7 downto 0 );
    oClk16:       OUT std_logic;
    oQ:           OUT std_logic_vector( 3 downto 0 );
    oPulse16:     OUT std_logic;
    oL2:          OUT std_logic_vector( 7 downto 0 ) 
    ------------------------------------------------------
    );
END Lesson_25_Shift_register_with_clock_divide;


ARCHITECTURE structural OF Lesson_25_Shift_register_with_clock_divide IS 

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
  --
  COMPONENT Universal4 IS
    PORT( Ck : IN std_logic;
          nCL: IN std_logic;
          S1 : IN std_logic;
          S0 : IN std_logic;
          Rin: IN std_logic;
          Lin: IN std_logic;
          P3 : IN std_logic;
          P2 : IN std_logic;
          P1 : IN std_logic;
          P0 : IN std_logic;
          Q3 : OUT std_logic;
          Q2 : OUT std_logic;
          Q1 : OUT std_logic;
          Q0 : OUT std_logic );
  END COMPONENT;
  --
  COMPONENT Universal8 IS
    PORT( Ck : IN std_logic;
          nCL: IN std_logic;
          S1 : IN std_logic;
          S0 : IN std_logic;
          Rin: IN std_logic;
          Lin: IN std_logic;
          P7 : IN std_logic;
          P6 : IN std_logic;
          P5 : IN std_logic;
          P4 : IN std_logic;
          P3 : IN std_logic;
          P2 : IN std_logic;
          P1 : IN std_logic;
          P0 : IN std_logic;
          Q7 : OUT std_logic;
          Q6 : OUT std_logic;
          Q5 : OUT std_logic;
          Q4 : OUT std_logic;
          Q3 : OUT std_logic;
          Q2 : OUT std_logic;
          Q1 : OUT std_logic;
          Q0 : OUT std_logic );
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
  SIGNAL S031: std_logic;
  SIGNAL S032: std_logic;
  SIGNAL S033: std_logic;
  SIGNAL S034: std_logic;
  SIGNAL S035: std_logic;
  SIGNAL S036: std_logic;
  SIGNAL S037: std_logic;
  SIGNAL S038: std_logic;
  SIGNAL S039: std_logic;
  SIGNAL S040: std_logic;
  SIGNAL S041: std_logic;
  SIGNAL S042: std_logic;
  SIGNAL S043: std_logic;
  SIGNAL S044: std_logic;
  SIGNAL S045: std_logic;
  SIGNAL S046: std_logic;
  SIGNAL S047: std_logic;
  SIGNAL S048: std_logic;
  SIGNAL S049: std_logic;
  SIGNAL S050: std_logic;
  SIGNAL S051: std_logic;
  SIGNAL S052: std_logic;
  SIGNAL S053: std_logic;

  ----------------------------------------> Not Connected Pins:
  SIGNAL ncp11_C041: std_logic;
  SIGNAL ncp12_C041: std_logic;
  SIGNAL ncp13_C041: std_logic;
  SIGNAL ncp6_C237: std_logic;
  SIGNAL ncp7_C276: std_logic;
  SIGNAL ncp8_C276: std_logic;
  SIGNAL ncp9_C276: std_logic;
  SIGNAL ncp10_C276: std_logic;
  SIGNAL ncp11_C276: std_logic;
  SIGNAL ncp12_C276: std_logic;
  SIGNAL ncp13_C276: std_logic;
  SIGNAL ncp14_C276: std_logic;
  SIGNAL ncp1_C322: std_logic;
  SIGNAL ncp5_C322: std_logic;
  SIGNAL ncp6_C322: std_logic;


BEGIN -- structural

  ----------------------------------------> Input:
  S015 <= iInL;
  S051 <= iCLK;
  S025 <= iEn;
  S007 <= iS8(0);
  S006 <= iS8(1);
  S005 <= iS8(2);
  S004 <= iS8(3);
  S003 <= iS8(4);
  S002 <= iS8(5);
  S001 <= iS8(6);
  S017 <= iS8(7);

  ----------------------------------------> Output:
  oQ0 <= S046;
  oL(0) <= S046;
  oL(1) <= S014;
  oL(2) <= S013;
  oL(3) <= S012;
  oL(4) <= S011;
  oL(5) <= S010;
  oL(6) <= S009;
  oL(7) <= S008;
  oClk16 <= S023;
  oQ(0) <= S030;
  oQ(1) <= S029;
  oQ(2) <= S028;
  oQ(3) <= S027;
  oPulse16 <= S053;
  oL2(0) <= S037;
  oL2(1) <= S038;
  oL2(2) <= S039;
  oL2(3) <= S040;
  oL2(4) <= S041;
  oL2(5) <= S042;
  oL2(6) <= S043;
  oL2(7) <= S044;

  ----------------------------------------> Constants:
  S019 <= '0';
  S020 <= '0';
  S021 <= '1';
  S026 <= '0';
  S031 <= '1';
  S050 <= '1';
  S018 <= '0';
  S032 <= '1';
  S033 <= '1';
  S047 <= '1';
  S048 <= '0';
  S049 <= '0';
  S052 <= '1';

  ----------------------------------------> Component Mapping:
  C001: Universal8 PORT MAP ( S045, S050, S036, S033, S016, S015, 
                              S001, S002, S003, S004, S005, S006, 
                              S007, S021, S008, S009, S010, S011, 
                              S012, S013, S014, S046 );
  C041: Universal4 PORT MAP ( S045, S050, S036, S032, S019, S020, 
                              S018, S018, S018, S017, ncp11_C041, 
                              ncp12_C041, ncp13_C041, S016 );
  C092: NOT_gate PORT MAP ( S035, S022 );
  C094: EXOR2_gate PORT MAP ( S023, S053, S024 );
  C095: DpetFF PORT MAP ( S024, S051, S050, S022, S023, S045 );
  C104: Counter4 PORT MAP ( S051, S050, S035, S025, S025, S026, 
                            S031, S031, S031, S031, S027, S028, 
                            S029, S030, S053 );
  C237: DpetFF PORT MAP ( S035, S034, S050, S022, S036, ncp6_C237 );
  C269: NOT_gate PORT MAP ( S045, S034 );
  C276: Universal8 PORT MAP ( S045, S050, S047, S048, S049, S046, 
                              ncp7_C276, ncp8_C276, ncp9_C276, 
                              ncp10_C276, ncp11_C276, ncp12_C276, 
                              ncp13_C276, ncp14_C276, S044, S043, 
                              S042, S041, S040, S039, S038, S037 );
  C322: DpetFF PORT MAP ( ncp1_C322, S051, S050, S052, ncp5_C322, 
                          ncp6_C322 );

END structural;
