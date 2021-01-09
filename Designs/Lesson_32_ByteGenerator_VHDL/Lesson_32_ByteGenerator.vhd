------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (30/12/2020, 16:42:28)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;


ENTITY Lesson_32_ByteGenerator IS
  PORT( 
    --------------------------------------> Inputs:
    inReset:      IN  std_logic;
    Microcomputer_Module: IN  std_logic;
    inDown:       IN  std_logic;
    inUp:         IN  std_logic;
    iDSW:         IN  std_logic;
    --------------------------------------> Outputs:
    oBYTE_bhexb:  OUT std_logic_vector( 7 downto 0 );
    oBYTE_bbinb:  OUT std_logic_vector( 7 downto 0 );
    oError:       OUT std_logic 
    ------------------------------------------------------
    );
END Lesson_32_ByteGenerator;


ARCHITECTURE structural OF Lesson_32_ByteGenerator IS 

  ----------------------------------------> DMC8 Micro Computer(s):
  COMPONENT Microcomputer_Module IS
    PORT( 
          CK    : IN std_logic;	-- Actually not "On Board"!
          nRESET: IN std_logic;		
          --
          nINT  : IN std_logic;	-- In the "old" version, one only interrupt line
          --
          CKOUT : OUT std_logic;
          nRSOUT: OUT std_logic;
          nINTA : OUT std_logic;
          nSYNC : OUT std_logic;	-- PIN 7
          --
          nRA   : OUT std_logic;
          IA0   : IN std_logic;
          IA1   : IN std_logic;
          IA2   : IN std_logic;
          IA3   : IN std_logic;
          IA4   : IN std_logic;
          IA5   : IN std_logic;
          IA6   : IN std_logic;
          IA7   : IN std_logic;	-- PIN 16
          --
          nRB   : OUT std_logic;
          IB0   : IN std_logic;
          IB1   : IN std_logic;
          IB2   : IN std_logic;
          IB3   : IN std_logic;
          IB4   : IN std_logic;
          IB5   : IN std_logic;
          IB6   : IN std_logic;
          IB7   : IN std_logic;	-- PIN 25
          --
          nRC   : OUT std_logic;
          IC0   : IN std_logic;
          IC1   : IN std_logic;
          IC2   : IN std_logic;
          IC3   : IN std_logic;
          IC4   : IN std_logic;
          IC5   : IN std_logic;
          IC6   : IN std_logic;
          IC7   : IN std_logic;	-- PIN 34
          --
          nRD   : OUT std_logic;
          ID0   : IN std_logic;
          ID1   : IN std_logic;
          ID2   : IN std_logic;
          ID3   : IN std_logic;
          ID4   : IN std_logic;
          ID5   : IN std_logic;
          ID6   : IN std_logic;
          ID7   : IN std_logic;	-- PIN 43
          --
          nWA   : OUT std_logic;
          OA0   : OUT std_logic;
          OA1   : OUT std_logic;
          OA2   : OUT std_logic;
          OA3   : OUT std_logic;
          OA4   : OUT std_logic;
          OA5   : OUT std_logic;
          OA6   : OUT std_logic;
          OA7   : OUT std_logic;	-- PIN 52
          --
          nWB   : OUT std_logic;
          OB0   : OUT std_logic;
          OB1   : OUT std_logic;
          OB2   : OUT std_logic;
          OB3   : OUT std_logic;
          OB4   : OUT std_logic;
          OB5   : OUT std_logic;
          OB6   : OUT std_logic;
          OB7   : OUT std_logic;	-- PIN 61
          --
          nWC   : OUT std_logic;
          OC0   : OUT std_logic;
          OC1   : OUT std_logic;
          OC2   : OUT std_logic;
          OC3   : OUT std_logic;
          OC4   : OUT std_logic;
          OC5   : OUT std_logic;
          OC6   : OUT std_logic;
          OC7   : OUT std_logic;	-- PIN 70
          --
          nWD   : OUT std_logic;
          OD0   : OUT std_logic;
          OD1   : OUT std_logic;
          OD2   : OUT std_logic;
          OD3   : OUT std_logic;
          OD4   : OUT std_logic;
          OD5   : OUT std_logic;
          OD6   : OUT std_logic;
          OD7   : OUT std_logic;  -- PIN 79
          --
          NRES  : OUT std_logic;	-- Reset debug output
          STEP  : OUT std_logic;	-- Step by Step output
          S0		: IN	std_logic;	-- CPU register selection (5 bits + nibble)
          S1		: IN	std_logic;
          S2		: IN	std_logic;
          S3		: IN	std_logic;
          S4		: IN	std_logic;
          Ni		: IN	std_logic;
          R0		: OUT std_logic;
          R1		: OUT std_logic;
          R2		: OUT std_logic;
          R3		: OUT std_logic	-- PIN 91
          );
  END COMPONENT;
  --
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
  SIGNAL ncp4_C164: std_logic;
  SIGNAL ncp5_C164: std_logic;
  SIGNAL ncp6_C164: std_logic;
  SIGNAL ncp7_C164: std_logic;
  SIGNAL ncp8_C164: std_logic;
  SIGNAL ncp17_C164: std_logic;
  SIGNAL ncp18_C164: std_logic;
  SIGNAL ncp19_C164: std_logic;
  SIGNAL ncp20_C164: std_logic;
  SIGNAL ncp21_C164: std_logic;
  SIGNAL ncp22_C164: std_logic;
  SIGNAL ncp23_C164: std_logic;
  SIGNAL ncp24_C164: std_logic;
  SIGNAL ncp25_C164: std_logic;
  SIGNAL ncp26_C164: std_logic;
  SIGNAL ncp27_C164: std_logic;
  SIGNAL ncp28_C164: std_logic;
  SIGNAL ncp29_C164: std_logic;
  SIGNAL ncp30_C164: std_logic;
  SIGNAL ncp31_C164: std_logic;
  SIGNAL ncp32_C164: std_logic;
  SIGNAL ncp33_C164: std_logic;
  SIGNAL ncp34_C164: std_logic;
  SIGNAL ncp35_C164: std_logic;
  SIGNAL ncp36_C164: std_logic;
  SIGNAL ncp37_C164: std_logic;
  SIGNAL ncp38_C164: std_logic;
  SIGNAL ncp39_C164: std_logic;
  SIGNAL ncp40_C164: std_logic;
  SIGNAL ncp41_C164: std_logic;
  SIGNAL ncp42_C164: std_logic;
  SIGNAL ncp43_C164: std_logic;
  SIGNAL ncp44_C164: std_logic;
  SIGNAL ncp45_C164: std_logic;
  SIGNAL ncp46_C164: std_logic;
  SIGNAL ncp47_C164: std_logic;
  SIGNAL ncp48_C164: std_logic;
  SIGNAL ncp49_C164: std_logic;
  SIGNAL ncp50_C164: std_logic;
  SIGNAL ncp51_C164: std_logic;
  SIGNAL ncp52_C164: std_logic;
  SIGNAL ncp53_C164: std_logic;
  SIGNAL ncp54_C164: std_logic;
  SIGNAL ncp55_C164: std_logic;
  SIGNAL ncp56_C164: std_logic;
  SIGNAL ncp57_C164: std_logic;
  SIGNAL ncp58_C164: std_logic;
  SIGNAL ncp59_C164: std_logic;
  SIGNAL ncp60_C164: std_logic;
  SIGNAL ncp61_C164: std_logic;
  SIGNAL ncp62_C164: std_logic;
  SIGNAL ncp71_C164: std_logic;
  SIGNAL ncp72_C164: std_logic;
  SIGNAL ncp73_C164: std_logic;
  SIGNAL ncp74_C164: std_logic;
  SIGNAL ncp75_C164: std_logic;
  SIGNAL ncp76_C164: std_logic;
  SIGNAL ncp77_C164: std_logic;
  SIGNAL ncp78_C164: std_logic;
  SIGNAL ncp1_C165: std_logic;


BEGIN -- structural

  ----------------------------------------> Input:
  S001 <= inReset;
  ncp1_C165 <= inDown;
  S013 <= inUp;
  S014 <= iDSW;

  ----------------------------------------> Output:
  oBYTE_bhexb(0) <= S003;
  oBYTE_bhexb(1) <= S010;
  oBYTE_bhexb(2) <= S004;
  oBYTE_bhexb(3) <= S005;
  oBYTE_bhexb(4) <= S006;
  oBYTE_bhexb(5) <= S007;
  oBYTE_bhexb(6) <= S008;
  oBYTE_bhexb(7) <= S009;
  oBYTE_bbinb(0) <= S003;
  oBYTE_bbinb(1) <= S010;
  oBYTE_bbinb(2) <= S004;
  oBYTE_bbinb(3) <= S005;
  oBYTE_bbinb(4) <= S006;
  oBYTE_bbinb(5) <= S007;
  oBYTE_bbinb(6) <= S008;
  oBYTE_bbinb(7) <= S009;
  oError <= S011;

  ----------------------------------------> Constants:
  S002 <= '0';
  S012 <= '1';

  ----------------------------------------> Component Mapping:
  C164: Microcomputer_Module PORT MAP ( Clk_Microcomputer_Module, 
                                        S001, S012, ncp4_C164, 
                                        ncp5_C164, ncp6_C164, 
                                        ncp7_C164, ncp8_C164, 
                                        S014, S013, S002, S002, 
                                        S002, S002, S002, S002, 
                                        ncp17_C164, ncp18_C164, 
                                        ncp19_C164, ncp20_C164, 
                                        ncp21_C164, ncp22_C164, 
                                        ncp23_C164, ncp24_C164, 
                                        ncp25_C164, ncp26_C164, 
                                        ncp27_C164, ncp28_C164, 
                                        ncp29_C164, ncp30_C164, 
                                        ncp31_C164, ncp32_C164, 
                                        ncp33_C164, ncp34_C164, 
                                        ncp35_C164, ncp36_C164, 
                                        ncp37_C164, ncp38_C164, 
                                        ncp39_C164, ncp40_C164, 
                                        ncp41_C164, ncp42_C164, 
                                        ncp43_C164, ncp44_C164, 
                                        ncp45_C164, ncp46_C164, 
                                        ncp47_C164, ncp48_C164, 
                                        ncp49_C164, ncp50_C164, 
                                        ncp51_C164, ncp52_C164, 
                                        ncp53_C164, ncp54_C164, 
                                        ncp55_C164, ncp56_C164, 
                                        ncp57_C164, ncp58_C164, 
                                        ncp59_C164, ncp60_C164, 
                                        ncp61_C164, ncp62_C164, 
                                        S003, S010, S004, S005, 
                                        S006, S007, S008, S009, 
                                        ncp71_C164, ncp72_C164, 
                                        ncp73_C164, ncp74_C164, 
                                        ncp75_C164, ncp76_C164, 
                                        ncp77_C164, ncp78_C164, 
                                        S011, DR_Microcomputer_Module, 
                                        SS_Microcomputer_Module, 
                                        S0_Microcomputer_Module, 
                                        S1_Microcomputer_Module, 
                                        S2_Microcomputer_Module, 
                                        S3_Microcomputer_Module, 
                                        S4_Microcomputer_Module, 
                                        Ni_Microcomputer_Module, 
                                        R0_Microcomputer_Module, 
                                        R1_Microcomputer_Module, 
                                        R2_Microcomputer_Module, 
                                        R3_Microcomputer_Module );

END structural;
