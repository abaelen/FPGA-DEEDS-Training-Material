------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (8/01/2021, 18:35:37)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

--------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

ENTITY NOT_gate IS
  PORT( I: IN std_logic;
  	O: OUT std_logic );
END NOT_gate;

--------------------------------------------------------------------
ARCHITECTURE behavioral OF NOT_gate IS
BEGIN
  O <= (not I);
END behavioral;



--------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

ENTITY EXOR2_gate IS
  PORT( I0,I1: IN std_logic;
        O: OUT std_logic );
END EXOR2_gate;

--------------------------------------------------------------------
ARCHITECTURE behavioral OF EXOR2_gate IS
BEGIN
  O <= (I0 xor I1);
END behavioral;


--------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

ENTITY DpetFF IS
  PORT(  D, Ck   : IN std_logic;
         nCL, nPR: IN std_logic;
         Q, nQ   : OUT std_logic );
END DpetFF;

--------------------------------------------------------------------
ARCHITECTURE behavioral OF DpetFF IS 
BEGIN
  Dff: PROCESS( Ck, nCL, nPR ) 
  BEGIN
    if    (nCL = '0') and (nPR = '0') then  Q <= 'X';  nQ <= 'X';
    elsif (nCL = '0') and (nPR = '1') then  Q <= '0';  nQ <= '1';
    elsif (nCL = '1') and (nPR = '0') then  Q <= '1';  nQ <= '0';
    elsif (nCL = '1') and (nPR = '1') then
      if (Ck'event) AND (Ck='1') THEN -- Positive Edge -----------
                                            Q <=  D;   nQ <= not D;
      END IF;
    else                                    Q <= 'X';  nQ <= 'X';
    END IF;
  END PROCESS; 
END behavioral;

--------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Counter4 IS
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
END Counter4;

--------------------------------------------------------------------
ARCHITECTURE behavioral OF Counter4 IS
BEGIN
  Count4: PROCESS( Ck, nCL, ENP, ENT, UD )
  variable aCnt: unsigned( 3 downto 0 );
  BEGIN
    if    (nCL = '0') then            aCnt := (others =>'0');
    elsif (nCL = '1') then
      if (Ck'event) AND (Ck='1') then
        if    (LD = '1') then         aCnt := (P3 & P2 & P1 & P0); -- Load
        elsif (LD = '0') then
          if  (ENP = '1') and (ENT = '1')then
            if    (UD = '1') then
              if (aCnt < "1111") then aCnt := aCnt + 1;
              else                    aCnt := (others =>'0');
              end if;
            elsif (UD = '0') then
              if (aCnt > "0000") then aCnt := aCnt - 1;
              else                    aCnt := (others =>'1');
              end if;
            else                      aCnt := (others =>'X'); -- (UD: Unknown)
            END IF;
          elsif not((ENP ='0')or
                    (ENT ='0') ) then aCnt := (others =>'X'); -- (ENP: Unknown)
          END IF;
        else                          aCnt := (others =>'X'); -- (LD: Unknown)
        END IF;
      END IF;
    else                              aCnt := (others =>'X'); -- (nCL: Unknown)
    END IF;
    --
    Tc <= ENT and (    (aCnt(3) and aCnt(2) and aCnt(1) and aCnt(0) and UD) or
                   (not(aCnt(3) or  aCnt(2) or  aCnt(1) or  aCnt(0) or  UD)) );
    --
    Q3 <= aCnt(3);
    Q2 <= aCnt(2);
    Q1 <= aCnt(1);
    Q0 <= aCnt(0);
    --
  END PROCESS;
END behavioral;


