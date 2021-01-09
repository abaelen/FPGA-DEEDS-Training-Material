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
    SIGNAL siBUFGCE_CE: std_logic;
    SIGNAL soLED: std_logic;
    SIGNAL S005: std_logic;
    SIGNAL S006: std_logic;
    SIGNAL S007: std_logic;
    SIGNAL S008: std_logic;
    SIGNAL S009: std_logic;
    SIGNAL S010: std_logic;
  ----------------------------------------> Components:
      

BEGIN -- structural   
  ----------------------------------------> Input:
    siCLK <= iCLK;
  ----------------------------------------> Constants:
    siBUFGCE_CE <= '1';
  ----------------------------------------> Output:
    oLED <= soLED;
  ----------------------------------------> Component Mapping:
    
    
