------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (3/01/2021, 13:52:19)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
library UNISIM;
use UNISIM.VComponents.all;
library UNIMACRO;
use UNIMACRO.VComponents.all;


ENTITY Blinking_led IS
  PORT( 
    --------------------------------------> Inputs:
    iCLK:           IN  std_logic;
    --------------------------------------> Outputs:
    oLED:           OUT std_logic
    ------------------------------------------------------
    );
END Blinking_led;

ARCHITECTURE structural OF Blinking_led IS 

  ----------------------------------------> Signals:
    SIGNAL siCLK: std_logic;
    SIGNAL soLED: std_logic;
    SIGNAL siBUFGCE_I: std_logic;
    SIGNAL siBUFGCE_CE: std_logic;
    SIGNAL soBUFGCE_O: std_logic;
    SIGNAL siCOUNTER_TC_RST: std_logic;
    SIGNAL siCOUNTER_TC_CE: std_logic;
    SIGNAL siCOUNTER_TC_CLK: std_logic;
    SIGNAL soCOUNTER_TC_TC: std_logic;
    SIGNAL soCOUNTER_TC_Q: std_logic;
    SIGNAL siXOR1: std_logic;
    SIGNAL soXOR: std_logic ;
    SIGNAL siXOR2: std_logic ;
  ----------------------------------------> Components:
    COMPONENT XOR2_GATE IS
        PORT(I0: IN std_logic; I1: IN std_logic ; O: OUT std_logic);
    END COMPONENT;

BEGIN -- structural   
  ----------------------------------------> BUFGCE:
    siCLK <= iCLK;
    siBUFGCE_I <= siCLK;
    siBUFGCE_CE <= soXOR;
    
  ----------------------------------------> COUNTER:
    siCOUNTER_TC_RST <= '1';
    siCOUNTER_TC_CLK <= siCLK;
    siCOUNTER_TC_CE <= '1';
        
  ----------------------------------------> XOR:
    siXOR1 <= soCOUNTER_TC_TC;
    siXOR2 <= soBUFGCE_O;
    
  ----------------------------------------> Output:
    oLED <= soBUFGCE_O;
  ----------------------------------------> Component Mapping:
    cBUFGCE: BUFGCE 
        PORT MAP (CE => siBUFGCE_CE, I => siBUFGCE_I, O => soBUFGCE_O);
    
    cCOUNTER_TC: COUNTER_TC_MACRO 
        PORT MAP(TC => soCOUNTER_TC_TC, CE => siCOUNTER_TC_CE, CLK => siCOUNTER_TC_CLK, RST => siCOUNTER_TC_RST);
         
    cXOR: XOR2_GATE PORT MAP (I0 => siXOR1, I1 => siXOR2, O => soXOR); 
    
    
END structural;