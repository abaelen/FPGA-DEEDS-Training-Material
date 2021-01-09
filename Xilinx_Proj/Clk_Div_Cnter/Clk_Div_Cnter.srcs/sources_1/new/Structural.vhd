----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 12:25:22
-- Design Name: 
-- Module Name: Structural - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity ClockDivider is
    Port ( 
            clk : in STD_LOGIC;
            ck_io0 : out std_logic 
          );
end ClockDivider;

architecture Structural of ClockDivider is

 
    SIGNAL siIBUF: std_logic;
    SIGNAL soIBUF: std_logic ;
    
    SIGNAL siBUFG: std_logic ;
    SIGNAL soBUFG: std_logic ;

    SIGNAL siCOUNTER: std_logic ;
    SIGNAL soCOUNTER: std_logic ;
    
    component Counter IS
        PORT (iclk: IN std_logic ; oclk: OUT std_logic );
    end component;

begin

    cIBUF: IBUF PORT MAP (i => siIBUF, o => soIBUF);
    cBUFG: BUFG PORT MAP (i => siBUFG, o => soBUFG);
    cCounter: Counter PORT MAP (iclk => siCOUNTER, oclk => soCOUNTER);
    
    siIBUF <= clk;
    siBUFG <= soIBUF;
    siCOUNTER <= soBUFG;
    
    ck_io0 <= soCOUNTER;
    
end Structural;
