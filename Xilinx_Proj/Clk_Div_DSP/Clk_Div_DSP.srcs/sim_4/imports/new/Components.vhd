----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 18:23:38
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

entity Clock is
    Port ( i : in STD_LOGIC; o: out std_logic );
end Clock;

architecture Behavioral of Clock is
begin
    Clock: PROCESS(i)
    variable osc: std_logic :='0';
    begin 
        --if (i'event) AND (i='1') then 
        --    o <= osc;
        --    osc := (not osc);
        --end if;
        --if (i'event) AND (i='0') then o <= '0'; end if;
        o <= '0';
        if (i'event) AND (i='1') then o <= '1'; end if;
        if (i'event) AND (i='0') then o <= '0'; end if; 
    end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reset is
    Port (o: out std_logic; i: in std_logic );
end Reset;

architecture behavioral of Reset is
begin
    Reset: PROCESS 
    variable tr: boolean := false;
    variable pu: boolean := false;
    variable si: std_logic := '0';
    begin
        if (tr=false) and (pu=false) then
            tr := true;
            wait for 400ns;
        elsif (tr=true) and (pu=false) then            
            pu := true;
            si := '1';
            o <= si;
            wait for 200ns;
        elsif (tr = true) and (pu=true) then
            si := '0';
            o <= si;
            wait for 200ns;
        elsif (tr=false) and (pu=true) then
            tr:= true;
            wait for 200ns;
        end if;
        --o <= si;
        --wait for 200ns;
    end process;
end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Not_gate is
    Port (i: in std_logic; o: out std_logic );
end Not_gate;

architecture behavioral of Not_gate is
begin
    o <= (not i);
end behavioral; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Enable is
    Port (i: in std_logic; clk: in std_logic ; o: out std_logic);
end Enable;

architecture behavioral of Enable is
begin
    Enable: process(i,clk)
    variable cnt: integer range 0 to 4 :=0;
    variable tr: boolean :=false;
    begin
        --o <= '0';
        if (i'event) and (i='1') then
            tr :=true;
        end if;
        if (clk'event) and (clk = '1') then
            if (cnt < 4) then
                cnt := cnt + 1;
            end if;
        end if;
        
        if (tr = true) and (cnt >=4) then 
            o <='1';
        else o <= '0'; end if;
    end process;  
end behavioral; 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Output is
    Port (i: in std_logic_vector; o: out std_logic);
end Output;

architecture behavioral of Output is
begin
    o <= i(0);
end behavioral;
