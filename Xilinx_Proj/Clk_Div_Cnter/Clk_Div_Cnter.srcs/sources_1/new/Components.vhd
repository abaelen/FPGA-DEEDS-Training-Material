----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2021 12:38:20
-- Design Name: 
-- Module Name: Components - Behavioral
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter is
  Port (iclk: IN std_logic; oclk: OUT std_logic  );
end Counter;

architecture Behavioral of Counter is
begin
    Counter: process (iclk)
    variable cnt : integer range 0 to 134217728 :=0;
    variable o: std_logic :='0';
    begin
        if (iclk'event) and (iclk = '1') then 
            cnt := cnt + 1; 
            if (cnt =134217728) then
                o := (not o);
                cnt :=0;
            end if;    
            oclk <= o;
        end if;        
    end process;
end Behavioral;
