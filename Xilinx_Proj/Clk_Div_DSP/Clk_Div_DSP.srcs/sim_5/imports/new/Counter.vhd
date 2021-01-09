----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2021 16:40:15
-- Design Name: 
-- Module Name: Counter - Behavioral
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
library UNIMACRO;
use unimacro.vcomponents.all;

entity Counter is
    Port ( 
    clk : in STD_LOGIC;
    ck_io0 : out STD_LOGIC
    );
end Counter;

architecture Structural of Counter is

--signals defined
    SIGNAL siCOUNTER_TC_RST: std_logic ;
    SIGNAL siCOUNTER_TC_CE: std_logic ;
    SIGNAL siCOUNTER_TC_CLK: std_logic ;
    SIGNAL soCOUNTER_TC_TC: std_logic ;
    SIGNAL soCOUNTER_TC_Q: std_logic_vector (0 downto 0) ;
    
    SIGNAL siRESET: std_logic ;
    SIGNAL soRESET: std_logic ;
    
    SIGNAL siENABLE: std_logic ;
    SIGNAL siENABLE_CLK: std_logic ;
    SIGNAL soENABLE: std_logic ;
    
    SIGNAL siCLOCK: std_logic ;
    SIGNAL soCLOCK: std_logic ;
    
    SIGNAL siOUTPUT: std_logic_vector (0 downto 0) ;
    SIGNAL soOUTPUT: std_logic ;    
    
    SIGNAL siNOT: std_logic ;
    SIGNAL soNOT: std_logic ;
    
    SIGNAL siIBUF: std_logic ;
    SIGNAL soIBUF: std_logic ;
    
    SIGNAL siBUFG: std_logic ;
    SIGNAL soBUFG: std_logic ;

--components defined
    COMPONENT Not_gate IS
        port(i: in std_logic ; o: out std_logic );
    end component;
    
    component Reset is
        port(i: in std_logic ; o: out std_logic );
    end component;
    
    component Enable is
        port(i: in std_logic ; clk: in std_logic ; o: out std_logic );
    end component;
    
    component Clock is
        port(i: in std_logic ; o: out std_logic );
    end component;

    component Output is
        port(i: in std_logic_vector ; o: out std_logic );
    end component;
    
    
begin
    siCOUNTER_TC_RST <= soRESET;
    siCOUNTER_TC_CE <= soENABLE;
    siCOUNTER_TC_CLK <= soCLOCK;    
    
    ck_io0 <= soCOUNTER_TC_TC;
    
    
    siRESET <= soCLOCK;
    
    siNOT <= soRESET;
    
    siENABLE <= soNOT;
    siENABLE_CLK <= soCLOCK;
    
    siCLOCK <= soBUFG;
    
    siOUTPUT <= soCOUNTER_TC_Q;

    siIBUF <= clk;
    
    siBUFG <= soIBUF;

    cCOUNTER_TC: COUNTER_TC_MACRO
        GENERIC MAP (RESET_UPON_TC => "TRUE", DEVICE => "7SERIES", DIRECTION => "UP", COUNT_BY => X"000000000001", TC_VALUE => X"000000000256", WIDTH_DATA => 1)
        PORT MAP (RST => siCOUNTER_TC_RST, CE => siCOUNTER_TC_CE, CLK => siCOUNTER_TC_CLK, TC => soCOUNTER_TC_TC, Q => soCOUNTER_TC_Q);

    cRESET: Reset
        PORT MAP (i => siRESET, o => soRESET);
        
    cENABLE: Enable
        PORT MAP (i => siENABLE, clk => siENABLE_CLK, o => soENABLE);
        
    --cCLOCK: Clock
    --    PORT MAP (i => siCLOCK, o=> soCLOCK);
      soCLOCK <= siCLOCK;
        
        
    cOUTPUT: Output
        PORT MAP (i=> siOUTPUT, o=> soOUTPUT);
        
    cNOT: Not_gate
        PORT MAP (i => siNOT, o => soNOT);

    cBUF: IBUF
        PORT MAP (i => siIBUF, o=> soIBUF);
        
    cBUFG: BUFG
        PORT MAP (i => siBUFG, o=> soBUFG);

end Structural;
