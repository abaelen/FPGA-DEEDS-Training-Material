------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (30/12/2020, 16:42:26)
--      by Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------

------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (30/05/2018, 00:07:09)
--      by the Deeds (Digital Circuit Simulator)(Deeds-DcS)
--      Ver. 2.11.245 Beta (May 28, 2018)
-- Copyright (c) 2002-2018 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
------------------------------------------------------------
-- FPGA Board: "DE2 Board"
-- Chip FPGA: Intel/Altera Cyclone(r) II (EP2C35F672C6)
-- Proprietary EDA Tool: Quartus(r) II (Ver = 12.1sp1)
------------------------------------------------------------

--------------------------------------------------------------------------------
-- Original file Name: "T80.vhd"
--------------------------------------------------------------------------------
-- This VHDL code has been written modifying the original "T80.vhd" file,
-- originally written by Daniel Wallner (jesus@opencores.org), Copyright
-- (c) 2001-2002. The original code can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- This VHDL code describes the core of the DMC8 microprocessor,
-- a modified and reduced version of the original Z80 microprocessor, as part
-- of the DEEDS (Digital Electronics Education and Design Suite), a simulation
-- tool developer at DITEN (before "DIBE"), University of Genoa, Genoa, Italy
--
-- Giuliano Donzellini
--
-- The original disclaimer and copyright notice follows.
--------------------------------------------------------------------------------
--
-- Z80 compatible microprocessor core
--
-- Version : 0247
--
-- Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/


----------------------------------------------------------------------------
----------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DMC8 is
	port(
		RESET_n		: in std_logic;
		CLK			: in std_logic;
		IRQ0_n		: in std_logic;    -- IRQ0_n, IRQ1_n, IRQ2_n   (instead of INT_n only)
		IRQ1_n		: in std_logic;	 -- 7 interrupt requests, coded as bin number
		IRQ2_n		: in std_logic;
		SYNC_n		: out std_logic;
		MEMREQ_n		: out std_logic;
		IOREQ_n		: out std_logic;
		READ_n		: out std_logic;
		WRITE_n		: out std_logic;
		INTACK_n		: out std_logic;
		Addr			: out std_logic_vector(15 downto 0);
		DataIn		: in std_logic_vector(7 downto 0);
		DataOut		: out std_logic_vector(7 downto 0);
		-- Debug Interface ----------------------------
      oRes_n		: out std_logic;
      oStepSync   : out std_logic;
		S0				: in	std_logic;	-- CPU register selection (5 bits + nibble)
		S1				: in	std_logic;
		S2				: in	std_logic;
		S3				: in	std_logic;
		S4				: in	std_logic;
		Ni				: in	std_logic;
		R0				: out std_logic;
		R1				: out std_logic;
		R2				: out std_logic;
		R3				: out std_logic
		);
end DMC8;

architecture rtl of DMC8 is

	----------------------------------------------------------------------------
	component DMC8_Reg
	port(
	   RESn	: in std_logic;
		CK		: in std_logic;
		WEH   : in std_logic;
		WEL   : in std_logic;
		AddrA : in std_logic_vector(2 downto 0);
		AddrB : in std_logic_vector(2 downto 0);
		AddrC : in std_logic_vector(2 downto 0);
		DIH   : in std_logic_vector(7 downto 0);
		DIL   : in std_logic_vector(7 downto 0);
		DOAH  : out std_logic_vector(7 downto 0);
		DOAL  : out std_logic_vector(7 downto 0);
		DOBH  : out std_logic_vector(7 downto 0);
		DOBL  : out std_logic_vector(7 downto 0);
		DOCH  : out std_logic_vector(7 downto 0);
		DOCL  : out std_logic_vector(7 downto 0);
		-- Debug Interface ----------------------------
		DebugSel	: in std_logic_vector(2 downto 0);
		DebugDOH	: out std_logic_vector(7 downto 0);
		DebugDOL	: out std_logic_vector(7 downto 0)
		);
	end component;

	----------------------------------------------------------------------------
	component DMC8_MCode
	port(
		InstrReg		: in std_logic_vector(7 downto 0);
		ISet			: in std_logic_vector(1 downto 0);	-- Instr. Set (depending on previous Prefix)
		MCycle		: in std_logic_vector(2 downto 0);
		F				: in std_logic_vector(7 downto 0);
		IntCycle		: in std_logic;
		MCycles		: out std_logic_vector(2 downto 0);
		TStates		: out std_logic_vector(2 downto 0);
		Prefix		: out std_logic_vector(1 downto 0);	-- None,CB,ED,DD/FD
		Inc_PC		: out std_logic;
		Inc_WZ		: out std_logic;
		IncDec_16	: out std_logic_vector(3 downto 0);	-- BC,DE,HL,SP   0 is inc
		Read_To_Reg	: out std_logic;
		Read_To_Acc	: out std_logic;
		Set_BusA_To	: out std_logic_vector(3 downto 0);	-- B,C,D,E,H,L,DI/DB,A,SP(L),SP(M),0,F
		Set_BusB_To	: out std_logic_vector(3 downto 0);	-- B,C,D,E,H,L,DI,A,SP(L),SP(M),1,F,PC(L),PC(M),0
		ALU_Op		: out std_logic_vector(3 downto 0);	-- ADD, ADC, SUB, SBC, AND, XOR, OR, CP, ROT, BIT, SET, RES, DAA, RLD, RRD, None
		Save_ALU		: out std_logic;
		PreserveC	: out std_logic;
		Arith16	: out std_logic;
		Set_Addr_To	: out std_logic_vector(2 downto 0);	-- aNone,aXY,aIOA,aSP,aBC,aDE,aZI
		Jump			: out std_logic;
		JumpXY		: out std_logic;
		JumpINT		: out std_logic;
		Call			: out std_logic;
		RstP			: out std_logic;
		LDZ			: out std_logic;
		LDW			: out std_logic;
		LDSPHL		: out std_logic;
		ExchangeDH	: out std_logic;					-- re-added (donzie, 2017-04-29)
		ExchangeRp	: out std_logic;
		I_CPL			: out std_logic;
		I_CCF			: out std_logic;
		I_SCF			: out std_logic;
		I_RLD			: out std_logic;
		I_RRD			: out std_logic;
		I_INRC		: out std_logic;
		SetDI			: out std_logic;
		SetEI			: out std_logic;
		Halt			: out std_logic;
		DoIOReq		: out std_logic;
		DoRead		: out std_logic;
		DoWrite     : out std_logic
      );
  end component;


	----------------------------------------------------------------------------
	component DMC8_ALU
	generic(
		Flag_C : integer := 0;
		Flag_N : integer := 1;
		Flag_P : integer := 2;
		Flag_X : integer := 3;
		Flag_H : integer := 4;
		Flag_Y : integer := 5;
		Flag_Z : integer := 6;
		Flag_S : integer := 7
		);
	port(
		Arith16 : in std_logic;
		Z16     : in std_logic;
		ALU_Op  : in std_logic_vector(3 downto 0);
		IR      : in std_logic_vector(5 downto 0);
		ISet    : in std_logic_vector(1 downto 0);
		BusA    : in std_logic_vector(7 downto 0);
		BusB    : in std_logic_vector(7 downto 0);
		F_In    : in std_logic_vector(7 downto 0);
		Q       : out std_logic_vector(7 downto 0);
		F_Out   : out std_logic_vector(7 downto 0)
		);
	end component;


  ----------------------------------------------------------------------------
	constant aNone : std_logic_vector(2 downto 0) := "111";
	constant aBC   : std_logic_vector(2 downto 0) := "000";
	constant aDE   : std_logic_vector(2 downto 0) := "001";
	constant aXY   : std_logic_vector(2 downto 0) := "010";
	constant aIOA  : std_logic_vector(2 downto 0) := "100";
	constant aSP   : std_logic_vector(2 downto 0) := "101";
	constant aZI   : std_logic_vector(2 downto 0) := "110";

	constant Flag_C : integer := 0;  -- Flag bit positions
	constant Flag_N : integer := 1;
	constant Flag_P : integer := 2;
	constant Flag_X : integer := 3;
	constant Flag_H : integer := 4;
	constant Flag_Y : integer := 5;
	constant Flag_Z : integer := 6;
	constant Flag_S : integer := 7;

	----------------------------------------------------------------------------
	-- Registers and Register Busses
	signal ACC, F			: std_logic_vector(7 downto 0);
	signal SP, PC			: unsigned(15 downto 0);
	signal RegDIH			: std_logic_vector(7 downto 0);
	signal RegDIL			: std_logic_vector(7 downto 0);
	signal RegBusA			: std_logic_vector(15 downto 0);
	signal RegBusB			: std_logic_vector(15 downto 0);
	signal RegBusC			: std_logic_vector(15 downto 0);
	signal RegAddrA_r		: std_logic_vector(2 downto 0);
	signal RegAddrA		: std_logic_vector(2 downto 0);
	signal RegAddrB_r		: std_logic_vector(2 downto 0);
	signal RegAddrB		: std_logic_vector(2 downto 0);
	signal RegAddrC		: std_logic_vector(2 downto 0);
	signal RegWEH			: std_logic;
	signal RegWEL			: std_logic;

	-- CPU Register Debug Interface --------------------------------------------
	signal DebugRegSel   : std_logic_vector(4 downto 0);
	signal DebugRegData  : std_logic_vector(7 downto 0);
	signal DebugSel_i		: std_logic_vector(2 downto 0);
	signal DebugDOH_i		: std_logic_vector(7 downto 0);
	signal DebugDOL_i		: std_logic_vector(7 downto 0);

	----------------------------------------------------------------------------
	-- Help Registers
	signal DataIn_Reg		: std_logic_vector(7 downto 0);
	signal TmpAddr			: std_logic_vector(15 downto 0); -- Temporary address register
	signal InstrReg_i		: std_logic_vector(7 downto 0);  -- Instruction register
	signal ISet				: std_logic_vector(1 downto 0);  -- Instruction set selector
	signal RegBusA_r		: std_logic_vector(15 downto 0);
	
	signal ID16				: signed(15 downto 0);
	signal Save_Mux		: std_logic_vector(7 downto 0);
	signal TState_i		: unsigned(2 downto 0);           -- Current clock cycle: T1, T2, T3...
	signal MCycle_i		: std_logic_vector(2 downto 0);
	signal IntE_IFF		: std_logic;
	signal IRQ0_s			: std_logic; 							 -- before: signal "INT_s" only
	signal IRQ1_s			: std_logic;
	signal IRQ2_s			: std_logic;
	signal IRQ_num			: std_logic_vector(2 downto 0);	 -- Interrupt coded number (from 1 to 7)
	signal T_Res			: std_logic;
	signal XY_State		: std_logic_vector(1 downto 0);
	signal Pre_XY_F_M		: std_logic_vector(2 downto 0);
	signal NextIs_XY_Fetch: std_logic;
	signal XY_Displ_Read : std_logic;
	signal XY_Ind			: std_logic;

	----------------------------------------------------------------------------
	-- ALU signals
	signal BusB				: std_logic_vector(7 downto 0);
	signal BusA				: std_logic_vector(7 downto 0);
	signal ALU_Q			: std_logic_vector(7 downto 0);
	signal F_Out			: std_logic_vector(7 downto 0);

	----------------------------------------------------------------------------
	-- Registered micro code outputs
	signal Read_To_Reg_r	: std_logic_vector(4 downto 0);
	signal Arith16_r		: std_logic;
	signal Z16_r			: std_logic;
	signal ALU_Op_r		: std_logic_vector(3 downto 0);
	signal Save_ALU_r		: std_logic;
	signal PreserveC_r	: std_logic;
	signal MCycles			: std_logic_vector(2 downto 0);

	----------------------------------------------------------------------------
	-- Micro code outputs
	signal MCycles_d		: std_logic_vector(2 downto 0);
	signal TStates_i		: std_logic_vector(2 downto 0);
	signal IntCycle_i		: std_logic;
	signal SetIntCycle	: std_logic;
   signal Inc_PC			: std_logic;
	signal Inc_WZ			: std_logic;
	signal IncDec_16		: std_logic_vector(3 downto 0);
	signal Prefix			: std_logic_vector(1 downto 0);
	signal Read_To_Acc	: std_logic;
	signal Read_To_Reg	: std_logic;
	signal Set_BusB_To	: std_logic_vector(3 downto 0);
	signal Set_BusA_To	: std_logic_vector(3 downto 0);
	signal ALU_Op			: std_logic_vector(3 downto 0);
	signal Save_ALU		: std_logic;
	signal PreserveC		: std_logic;
	signal Arith16			: std_logic;
	signal Set_Addr_To	: std_logic_vector(2 downto 0);
	signal Jump_i			: std_logic;
	signal JumpXY			: std_logic;
	signal JumpINT_i		: std_logic;
	signal Call				: std_logic;
	signal RstP				: std_logic;
	signal LDZ				: std_logic;
	signal LDW				: std_logic;
	signal LDSPHL			: std_logic;

	signal IsFetch			: std_logic;      -- DMC8 Added
	signal DoIOReq_i		: std_logic;		-- DMC8 Added
	signal DoRead_i		: std_logic;		-- DMC8 added
	signal DoWrite_i		: std_logic;		-- DMC8 added

	signal ExchangeDH		: std_logic;		-- re-added (donzie, 2017-04-29)
	signal ExchangeRp		: std_logic;
	signal I_CPL			: std_logic;
	signal I_CCF			: std_logic;
	signal I_SCF			: std_logic;
	signal I_RLD			: std_logic;
	signal I_RRD			: std_logic;
	signal I_INRC			: std_logic;
	signal SetDI			: std_logic;
	signal SetEI			: std_logic;
	signal Halt				: std_logic;

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
begin
	oRes_n <= RESET_n;

	mcode : DMC8_MCode
		port map(
			InstrReg => InstrReg_i,
			ISet => ISet,
			MCycle => MCycle_i,
			F => F,
			IntCycle => IntCycle_i,
			MCycles => MCycles_d,
			TStates => TStates_i,
			Prefix => Prefix,
			Inc_PC => Inc_PC,
			Inc_WZ => Inc_WZ,
			IncDec_16 => IncDec_16,
			Read_To_Acc => Read_To_Acc,
			Read_To_Reg => Read_To_Reg,
			Set_BusB_To => Set_BusB_To,
			Set_BusA_To => Set_BusA_To,
			ALU_Op => ALU_Op,
			Save_ALU => Save_ALU,
			PreserveC => PreserveC,
			Arith16 => Arith16,
			Set_Addr_To => Set_Addr_To,
			Jump => Jump_i,
			JumpXY => JumpXY,
			JumpINT => JumpINT_i,
			Call => Call,
			RstP => RstP,
			LDZ => LDZ,
			LDW => LDW,
			LDSPHL => LDSPHL,
			ExchangeDH => ExchangeDH,
			ExchangeRp => ExchangeRp,
			I_CPL => I_CPL,
			I_CCF => I_CCF,
			I_SCF => I_SCF,
			I_RLD => I_RLD,
			I_RRD => I_RRD,
			I_INRC => I_INRC,
			SetDI => SetDI,
			SetEI => SetEI,
			Halt => Halt,
			DoIOReq => DoIOReq_i,
			DoRead => DoRead_i,
			DoWrite => DoWrite_i
			);

	alu : DMC8_ALU
	generic map(
		Flag_C => Flag_C,
		Flag_N => Flag_N,
		Flag_P => Flag_P,
		Flag_X => Flag_X,
		Flag_H => Flag_H,
		Flag_Y => Flag_Y,
		Flag_Z => Flag_Z,
		Flag_S => Flag_S)
	port map(
		Arith16 => Arith16_r,
		Z16     => Z16_r,
		ALU_Op  => ALU_Op_r,
		IR      => InstrReg_i(5 downto 0),
		ISet    => ISet,
		BusA    => BusA,
		BusB    => BusB,
		F_In    => F,
		Q       => ALU_Q,
		F_Out   => F_Out
		);

-----------------------------------------------------------------------------------------
	T_Res <=	'1'	when (TState_i = unsigned(TStates_i)) else
				'0';

	NextIs_XY_Fetch <= '1' when ((XY_State /= "00") and (XY_Ind = '0') and
										  ((Set_Addr_To = aXY) or
                                 (MCycle_i = "001" and InstrReg_i = "11001011") or      -- 'CB'
                                 (MCycle_i = "001" and InstrReg_i = "00110110")    ))   -- '36'
                          else '0';

	Save_Mux <= BusB       when ExchangeRp = '1' else
					DataIn_Reg when Save_ALU_r = '0' else
					ALU_Q;

-----------------------------------------------------------------------------------------
	-- Register Selection:
	DebugRegSel <= S4 & S3 & S2 & S1 & S0;
	DebugSel_i	<= S3 & S2 & S1;

	-- "Ni" defines if we obtain the nibble High (Ni=1) or Low (Ni=0):
	R3 <= DebugRegData(3) when (Ni = '0') else DebugRegData(7);
	R2 <= DebugRegData(2) when (Ni = '0') else DebugRegData(6);
	R1 <= DebugRegData(1) when (Ni = '0') else DebugRegData(5);
	R0 <= DebugRegData(0) when (Ni = '0') else DebugRegData(4);

	-- Selection of then requested CPU register
	DebugRegData <=
		std_logic_vector(PC(15 downto 8))	when (DebugRegSel = "00000") else -- PC.High
		std_logic_vector(PC( 7 downto 0))	when (DebugRegSel = "00001") else -- PC.Low
		std_logic_vector(SP(15 downto 8))	when (DebugRegSel = "00010") else -- SP.High
		std_logic_vector(SP( 7 downto 0))	when (DebugRegSel = "00011") else -- SP.Low
		--
		ACC				 							when (DebugRegSel = "00100") else -- Accumulator
		--
		"0000000" & F(Flag_C)					when (DebugRegSel = "00101") else -- C Flag
		"0000000" & F(Flag_N)					when (DebugRegSel = "00110") else -- N Flag
		"0000000" & F(Flag_P)					when (DebugRegSel = "00111") else -- P Flag
		"0000000" & F(Flag_H)					when (DebugRegSel = "01000") else -- H Flag
		"0000000" & F(Flag_Z)					when (DebugRegSel = "01001") else -- Z Flag
		"0000000" & F(Flag_S)					when (DebugRegSel = "01010") else -- S Flag
		--
		"0000000" & IntE_IFF						when (DebugRegSel = "01011") else -- Int. FF
		--
		DebugDOH_i 									when (DebugRegSel = "10000") else -- B reg.
		DebugDOL_i 									when (DebugRegSel = "10001") else -- C reg.
		DebugDOH_i 									when (DebugRegSel = "10010") else -- D reg.
		DebugDOL_i 									when (DebugRegSel = "10011") else -- E reg.
		DebugDOH_i 									when (DebugRegSel = "10100") else -- H reg.
		DebugDOL_i 									when (DebugRegSel = "10101") else -- L reg.
		--
		DebugDOH_i 									when (DebugRegSel = "10110") else -- IX reg High
		DebugDOL_i 									when (DebugRegSel = "10111") else -- IX reg Low
		DebugDOH_i 									when (DebugRegSel = "11110") else -- IY reg High
		DebugDOL_i 									when (DebugRegSel = "11111") else -- IY reg Low
		--
		"00000000";			--(when others)

-----------------------------------------------------------------------------------------
  process (RESET_n, CLK)
  begin
    if RESET_n = '0' then

      PC <= (others => '0');  -- Program Counter
      Addr <= (others => '0');   -- Address Bus

      TmpAddr <= (others => '0');
      InstrReg_i <= (others => '0');
      ISet <= "00";
      XY_State <= "00";
      MCycles <= "000";
      DataOut <= (others => '0');

      ACC <= (others => '0');       -- DMC8 clear ACC, F, SP
      F <= (others => '0');
      SP <= (others => '0');
      Read_To_Reg_r <= "00000";
      Arith16_r <= '0';
      Z16_r <= '0';
      ALU_Op_r <= "0000";
      Save_ALU_r <= '0';
      PreserveC_r <= '0';
      XY_Ind <= '0';

    elsif CLK'event and CLK = '1' then

        ALU_Op_r <= "0000";
        Save_ALU_r <= '0';
        Read_To_Reg_r <= "00000";

        MCycles <= MCycles_d;

        Arith16_r <= Arith16;
        PreserveC_r <= PreserveC;

        if (ISet = "10") and (ALU_OP(2) = '0') and (ALU_OP(0) = '1') and (MCycle_i = "011") then
				Z16_r <= '1';
        else
				Z16_r <= '0';
        end if;

        if (MCycle_i = "001") and (TState_i(2) = '0') then   -- MCycle_i = 1 and TState_i = 1, 2, or 3

          if TState_i = 2 then

            if (Jump_i = '0') and (Call = '0') and (IntCycle_i = '0') and (Halt /= '1') then
                 PC <= PC + 1;
            end if;

            if (IntCycle_i = '0') then
					InstrReg_i <= DataIn;		-- Instruction Fetch
				else
					InstrReg_i <= "00000000";	-- (NOP, when interrupted)
            end if;
				
            ISet <= "00";
            if (Prefix /= "00") then
              if (Prefix = "11") then  -- Prefix = '11' -->  'DD' or 'FD'...
                if InstrReg_i(5) = '1' then
						XY_State <= "10";		-- 'FD', IY register
                else
						XY_State <= "01";		-- 'DD', IX register
                end if;
              else
                if Prefix = "10" then  -- Prefix = '10' --> 'ED'...
                  XY_State <= "00";
                  XY_Ind <= '0';
                end if;
                ISet <= Prefix;			-- Prefix = '10' or '01' --> 'ED' or 'CB'
              end if;
            else
              XY_State <= "00";        -- No Prefix
              XY_Ind <= '0';
            end if;
          end if;

        else  	-- either (MCycle_i > 1) OR (MCycle_i = 1 AND TState_i > 3) 

          if (MCycle_i = "110") then
            XY_Ind <= '1';
            if Prefix = "01" then  -- if Prefix was 'CB'...
                ISet <= "01";
            end if;
          end if;

          if (T_Res = '1') then
            if (Jump_i = '1') then
              Addr(15 downto 8) <= DataIn_Reg;
              Addr(7 downto 0) <= TmpAddr(7 downto 0);
              PC(15 downto 8) <= unsigned(DataIn_Reg);
              PC(7 downto 0) <= unsigned(TmpAddr(7 downto 0));
            elsif (JumpXY = '1') then
              Addr <= RegBusC;
              PC <= unsigned(RegBusC);
            elsif (Call = '1') or (RstP = '1') or (JumpINT_i = '1') then
              Addr <= TmpAddr;
              PC <= unsigned(TmpAddr);
            else
              case Set_Addr_To is
				    ---------------------------------------------------------------------------------------
                when aXY =>   if (XY_State = "00") then
											Addr <= RegBusC;
                              else
											if (NextIs_XY_Fetch = '1') then
												Addr <= std_logic_vector(PC);
											else
												Addr <= TmpAddr;
											end if;
										end if;
				    ---------------------------------------------------------------------------------------
                when aIOA =>  Addr(15 downto 8) <= (others => '0');  -- IN A,(n) // OUT (n),A  -- (DMC8 Instr. Set)
                              Addr(7 downto 0) <= DataIn_Reg;
				    ---------------------------------------------------------------------------------------
                when aSP =>   Addr <= std_logic_vector(SP);
				    ---------------------------------------------------------------------------------------
                when aBC =>   if (DoIOReq_i = '1') then
                                Addr(15 downto 8) <= (others => '0');  -- IN r,(C) // OUT (C),r  -- (DMC8 Instr. Set)
                                Addr(7 downto 0) <= RegBusC(7 downto 0);
                              else
                                Addr <= RegBusC;                       -- LD A,(BC) // LD (BC),A
                              end if;
				    ---------------------------------------------------------------------------------------
                when aDE =>   Addr <= RegBusC;
				    ---------------------------------------------------------------------------------------
                when aZI =>   if Inc_WZ = '1' then
                                Addr <= std_logic_vector(unsigned(TmpAddr) + 1);
                              else
                                Addr(15 downto 8) <= DataIn_Reg;
                                Addr(7 downto 0) <= TmpAddr(7 downto 0);
                              end if;
				    ---------------------------------------------------------------------------------------
                when others =>  Addr <= std_logic_vector(PC);
				    ---------------------------------------------------------------------------------------
              end case;
            end if;

            Save_ALU_r <= Save_ALU;
            ALU_Op_r <= ALU_Op;

            if I_CPL = '1' then
              -- CPL
              ACC <= not ACC;
              F(Flag_H) <= '1';
              F(Flag_N) <= '1';
            end if;
            if I_CCF = '1' then
              -- CCF
              F(Flag_C) <= not F(Flag_C);
              F(Flag_H) <= F(Flag_C);
              F(Flag_N) <= '0';
            end if;
            if I_SCF = '1' then
              -- SCF
              F(Flag_C) <= '1';
              F(Flag_H) <= '0';
              F(Flag_N) <= '0';
            end if;

          end if; -- if (T_Res = '1')...

          if (TState_i = 2) then    
            if (ISet = "01") and (MCycle_i = "111") then
              InstrReg_i <= DataIn;			
            end if;
            if (Inc_PC = '1') then
              PC <= PC + 1;
            end if;
            if (RstP = '1') then
              TmpAddr <= (others =>'0');
              TmpAddr(5 downto 3) <= InstrReg_i(5 downto 3);
            end if;
				if (JumpINT_i = '1') then		-- DMC8
              TmpAddr <= (others =>'0');	-- before was only: TmpAddr(15 downto 0) <= "0000000000111000";  -- 0038h
              TmpAddr(5 downto 3) <= IRQ_num(2 downto 0);
            end if;
          end if;
			 
          if (TState_i = 3) and (MCycle_i = "110") then
            TmpAddr <= std_logic_vector(signed(RegBusC) + signed(DataIn_Reg));
          end if;

          if  (TState_i = 2) or (TState_i = 4 and MCycle_i = "001") then
				if (IncDec_16(2 downto 0) = "111") then
					if (IncDec_16(3) = '1') then
						SP <= SP - 1;
					else 
						SP <= SP + 1;
					end if;
            end if;
          end if;

          if (LDSPHL = '1') then
            SP <= unsigned(RegBusC);
          end if;
        end if;

        if (TState_i = 3) then
          if (LDZ = '1') then
             TmpAddr(7 downto 0) <= DataIn_Reg;
          end if;
          if LDW = '1' then
             TmpAddr(15 downto 8) <= DataIn_Reg;
          end if;
        end if; 

        if (Save_ALU_r = '1') or (ALU_Op_r = "1001") then
          F(7 downto 1) <= F_Out(7 downto 1);
          if (PreserveC_r = '0') then
            F(Flag_C) <= F_Out(0);
          end if;
        end if;
		  
        if (T_Res = '1') and (I_INRC) = '1' then
				F(Flag_H) <= '0';
				F(Flag_N) <= '0';
				if DataIn_Reg(7 downto 0) = "00000000" then
					F(Flag_Z) <= '1';
				else
					F(Flag_Z) <= '0';
				end if;
				F(Flag_S) <= DataIn_Reg(7);
				F(Flag_P) <= not (DataIn_Reg(0) xor DataIn_Reg(1) xor DataIn_Reg(2) xor DataIn_Reg(3) xor
					DataIn_Reg(4) xor DataIn_Reg(5) xor DataIn_Reg(6) xor DataIn_Reg(7)    );
        end if;

        if (TState_i = 1) then
          DataOut <= BusB;
          if (I_RLD = '1') then
            DataOut(3 downto 0) <= BusA(3 downto 0);
            DataOut(7 downto 4) <= BusB(3 downto 0);
          end if;
          if (I_RRD = '1') then
            DataOut(3 downto 0) <= BusB(7 downto 4);
            DataOut(7 downto 4) <= BusA(3 downto 0);
          end if;
        end if;

        if (T_Res = '1') then
          Read_To_Reg_r(3 downto 0) <= Set_BusA_To;
          Read_To_Reg_r(4) <= Read_To_Reg;
          if (Read_To_Acc = '1') then
            Read_To_Reg_r(3 downto 0) <= "0111";
            Read_To_Reg_r(4) <= '1';
          end if;
        end if;

        if (TState_i = 1 and Save_ALU_r = '0') or
           (Save_ALU_r = '1' and ALU_OP_r /= "0111") then
          case Read_To_Reg_r is
            when "10111" =>  ACC <= Save_Mux;
            when "10110" =>  DataOut <= Save_Mux;
            when "11000" =>  SP(7 downto 0) <= unsigned(Save_Mux);
            when "11001" =>  SP(15 downto 8) <= unsigned(Save_Mux);
            when "11011" =>  F <= Save_Mux;
            when others =>
          end case;
        end if;
    end if;
  end process;


---------------------------------------------------------------------------
-- BC('), DE('), HL('), IX and IY
---------------------------------------------------------------------------
	process (CLK)
	begin
		if CLK'event and CLK = '1' then
			-- Bus A / Write
			RegAddrA_r <= '0'& Set_BusA_To(2 downto 1);
			if (XY_Ind = '0') and (XY_State /= "00") and (Set_BusA_To(2 downto 1) = "10") then
				RegAddrA_r <= XY_State(1) & "11";
			end if;

			-- Bus B
			RegAddrB_r <= '0'& Set_BusB_To(2 downto 1);
			if (XY_Ind = '0') and (XY_State /= "00") and (Set_BusB_To(2 downto 1) = "10") then
				RegAddrB_r <= XY_State(1) & "11";
			end if;

			-- Address from register
			RegAddrC <= '0'& Set_Addr_To(1 downto 0);

			-- Jump (HL), LD SP,HL
			if (JumpXY = '1' or LDSPHL = '1') then
				RegAddrC <= '0'& "10";
			end if;
			if ((JumpXY = '1' or LDSPHL = '1') and XY_State /= "00") or (MCycle_i = "110") then
				RegAddrC <= XY_State(1) & "11";
			end if;
		
			RegBusA_r <= RegBusA;
		end if;
	end process;


----------------------------------------------------------------------------
	RegAddrA <=
			-- 16 bit increment/decrement
			'0'& IncDec_16(1 downto 0) when (TState_i = 2 or
				(TState_i = 3 and MCycle_i = "001" and IncDec_16(2) = '1')) and XY_State = "00" else
			XY_State(1) & "11"	when (TState_i = 2 or
				(TState_i = 3 and MCycle_i = "001" and IncDec_16(2) = '1')) and IncDec_16(1 downto 0) = "10" else
			-- EX HL,DL
			'0'& "10" when ExchangeDH = '1' and TState_i = 3 else
			'0'& "01" when ExchangeDH = '1' and TState_i = 4 else
			-- Bus A / Write
			RegAddrA_r;

	RegAddrB <=
			-- EX HL,DL
			'0'& "01" when ExchangeDH = '1' and TState_i = 3 else
			-- Bus B
			RegAddrB_r;

	ID16 <= 	signed(RegBusA) - 1 when IncDec_16(3) = '1' else
				signed(RegBusA) + 1;

----------------------------------------------------------------------------
	process (Save_ALU_r, ALU_OP_r, Read_To_Reg_r, 
				ExchangeDH, IncDec_16, MCycle_i, TState_i )
	begin
		RegWEH <= '0';
		RegWEL <= '0';
		if (TState_i = 1 and Save_ALU_r = '0') or
			(Save_ALU_r = '1' and ALU_OP_r /= "0111") then
			case Read_To_Reg_r is
			when "10000" | "10001" | "10010" | "10011" | "10100" | "10101" =>
				RegWEH <= not Read_To_Reg_r(0);
				RegWEL <= Read_To_Reg_r(0);
			when others =>
			end case;
		end if;

		if ExchangeDH = '1' and (TState_i = 3 or TState_i = 4) then
			RegWEH <= '1';
			RegWEL <= '1';
		end if;

		if IncDec_16(2) = '1' and ((TState_i = 2 and MCycle_i /= "001") or (TState_i = 3 and MCycle_i = "001")) then
			case IncDec_16(1 downto 0) is
			when "00" | "01" | "10" =>
				RegWEH <= '1';
				RegWEL <= '1';
			when others =>
			end case;
		end if;
	end process;

----------------------------------------------------------------------------
	process (Save_Mux, RegBusB, RegBusA_r, ID16, 
				ExchangeDH, IncDec_16, MCycle_i, TState_i )
	begin
		RegDIH <= Save_Mux;
		RegDIL <= Save_Mux;

		if ExchangeDH = '1' and TState_i = 3 then
			RegDIH <= RegBusB(15 downto 8);
			RegDIL <= RegBusB(7 downto 0);
		end if;
		if ExchangeDH = '1' and TState_i = 4 then
			RegDIH <= RegBusA_r(15 downto 8);
			RegDIL <= RegBusA_r(7 downto 0);
		end if;
		
		if IncDec_16(2) = '1' and ((TState_i = 2 and MCycle_i /= "001") or (TState_i = 3 and MCycle_i = "001")) then
			RegDIH <= std_logic_vector(ID16(15 downto 8));
			RegDIL <= std_logic_vector(ID16(7 downto 0));
		end if;
	end process;

----------------------------------------------------------------------------
	Regs : DMC8_Reg
	port map(
		RESn => RESET_n,
		CK	=> CLK,
		WEH => RegWEH,
		WEL => RegWEL,
		AddrA => RegAddrA,
		AddrB => RegAddrB,
		AddrC => RegAddrC,
		DIH => RegDIH,
		DIL => RegDIL,
		DOAH => RegBusA(15 downto 8),
		DOAL => RegBusA(7 downto 0),
		DOBH => RegBusB(15 downto 8),
		DOBL => RegBusB(7 downto 0),
		DOCH => RegBusC(15 downto 8),
		DOCL => RegBusC(7 downto 0),
		-- Debug Interface ----------------------------
		DebugSel	=> DebugSel_i,
		DebugDOH	=> DebugDOH_i,
		DebugDOL	=> DebugDOL_i );

---------------------------------------------------------------------------
-- Busses
---------------------------------------------------------------------------
	process (CLK)
	begin
		if CLK'event and CLK = '1' then
			case Set_BusB_To is
			when "0111" =>
				BusB <= ACC;
			when "0000" | "0001" | "0010" | "0011" | "0100" | "0101" =>
				if Set_BusB_To(0) = '1' then
					BusB <= RegBusB(7 downto 0);
				else
					BusB <= RegBusB(15 downto 8);
				end if;
			when "0110" =>	
				BusB <= DataIn_Reg;
			when "1000" =>	
				BusB <= std_logic_vector(SP(7 downto 0));
			when "1001" =>	
				BusB <= std_logic_vector(SP(15 downto 8));
			when "1010" =>	
				BusB <= "00000001";
			when "1011" =>	
				BusB <= F;
			when "1100" =>	
				BusB <= std_logic_vector(PC(7 downto 0));
			when "1101" =>	
				BusB <= std_logic_vector(PC(15 downto 8));
			when "1110" =>	
				BusB <= "00000000";
			when others =>	
				BusB <= "--------";
			end case;

			case Set_BusA_To is
			when "0111" =>   
				BusA <= ACC;
			when "0000" | "0001" | "0010" | "0011" | "0100" | "0101" =>
				if Set_BusA_To(0) = '1' then
					BusA <= RegBusA(7 downto 0);
				else
					BusA <= RegBusA(15 downto 8);
				end if;
			when "0110" =>	
				BusA <= DataIn_Reg;
			when "1000" =>	
				BusA <= std_logic_vector(SP(7 downto 0));
			when "1001" =>	
				BusA <= std_logic_vector(SP(15 downto 8));
			when "1010" =>	
				BusA <= "00000000";
			when others =>	
				BusB <= "--------";
			end case;
		end if;
	end process;


-------------------------------------------------------------------------
-- Data Input Synchronization                     (on Clock FALLING Edge)
-- "MEMREQ_n" timing
-- "IOREQ_n"  timing
-- "READ_n"   timing
--	"WRITE_n"  timing
-------------------------------------------------------------------------
	process (RESET_n, CLK)
	begin
		if RESET_n = '0' then

			DataIn_Reg <= "00000000";
			MEMREQ_n <= '1';
			IOREQ_n <= '1';
			READ_n <= '1';
			WRITE_n <= '1';

		elsif CLK'event and (CLK = '0') then  -- clock falling edge !

			-- MEMREQ_n timing ---------------------------------------------
			if ((IsFetch = '1') or (DoRead_i = '1') or (DoWrite_i = '1') or (XY_Displ_Read = '1')) and
			   (DoIOReq_i /='1')	and
				(not ((IsFetch = '1') and (IntCycle_i = '1'))) and
				((TState_i = 1) or (TState_i = 2)) then
					MEMREQ_n <= '0';
			else	MEMREQ_n <= '1';
			end if;

			-- IOREQ_n timing ----------------------------------------------
			if (DoIOReq_i = '1') and
				((DoRead_i = '1') or (DoWrite_i = '1')) and
				((TState_i = 1) or (TState_i = 2) or (TState_i = 3)) then
					IOREQ_n <= '0';
			else	IOREQ_n <= '1';
			end if;

			-- READ_n timing -----------------------------------------------
			if ((DoRead_i = '1') or (IsFetch = '1') or (XY_Displ_Read = '1')) and (IntCycle_i = '0') then
				if	(TState_i = 1) then
					READ_n <= '0';
				elsif	((TState_i = 3) and (DoIOReq_i /='1')) or		-- MemReq
						((TState_i = 4) and (DoIOReq_i = '1')) then	-- IoReq
					READ_n <= '1';
				end if;
			else
				READ_n <= '1';
			end if;

			-- WRITE_n timing ----------------------------------------------
			if (DoWrite_i = '1') then
				if	((TState_i = 2) and (DoIOReq_i /='1')) or		-- MemReq
					((TState_i = 3) and (DoIOReq_i = '1')) then	-- IoReq
					WRITE_n <= '0';
				elsif	((TState_i = 3) and (DoIOReq_i /='1')) or		-- MemReq
						((TState_i = 4) and (DoIOReq_i = '1')) then	-- IoReq
					WRITE_n <= '1';
				end if;
			end if;

			-- Data Input Buffering (not Instruction Fetching) ------------- 
			if ((DoRead_i = '1') and (IsFetch /= '1')) or (XY_Displ_Read = '1') then
				if	((TState_i = 3) and (DoIOReq_i /='1')) or		-- MemReq
					((TState_i = 4) and (DoIOReq_i = '1')) then	-- IoReq
						DataIn_Reg <= DataIn;
				end if;
			end if;
		end if;
	end process;

-------------------------------------------------------------------------
-- Syncronise Interrupt Requests   (on Clock Rising Edge)
-------------------------------------------------------------------------
  process (RESET_n, CLK)
  begin
    if RESET_n = '0' then
      IRQ0_s <= '0';							-- ex: INT_s <= '0';
      IRQ1_s <= '0';
      IRQ2_s <= '0';
    elsif CLK'event and CLK = '1' then
      IRQ0_s <= not IRQ0_n;				-- ex: INT_s <= not INT_n;
      IRQ1_s <= not IRQ1_n;
      IRQ2_s <= not IRQ2_n;
    end if;
  end process;

-------------------------------------------------------------------------
-- Main state machine
-------------------------------------------------------------------------
	process (RESET_n, CLK)
	begin
		if (RESET_n = '0') then
			MCycle_i <= "001";
			TState_i <= "000";
			IsFetch <= '0';
			XY_Displ_Read <= '0';	
			Pre_XY_F_M <= "000";
			IntCycle_i <= '0';
			SetIntCycle <= '0';
			INTACK_n <= '1';
			IntE_IFF <= '0';
			SYNC_n <= '1';
         oStepSync <= '0';
			IRQ_num <= (others => '0');

		elsif CLK'event and (CLK = '1') then

			---- "EI" and "DI" instructions ----------------------------------
			if TState_i = 2 then
				if SetEI = '1' then
					IntE_IFF <= '1';
				end if;
			end if;
			if TState_i = 3 then
				if SetDI = '1' then
					IntE_IFF <= '0';
				end if;
			end if;

			------------------------------------------------------------------
			if (T_Res = '1') then
				INTACK_n <= '1';
				XY_Displ_Read <= '0';
				TState_i <= "001";
				if (NextIs_XY_Fetch = '1') then
					XY_Displ_Read <= '1';
					MCycle_i <= "110";
					Pre_XY_F_M <= MCycle_i;
					if InstrReg_i = "00110110" then    -- LD(HL),n or LD(IX+d),n or LD(IY+d),n
						Pre_XY_F_M <= "010";
					end if;
				elsif (MCycle_i = "111") then
					MCycle_i <= std_logic_vector(unsigned(Pre_XY_F_M) + 1);
				elsif (MCycle_i = MCycles) then
					MCycle_i <= "001";
					IntCycle_i <= '0';
					if (IntE_IFF = '1' and ((IRQ2_s = '1') or		-- before: if (IntE_IFF = '1' and INT_s = '1') and...
													(IRQ1_s = '1') or 
													(IRQ0_s = '1'))  ) and
						(Prefix = "00") and
						(SetEI = '0') then								-- Next will be the Interrupt Cycle...
							IRQ_num <= (IRQ2_s & IRQ1_s & IRQ0_s);	-- (and the INT number is latched now)
							SetIntCycle <= '1';							-- Bug fix (2018-05-19), before:  IntCycle_i <= '1';
							INTACK_n <= '0';
							IntE_IFF <= '0';
					end if;
				else
					MCycle_i <= std_logic_vector(unsigned(MCycle_i) + 1);
				end if;
			else
				TState_i <= TState_i + 1;	-- Next "T" state
			end if;

			---- "IsFetch" and "SYNC_n" signals ------------------------------
			if (T_Res = '1') then					-- (Last TState_i)
				if (MCycle_i = MCycles) then
					IsFetch <= '1';
					if (Prefix = "00") then
                  -- (Note: do not generate SYNC in the secondary FETCH)
						SYNC_n <= '0';
					end if;
				else
            	IsFetch <= '0';
				end if;
			elsif (TState_i = 3) then
				if (MCycle_i = "001") then
					SYNC_n <= '1';
				end if;
			elsif (TState_i = 2) then
				if (MCycle_i = "001") then
               oStepSync <= '0';
				end if;
			elsif (TState_i = 1) then
				if (MCycle_i = "001") and (Prefix = "00") then
               oStepSync <= '1';      -- (='1' only in cycle T2 of the first byte fetch)
					--
					if (SetIntCycle = '1') then 	-- Added (2018-05-19) [bug fix interrupt]
						IntCycle_i <= '1';
						SetIntCycle <= '0';
					end if;
	   		end if;
			elsif (TState_i = 0) then    -- (only for hardware reset)
				IsFetch <= '1';
				SYNC_n <= '0';
            oStepSync <= '0';
			end if;

		end if;
	end process;
end;

--------------------------------------------------------------------------------
-- Original file Name: "T80_MCode.vhd"
--------------------------------------------------------------------------------
-- This VHDL code has been written modifying the original "T80_MCode.vhd" file,
-- originally written by Daniel Wallner (jesus@opencores.org), Copyright
-- (c) 2001-2002. The original code can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- This VHDL code describes the instruction decoder of the DMC8 microprocessor,
-- a modified and reduced version of the original Z80 microprocessor, as part
-- of the DEEDS (Digital Electronics Education and Design Suite), a simulation
-- tool developer at DITEN (before "DIBE"), University of Genoa, Genoa, Italy
--
-- Giuliano Donzellini
--
-- The original disclaimer and copyright notice follows.
--------------------------------------------------------------------------------
--
-- Z80 compatible microprocessor core
--
-- Version : 0242
--
-- Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- Limitations :
--
-- File history :
--
--	0208 : First complete release
--
--	0211 : Fixed IM 1
--
--	0214 : Fixed mostly flags, only the block instructions now fail the zex regression test
--
--	0235 : Added IM 2 fix by Mike Johnson
--
--	0238 : Added NoRead signal
--
--	0238b: Fixed instruction timing for POP and DJNZ
--
--	0240 : Added (IX/IY+d) states, removed op-codes from mode 2 and added all remaining mode 3 op-codes
--
--	0242 : Fixed I/O instruction timing, cleanup
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DMC8_MCode is
	port(
		InstrReg		: in std_logic_vector(7 downto 0);
		ISet			: in std_logic_vector(1 downto 0);
		MCycle		: in std_logic_vector(2 downto 0);
		F				: in std_logic_vector(7 downto 0);
		IntCycle		: in std_logic;
		MCycles		: out std_logic_vector(2 downto 0);
		TStates		: out std_logic_vector(2 downto 0);
		Prefix		: out std_logic_vector(1 downto 0); -- None,BC,ED,DD/FD
		Inc_PC		: out std_logic;
		Inc_WZ		: out std_logic;
		IncDec_16	: out std_logic_vector(3 downto 0); -- BC,DE,HL,SP   0 is inc
		Read_To_Reg	: out std_logic;
		Read_To_Acc	: out std_logic;
		Set_BusA_To	: out std_logic_vector(3 downto 0); -- B,C,D,E,H,L,DI/DB,A,SP(L),SP(M),0,F
		Set_BusB_To	: out std_logic_vector(3 downto 0); -- B,C,D,E,H,L,DI,A,SP(L),SP(M),1,F,PC(L),PC(M),0
		ALU_Op		: out std_logic_vector(3 downto 0); -- ADD, ADC, SUB, SBC, AND, XOR, OR, CP, ROT, BIT, SET, RES, DAA, RLD, RRD, None
		Save_ALU		: out std_logic;
		PreserveC	: out std_logic;
		Arith16		: out std_logic;
		Set_Addr_To	: out std_logic_vector(2 downto 0); -- aNone,aXY,aIOA,aSP,aBC,aDE,aZI
		Jump			: out std_logic;
		JumpXY		: out std_logic;
		JumpINT		: out std_logic;	-- DMC8 Added
		Call			: out std_logic;
		RstP			: out std_logic;
		LDZ			: out std_logic;
		LDW			: out std_logic;
		LDSPHL		: out std_logic;
		ExchangeDH	: out std_logic;
		ExchangeRp	: out std_logic;
		I_CPL			: out std_logic;
		I_CCF			: out std_logic;
		I_SCF			: out std_logic;
		I_RLD			: out std_logic;
		I_RRD			: out std_logic;
		I_INRC		: out std_logic;
		SetDI			: out std_logic;
		SetEI			: out std_logic;
		Halt			: out std_logic;
		DoIOReq		: out std_logic;	-- DMC8 Added
		DoRead		: out std_logic;	-- DMC8 Added
		DoWrite		: out std_logic 	-- DMC8 Added
		);
end DMC8_MCode;

architecture rtl of DMC8_MCode is

	constant aNone	: std_logic_vector(2 downto 0) := "111";
	constant aBC	: std_logic_vector(2 downto 0) := "000";
	constant aDE	: std_logic_vector(2 downto 0) := "001";
	constant aXY	: std_logic_vector(2 downto 0) := "010";
	constant aIOA	: std_logic_vector(2 downto 0) := "100";
	constant aSP	: std_logic_vector(2 downto 0) := "101";
	constant aZI	: std_logic_vector(2 downto 0) := "110";

	function is_cc_true( Flags: std_logic_vector(7 downto 0);
								cc : bit_vector(2 downto 0)			) return boolean is
	begin
		case cc is
		when "000" => return Flags(6) = '0'; -- NZ
		when "001" => return Flags(6) = '1'; -- Z
		when "010" => return Flags(0) = '0'; -- NC
		when "011" => return Flags(0) = '1'; -- C
		when "100" => return Flags(2) = '0'; -- PO
		when "101" => return Flags(2) = '1'; -- PE
		when "110" => return Flags(7) = '0'; -- P
		when "111" => return Flags(7) = '1'; -- M
		end case;
	end;

begin
   ------------------------------------------------------------------------------------------------
	process (InstrReg, IntCycle, ISet, MCycle, F)

		variable DDD  : std_logic_vector(2 downto 0);
		variable SSS  : std_logic_vector(2 downto 0);
		variable DPair: std_logic_vector(1 downto 0);
		variable InstrRegBit: bit_vector(7 downto 0);

	begin
		DDD := InstrReg(5 downto 3);
		SSS := InstrReg(2 downto 0);
		DPair := InstrReg(5 downto 4);
		InstrRegBit := to_bitvector(InstrReg);
		
		MCycles <= "001";
		if (MCycle = "001") then
			TStates <= "100";
		else
			TStates <= "011";
		end if;
		Prefix <= "00";
		Inc_PC <= '0';
		Inc_WZ <= '0';
		IncDec_16 <= "0000";
		Read_To_Acc <= '0';
		Read_To_Reg <= '0';
		Set_BusB_To <= "0000";
		Set_BusA_To <= "0000";
		ALU_Op <= "0" & InstrReg(5 downto 3);
		Save_ALU <= '0';
		PreserveC <= '0';
		Arith16 <= '0';
		DoIOReq <= '0';
		Set_Addr_To <= aNone;
		Jump <= '0';
		JumpXY <= '0';
		JumpINT <= '0';
		Call <= '0';
		RstP <= '0';
		LDZ <= '0';
		LDW <= '0';
		LDSPHL <= '0';
		ExchangeDH <= '0';
		ExchangeRp <= '0';
		I_CPL <= '0';
		I_CCF <= '0';
		I_SCF <= '0';
		I_RLD <= '0';
		I_RRD <= '0';
		I_INRC <= '0';
		SetDI <= '0';
		SetEI <= '0';
		Halt <= '0';
		DoRead <= '0';			-- DMC8 added !
		DoWrite <= '0';		-- DMC8 added !

	------------------------------------------------------------------------------------------------------
	-- DMC8 Interrupt Sequence (11 clock cycles)
	--                             (Note: for DMC8 this is similar, but not identical, to RST 38 sequence)
	------------------------------------------------------------------------------------------------------
		if (IntCycle = '1') then
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				TStates <= "101";
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1101";
			when 2 =>
				DoWrite <= '1';
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1100";
			when 3 =>
				DoWrite <= '1';
				JumpINT <= '1';			-- here, for the RST 38, instead:	RstP <= '1';			
			when others => null;
			end case;
		else

	------------------------------------------------------------------------------------------------------
	-- Instruction Decoder
	------------------------------------------------------------------------------------------------------
		case ISet is
		when "00" =>        -- ISet = '00', unprefixed instructions

	------------------------------------------------------------------------------------------------------
	-- Unprefixed Instructions
	------------------------------------------------------------------------------------------------------
		case InstrRegBit is

		------------------------------------------------------------------------------------------------------
		-- 8 BIT LOAD GROUP
		------------------------------------------------------------------------------------------------------
		when	"01000000"|"01000001"|"01000010"|"01000011"|"01000100"|"01000101"|"01000111"
			  |"01001000"|"01001001"|"01001010"|"01001011"|"01001100"|"01001101"|"01001111"
			  |"01010000"|"01010001"|"01010010"|"01010011"|"01010100"|"01010101"|"01010111"
			  |"01011000"|"01011001"|"01011010"|"01011011"|"01011100"|"01011101"|"01011111"
			  |"01100000"|"01100001"|"01100010"|"01100011"|"01100100"|"01100101"|"01100111"
			  |"01101000"|"01101001"|"01101010"|"01101011"|"01101100"|"01101101"|"01101111"
			  |"01111000"|"01111001"|"01111010"|"01111011"|"01111100"|"01111101"|"01111111" =>
			-- LD r,r'
			Set_BusB_To(2 downto 0) <= SSS;
			ExchangeRp <= '1';
			Set_BusA_To(2 downto 0) <= DDD;
			Read_To_Reg <= '1';

		------------------------------------------------------------------------------------------------------
		when "00000110"|"00001110"|"00010110"|"00011110"|"00100110"|"00101110"|"00111110" =>
			-- LD r,n
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				Set_BusA_To(2 downto 0) <= DDD;
				Read_To_Reg <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "01000110"|"01001110"|"01010110"|"01011110"|"01100110"|"01101110"|"01111110" =>
			-- LD r,(HL)
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aXY;
			when 2 =>
				Set_BusA_To(2 downto 0) <= DDD;
				Read_To_Reg <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "01110000"|"01110001"|"01110010"|"01110011"|"01110100"|"01110101"|"01110111" =>
			-- LD (HL),r
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aXY;
				Set_BusB_To(2 downto 0) <= SSS;
				Set_BusB_To(3) <= '0';
			when 2 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00110110" =>
			-- LD (HL),n
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				Set_Addr_To <= aXY;
				Set_BusB_To(2 downto 0) <= SSS;
				Set_BusB_To(3) <= '0';
				DoRead <= '1';
			when 3 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00001010" =>
			-- LD A,(BC)
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aBC;
			when 2 =>
				Read_To_Acc <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00011010" =>
			-- LD A,(DE)
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aDE;
			when 2 =>
				Read_To_Acc <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00111010" =>
			-- LD A,(nn)
			MCycles <= "100";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Set_Addr_To <= aZI;
				Inc_PC <= '1';
				DoRead <= '1';
			when 4 =>
				Read_To_Acc <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00000010" =>
			-- LD (BC),A
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aBC;
				Set_BusB_To <= "0111";
			when 2 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00010010" =>
			-- LD (DE),A
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aDE;
				Set_BusB_To <= "0111";
			when 2 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00110010" =>
			-- LD (nn),A
			MCycles <= "100";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Set_Addr_To <= aZI;
				Inc_PC <= '1';
				Set_BusB_To <= "0111";
				DoRead <= '1';
			when 4 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		-- 16 BIT LOAD GROUP
		------------------------------------------------------------------------------------------------------
		when "00000001"|"00010001"|"00100001"|"00110001" =>
			-- LD dd,nn
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				Read_To_Reg <= '1';
				if DPAIR = "11" then
					Set_BusA_To(3 downto 0) <= "1000";
				else
					Set_BusA_To(2 downto 1) <= DPAIR;
					Set_BusA_To(0) <= '1';
				end if;
				DoRead <= '1';
			when 3 =>
				Inc_PC <= '1';
				Read_To_Reg <= '1';
				if DPAIR = "11" then
					Set_BusA_To(3 downto 0) <= "1001";
				else
					Set_BusA_To(2 downto 1) <= DPAIR;
					Set_BusA_To(0) <= '0';
				end if;
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00101010" =>
			-- LD HL,(nn)
			MCycles <= "101";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Set_Addr_To <= aZI;
				Inc_PC <= '1';
				LDW <= '1';
				DoRead <= '1';
			when 4 =>
				Set_BusA_To(2 downto 0) <= "101"; -- L
				Read_To_Reg <= '1';
				Inc_WZ <= '1';
				Set_Addr_To <= aZI;
				DoRead <= '1';
			when 5 =>
				Set_BusA_To(2 downto 0) <= "100"; -- H
				Read_To_Reg <= '1';
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00100010" =>
			-- LD (nn),HL
			MCycles <= "101";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Set_Addr_To <= aZI;
				Inc_PC <= '1';
				LDW <= '1';
				Set_BusB_To <= "0101"; -- L
				DoRead <= '1';
			when 4 =>
				Inc_WZ <= '1';
				Set_Addr_To <= aZI;
				DoWrite <= '1';
				Set_BusB_To <= "0100"; -- H
			when 5 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11111001" =>
			-- LD SP,HL
			TStates <= "110";
			LDSPHL <= '1';

		------------------------------------------------------------------------------------------------------
		when "11000101"|"11010101"|"11100101"|"11110101" =>
			-- PUSH qq
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				TStates <= "101";
				IncDec_16 <= "1111";
				Set_Addr_TO <= aSP;
				if DPAIR = "11" then
					Set_BusB_To <= "0111";
				else
					Set_BusB_To(2 downto 1) <= DPAIR;
					Set_BusB_To(0) <= '0';
					Set_BusB_To(3) <= '0';
				end if;
			when 2 =>
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				if DPAIR = "11" then
					Set_BusB_To <= "1011";
				else
					Set_BusB_To(2 downto 1) <= DPAIR;
					Set_BusB_To(0) <= '1';
					Set_BusB_To(3) <= '0';
				end if;
				DoWrite <= '1';
			when 3 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000001"|"11010001"|"11100001"|"11110001" =>
			-- POP qq
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aSP;
			when 2 =>
				IncDec_16 <= "0111";
				Set_Addr_To <= aSP;
				Read_To_Reg <= '1';
				if DPAIR = "11" then
					Set_BusA_To(3 downto 0) <= "1011";
				else
					Set_BusA_To(2 downto 1) <= DPAIR;
					Set_BusA_To(0) <= '1';
				end if;
				DoRead <= '1';
			when 3 =>
				IncDec_16 <= "0111";
				Read_To_Reg <= '1';
				if DPAIR = "11" then
					Set_BusA_To(3 downto 0) <= "0111";
				else
					Set_BusA_To(2 downto 1) <= DPAIR;
					Set_BusA_To(0) <= '0';
				end if;
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		-- EXCHANGE, BLOCK TRANSFER AND SEARCH GROUP
		------------------------------------------------------------------------------------------------------
		when "11101011" =>									-- re-added (donzie, 2017-04-29)
			-- EX DE,HL
			ExchangeDH <= '1';
			
		------------------------------------------------------------------------------------------------------
		when "00001000" =>
    		-- EX AF,AF'
         -- NOP, not DMC8 Instructions
   		null;

		------------------------------------------------------------------------------------------------------
		when "11011001" =>
   		-- EXX
         -- NOP, not DMC8 Instructions
         null;

		------------------------------------------------------------------------------------------------------
		when "11100011" =>									-- re-added (donzie, 2017-04-29)
			-- EX (SP),HL
			MCycles <= "101";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aSP;
			when 2 =>
				Read_To_Reg <= '1';
				Set_BusA_To <= "0101";
				Set_BusB_To <= "0101";
				Set_Addr_To <= aSP;
			when 3 =>
				IncDec_16 <= "0111";
				Set_Addr_To <= aSP;
				TStates <= "100";
				DoWrite <= '1';
			when 4 =>
				Read_To_Reg <= '1';
				Set_BusA_To <= "0100";
				Set_BusB_To <= "0100";
				Set_Addr_To <= aSP;
			when 5 =>
				IncDec_16 <= "1111";
				TStates <= "101";
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		-- 8 BIT ARITHMETIC AND LOGICAL GROUP
		------------------------------------------------------------------------------------------------------
		when "10000000"|"10000001"|"10000010"|"10000011"|"10000100"|"10000101"|"10000111"
			 |"10001000"|"10001001"|"10001010"|"10001011"|"10001100"|"10001101"|"10001111"
			 |"10010000"|"10010001"|"10010010"|"10010011"|"10010100"|"10010101"|"10010111"
			 |"10011000"|"10011001"|"10011010"|"10011011"|"10011100"|"10011101"|"10011111"
			 |"10100000"|"10100001"|"10100010"|"10100011"|"10100100"|"10100101"|"10100111"
			 |"10101000"|"10101001"|"10101010"|"10101011"|"10101100"|"10101101"|"10101111"
			 |"10110000"|"10110001"|"10110010"|"10110011"|"10110100"|"10110101"|"10110111"
			 |"10111000"|"10111001"|"10111010"|"10111011"|"10111100"|"10111101"|"10111111" =>
			-- ADD A,r
			-- ADC A,r
			-- SUB A,r
			-- SBC A,r
			-- AND A,r
			-- OR A,r
			-- XOR A,r
			-- CP A,r
			Set_BusB_To(2 downto 0) <= SSS;
			Set_BusA_To(2 downto 0) <= "111";
			Read_To_Reg <= '1';
			Save_ALU <= '1';

		------------------------------------------------------------------------------------------------------
		when "10000110"|"10001110"|"10010110"|"10011110"|"10100110"|"10101110"|"10110110"|"10111110" =>
			-- ADD A,(HL)
			-- ADC A,(HL)
			-- SUB A,(HL)
			-- SBC A,(HL)
			-- AND A,(HL)
			-- OR A,(HL)
			-- XOR A,(HL)
			-- CP A,(HL)
			MCycles <= "010";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aXY;
			when 2 =>
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				Set_BusB_To(2 downto 0) <= SSS;
				Set_BusA_To(2 downto 0) <= "111";
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000110"|"11001110"|"11010110"|"11011110"|"11100110"|"11101110"|"11110110"|"11111110" =>
			-- ADD A,n
			-- ADC A,n
			-- SUB A,n
			-- SBC A,n
			-- AND A,n
			-- OR A,n
			-- XOR A,n
			-- CP A,n
			MCycles <= "010";
			if MCycle = "010" then
				Inc_PC <= '1';
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				Set_BusB_To(2 downto 0) <= SSS;
				Set_BusA_To(2 downto 0) <= "111";
				DoRead <= '1';
			end if;

		------------------------------------------------------------------------------------------------------
		when "00000100"|"00001100"|"00010100"|"00011100"|"00100100"|"00101100"|"00111100" =>
			-- INC r
			Set_BusB_To <= "1010";
			Set_BusA_To(2 downto 0) <= DDD;
			Read_To_Reg <= '1';
			Save_ALU <= '1';
			PreserveC <= '1';
			ALU_Op <= "0000";

		------------------------------------------------------------------------------------------------------
		when "00110100" =>
			-- INC (HL)
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aXY;
			when 2 =>
				TStates <= "100";
				Set_Addr_To <= aXY;
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				PreserveC <= '1';
				ALU_Op <= "0000";
				Set_BusB_To <= "1010";
				Set_BusA_To(2 downto 0) <= DDD;
				DoRead <= '1';
			when 3 =>
				DoWrite <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00000101"|"00001101"|"00010101"|"00011101"|"00100101"|"00101101"|"00111101" =>
			-- DEC r
			Set_BusB_To <= "1010";
			Set_BusA_To(2 downto 0) <= DDD;
			Read_To_Reg <= '1';
			Save_ALU <= '1';
			PreserveC <= '1';
			ALU_Op <= "0010";

		------------------------------------------------------------------------------------------------------
		when "00110101" =>
			-- DEC (HL)
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				Set_Addr_To <= aXY;
			when 2 =>
				TStates <= "100";
				Set_Addr_To <= aXY;
				ALU_Op <= "0010";
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				PreserveC <= '1';
				Set_BusB_To <= "1010";
				Set_BusA_To(2 downto 0) <= DDD;
				DoRead <= '1';
			when 3 =>
				DoWrite <= '1';
			when others => null;
			end case;


		------------------------------------------------------------------------------------------------------
		-- GENERAL PURPOSE ARITHMETIC AND CPU CONTROL GROUPS
		------------------------------------------------------------------------------------------------------
		when "00100111" =>
			-- DAA
			Set_BusA_To(2 downto 0) <= "111";
			Read_To_Reg <= '1';
			ALU_Op <= "1100";
			Save_ALU <= '1';

		------------------------------------------------------------------------------------------------------
		when "00101111" =>
			-- CPL
			I_CPL <= '1';

		------------------------------------------------------------------------------------------------------
		when "00111111" =>
			-- CCF
			I_CCF <= '1';

		------------------------------------------------------------------------------------------------------
		when "00110111" =>
			-- SCF
			I_SCF <= '1';

		------------------------------------------------------------------------------------------------------
		when "00000000" =>
         -- NOP
				null;

		------------------------------------------------------------------------------------------------------
		when "01110110" =>
			-- HALT
			Halt <= '1';

		------------------------------------------------------------------------------------------------------
		when "11110011" =>
			-- DI
			SetDI <= '1';

		------------------------------------------------------------------------------------------------------
		when "11111011" =>
			-- EI
			SetEI <= '1';

		------------------------------------------------------------------------------------------------------
		-- 16 BIT ARITHMETIC GROUP
		------------------------------------------------------------------------------------------------------
		when "00001001"|"00011001"|"00101001"|"00111001" =>
			-- ADD HL,ss
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				ALU_Op <= "0000";
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				Set_BusA_To(2 downto 0) <= "101";
				case to_integer(unsigned(InstrReg(5 downto 4))) is
				when 0|1|2 =>
					Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
					Set_BusB_To(0) <= '1';
				when others =>
					Set_BusB_To <= "1000";
				end case;
				TStates <= "100";
				Arith16 <= '1';
			when 3 =>
				Read_To_Reg <= '1';
				Save_ALU <= '1';
				ALU_Op <= "0001";
				Set_BusA_To(2 downto 0) <= "100";
				case to_integer(unsigned(InstrReg(5 downto 4))) is
				when 0|1|2 =>
					Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
				when others =>
					Set_BusB_To <= "1001";
				end case;
				Arith16 <= '1';
			when others =>
			end case;

		------------------------------------------------------------------------------------------------------
		when "00000011"|"00010011"|"00100011"|"00110011" =>
			-- INC ss
			TStates <= "110";
			IncDec_16(3 downto 2) <= "01";
			IncDec_16(1 downto 0) <= DPair;

		------------------------------------------------------------------------------------------------------
		when "00001011"|"00011011"|"00101011"|"00111011" =>
			-- DEC ss
			TStates <= "110";
			IncDec_16(3 downto 2) <= "11";
			IncDec_16(1 downto 0) <= DPair;

		------------------------------------------------------------------------------------------------------
		-- ROTATE AND SHIFT GROUP
		------------------------------------------------------------------------------------------------------
		when "00000111"
			-- RLCA
			|"00010111"
			-- RLA
			|"00001111"
			-- RRCA
			|"00011111" =>
			-- RRA
			Set_BusA_To(2 downto 0) <= "111";
			ALU_Op <= "1000";
			Read_To_Reg <= '1';
			Save_ALU <= '1';

		------------------------------------------------------------------------------------------------------
		-- JUMP GROUP
		------------------------------------------------------------------------------------------------------
		when "11000011" =>
			-- JP nn
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				LDZ <= '1';
			when 3 =>
				Inc_PC <= '1';
				DoRead <= '1';
				Jump <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000010"|"11001010"|"11010010"|"11011010"|"11100010"|"11101010"|"11110010"|"11111010" =>
		  	-- JP cc,nn
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				LDZ <= '1';
			when 3 =>
				Inc_PC <= '1';
				DoRead <= '1';
				if is_cc_true(F, to_bitvector(InstrReg(5 downto 3))) then
					Jump <= '1';
				end if;
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "00011000" =>
			-- JR e
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		when "00111000" =>
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		when "00110000" =>
			-- JR NC,e
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		when "00101000" =>
			-- JR Z,e
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		when "00100000" =>
			-- JR NZ,e
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		when "11101001" =>
			-- JP (HL)
			JumpXY <= '1';

		------------------------------------------------------------------------------------------------------
		when "00010000" =>
			-- DJNZ,e
         -- NOP, not a DMC8 Instruction
				null;

		------------------------------------------------------------------------------------------------------
		-- CALL AND RETURN GROUP
		------------------------------------------------------------------------------------------------------
		when "11001101" =>
			-- CALL nn
			MCycles <= "101";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				LDZ <= '1';
			when 3 =>
				IncDec_16 <= "1111";
				Inc_PC <= '1';
				DoRead <= '1';
				TStates <= "100";
				Set_Addr_To <= aSP;
				LDW <= '1';
				Set_BusB_To <= "1101";
			when 4 =>
				DoWrite <= '1';
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1100";
			when 5 =>
				DoWrite <= '1';
				Call <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000100"|"11001100"|"11010100"|"11011100"|"11100100"|"11101100"|"11110100"|"11111100" =>
			-- CALL cc,nn
			MCycles <= "101";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				LDZ <= '1';
			when 3 =>
				Inc_PC <= '1';
				DoRead <= '1';
				LDW <= '1';
				if is_cc_true(F, to_bitvector(InstrReg(5 downto 3))) then
					IncDec_16 <= "1111";
					Set_Addr_TO <= aSP;
					TStates <= "100";
					Set_BusB_To <= "1101";
				else
					MCycles <= "011";
				end if;
			when 4 =>
				DoWrite <= '1';
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1100";
			when 5 =>
				DoWrite <= '1';
				Call <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11001001" =>
			-- RET
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				TStates <= "101";
				Set_Addr_TO <= aSP;
			when 2 =>
				IncDec_16 <= "0111";
				Set_Addr_To <= aSP;
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Jump <= '1';
				IncDec_16 <= "0111";
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000000"|"11001000"|"11010000"|"11011000"|"11100000"|"11101000"|"11110000"|"11111000" =>
			-- RET cc
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				if is_cc_true(F, to_bitvector(InstrReg(5 downto 3))) then
					Set_Addr_TO <= aSP;
				else
					MCycles <= "001";
				end if;
					TStates <= "101";
			when 2 =>
				IncDec_16 <= "0111";
				Set_Addr_To <= aSP;
				LDZ <= '1';
				DoRead <= '1';
			when 3 =>
				Jump <= '1';
				IncDec_16 <= "0111";
				DoRead <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11000111"|"11001111"|"11010111"|"11011111"|"11100111"|"11101111"|"11110111"|"11111111" =>
			-- RST p
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 1 =>
				TStates <= "101";
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1101";
			when 2 =>
				DoWrite <= '1';
				IncDec_16 <= "1111";
				Set_Addr_To <= aSP;
				Set_BusB_To <= "1100";
			when 3 =>
				DoWrite <= '1';
				RstP <= '1';			
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		-- INPUT AND OUTPUT GROUP
		------------------------------------------------------------------------------------------------------
		when "11011011" =>
			-- IN A,(n)
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				Set_Addr_To <= aIOA;
			when 3 =>
				TStates <= "100";
				Read_To_Acc <= '1';
				DoRead <= '1';
				DoIOReq <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		when "11010011" =>
			-- OUT (n),A
			MCycles <= "011";
			case to_integer(unsigned(MCycle)) is
			when 2 =>
				Inc_PC <= '1';
				DoRead <= '1';
				Set_Addr_To <= aIOA;
				Set_BusB_To	<= "0111";
			when 3 =>
				TStates <= "100";
				DoWrite <= '1';
				DoIOReq <= '1';
			when others => null;
			end case;

		------------------------------------------------------------------------------------------------------
		-- MULTIBYTE INSTRUCTIONS
		------------------------------------------------------------------------------------------------------
		when "11001011" =>
			-- 'CB' Prefix  -- (prefix of a Multibyte Instruction)
			Prefix <= "01";

		------------------------------------------------------------------------------------------------------
		when "11101101" =>
			-- 'ED' Prefix  -- (prefix of a Multibyte Instruction)
			Prefix <= "10";

		------------------------------------------------------------------------------------------------------
		when "11011101"|"11111101" =>
			-- 'DD', 'FD' Prefixes  -- (prefixes of a Multibyte Instruction)
			Prefix <= "11";

		end case;   -- END ISet = "00" -----------------------------------------------------------------------
		------------------------------------------------------------------------------------------------------


	------------------------------------------------------------------------------------------------------
	-- 'CB' prefixed Multibyte Instructions
	------------------------------------------------------------------------------------------------------
		when "01" =>     -- ISet = "01" case

			Set_BusA_To(2 downto 0) <= InstrReg(2 downto 0);
			Set_BusB_To(2 downto 0) <= InstrReg(2 downto 0);
			
			case InstrRegBit is
			---------------------------------------------------------------------------------------------------
			when "00000000"|"00000001"|"00000010"|"00000011"|"00000100"|"00000101"|"00000111"
				 |"00010000"|"00010001"|"00010010"|"00010011"|"00010100"|"00010101"|"00010111"
				 |"00001000"|"00001001"|"00001010"|"00001011"|"00001100"|"00001101"|"00001111"
				 |"00011000"|"00011001"|"00011010"|"00011011"|"00011100"|"00011101"|"00011111"
				 |"00100000"|"00100001"|"00100010"|"00100011"|"00100100"|"00100101"|"00100111"
				 |"00101000"|"00101001"|"00101010"|"00101011"|"00101100"|"00101101"|"00101111"
				 |"00110000"|"00110001"|"00110010"|"00110011"|"00110100"|"00110101"|"00110111"
				 |"00111000"|"00111001"|"00111010"|"00111011"|"00111100"|"00111101"|"00111111" =>
				-- RLC r
				-- RL r
				-- RRC r
				-- RR r
				-- SLA r
				-- SRA r
				-- SRL r
				-- SLL r (Undocumented) / SWAP r
				if MCycle = "001" then
					ALU_Op <= "1000";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
				end if;
			---------------------------------------------------------------------------------------------------
			when "00000110"|"00010110"|"00001110"|"00011110"|"00101110"|"00111110"|"00100110"|"00110110" =>
				-- RLC (HL)
				-- RL (HL)
				-- RRC (HL)
				-- RR (HL)
				-- SRA (HL)
				-- SRL (HL)
				-- SLA (HL)
				-- SLL (HL) (Undocumented) / SWAP (HL)
				MCycles <= "011";
				case to_integer(unsigned(MCycle)) is
				when 1 | 7 =>
					Set_Addr_To <= aXY;
				when 2 =>
					ALU_Op <= "1000";
					Read_To_Reg <= '1';
					DoRead <= '1';
					Save_ALU <= '1';
					Set_Addr_To <= aXY;
					TStates <= "100";
				when 3 =>
					DoWrite <= '1';
				when others =>
				end case;
			---------------------------------------------------------------------------------------------------
			when "01000000"|"01000001"|"01000010"|"01000011"|"01000100"|"01000101"|"01000111"
		 		 |"01001000"|"01001001"|"01001010"|"01001011"|"01001100"|"01001101"|"01001111"
				 |"01010000"|"01010001"|"01010010"|"01010011"|"01010100"|"01010101"|"01010111"
				 |"01011000"|"01011001"|"01011010"|"01011011"|"01011100"|"01011101"|"01011111"
				 |"01100000"|"01100001"|"01100010"|"01100011"|"01100100"|"01100101"|"01100111"
				 |"01101000"|"01101001"|"01101010"|"01101011"|"01101100"|"01101101"|"01101111"
				 |"01110000"|"01110001"|"01110010"|"01110011"|"01110100"|"01110101"|"01110111"
				 |"01111000"|"01111001"|"01111010"|"01111011"|"01111100"|"01111101"|"01111111" =>
				-- BIT b,r
				if MCycle = "001" then
					Set_BusB_To(2 downto 0) <= InstrReg(2 downto 0);
					ALU_Op <= "1001";
				end if;

			---------------------------------------------------------------------------------------------------
			when "01000110"|"01001110"|"01010110"|"01011110"|"01100110"|"01101110"|"01110110"|"01111110" =>
				-- BIT b,(HL)
				MCycles <= "010";
				case to_integer(unsigned(MCycle)) is
				when 1 | 7 =>
					Set_Addr_To <= aXY;
				when 2 =>
					ALU_Op <= "1001";
					TStates <= "100";
					DoRead <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "11000000"|"11000001"|"11000010"|"11000011"|"11000100"|"11000101"|"11000111"
				 |"11001000"|"11001001"|"11001010"|"11001011"|"11001100"|"11001101"|"11001111"
				 |"11010000"|"11010001"|"11010010"|"11010011"|"11010100"|"11010101"|"11010111"
				 |"11011000"|"11011001"|"11011010"|"11011011"|"11011100"|"11011101"|"11011111"
				 |"11100000"|"11100001"|"11100010"|"11100011"|"11100100"|"11100101"|"11100111"
				 |"11101000"|"11101001"|"11101010"|"11101011"|"11101100"|"11101101"|"11101111"
				 |"11110000"|"11110001"|"11110010"|"11110011"|"11110100"|"11110101"|"11110111"
				 |"11111000"|"11111001"|"11111010"|"11111011"|"11111100"|"11111101"|"11111111" =>
				-- SET b,r
				if MCycle = "001" then
					ALU_Op <= "1010";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
				end if;

			---------------------------------------------------------------------------------------------------
			when "11000110"|"11001110"|"11010110"|"11011110"|"11100110"|"11101110"|"11110110"|"11111110" =>
				-- SET b,(HL)
				MCycles <= "011";
				case to_integer(unsigned(MCycle)) is
				when 1 | 7 =>
					Set_Addr_To <= aXY;
				when 2 =>
					ALU_Op <= "1010";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					Set_Addr_To <= aXY;
					TStates <= "100";
					DoRead <= '1';
				when 3 =>
					DoWrite <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "10000000"|"10000001"|"10000010"|"10000011"|"10000100"|"10000101"|"10000111"
				 |"10001000"|"10001001"|"10001010"|"10001011"|"10001100"|"10001101"|"10001111"
				 |"10010000"|"10010001"|"10010010"|"10010011"|"10010100"|"10010101"|"10010111"
				 |"10011000"|"10011001"|"10011010"|"10011011"|"10011100"|"10011101"|"10011111"
				 |"10100000"|"10100001"|"10100010"|"10100011"|"10100100"|"10100101"|"10100111"
				 |"10101000"|"10101001"|"10101010"|"10101011"|"10101100"|"10101101"|"10101111"
				 |"10110000"|"10110001"|"10110010"|"10110011"|"10110100"|"10110101"|"10110111"
				 |"10111000"|"10111001"|"10111010"|"10111011"|"10111100"|"10111101"|"10111111" =>
				-- RES b,r
				if MCycle = "001" then
					ALU_Op <= "1011";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
				end if;

			---------------------------------------------------------------------------------------------------
			when "10000110"|"10001110"|"10010110"|"10011110"|"10100110"|"10101110"|"10110110"|"10111110" =>
				-- RES b,(HL)
				MCycles <= "011";
				case to_integer(unsigned(MCycle)) is
				when 1 | 7 =>
					Set_Addr_To <= aXY;
				when 2 =>
					ALU_Op <= "1011";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					Set_Addr_To <= aXY;
					TStates <= "100";
					DoRead <= '1';
				when 3 =>
					DoWrite <= '1';
				when others =>
				end case;

			end case;    -- END ISet = "01" -------------------------------------------------------------------
			---------------------------------------------------------------------------------------------------

	------------------------------------------------------------------------------------------------------
	--  Prefix = "10" - 'ED', "11101101", 		Prefixed Multibyte Instructions
	--  Prefix = "11" - 'DD', "11011101", 
	--                  'FD', "11111101"
	------------------------------------------------------------------------------------------------------
		when others =>
		
			case InstrRegBit is
			---------------------------------------------------------------------------------------------------
			when "00000000"|"00000001"|"00000010"|"00000011"|"00000100"|"00000101"|"00000110"|"00000111"
			 	 |"00001000"|"00001001"|"00001010"|"00001011"|"00001100"|"00001101"|"00001110"|"00001111"
				 |"00010000"|"00010001"|"00010010"|"00010011"|"00010100"|"00010101"|"00010110"|"00010111"
				 |"00011000"|"00011001"|"00011010"|"00011011"|"00011100"|"00011101"|"00011110"|"00011111"
				 |"00100000"|"00100001"|"00100010"|"00100011"|"00100100"|"00100101"|"00100110"|"00100111"
				 |"00101000"|"00101001"|"00101010"|"00101011"|"00101100"|"00101101"|"00101110"|"00101111"
				 |"00110000"|"00110001"|"00110010"|"00110011"|"00110100"|"00110101"|"00110110"|"00110111"
				 |"00111000"|"00111001"|"00111010"|"00111011"|"00111100"|"00111101"|"00111110"|"00111111"

				 |"10000000"|"10000001"|"10000010"|"10000011"|"10000100"|"10000101"|"10000110"|"10000111"
				 |"10001000"|"10001001"|"10001010"|"10001011"|"10001100"|"10001101"|"10001110"|"10001111"
				 |"10010000"|"10010001"|"10010010"|"10010011"|"10010100"|"10010101"|"10010110"|"10010111"
				 |"10011000"|"10011001"|"10011010"|"10011011"|"10011100"|"10011101"|"10011110"|"10011111"
				 |                                            "10100100"|"10100101"|"10100110"|"10100111"
				 |                                            "10101100"|"10101101"|"10101110"|"10101111"
				 |                                            "10110100"|"10110101"|"10110110"|"10110111"
				 |                                            "10111100"|"10111101"|"10111110"|"10111111"
				 |"11000000"|"11000001"|"11000010"|"11000011"|"11000100"|"11000101"|"11000110"|"11000111"
				 |"11001000"|"11001001"|"11001010"|"11001011"|"11001100"|"11001101"|"11001110"|"11001111"
				 |"11010000"|"11010001"|"11010010"|"11010011"|"11010100"|"11010101"|"11010110"|"11010111"
				 |"11011000"|"11011001"|"11011010"|"11011011"|"11011100"|"11011101"|"11011110"|"11011111"
				 |"11100000"|"11100001"|"11100010"|"11100011"|"11100100"|"11100101"|"11100110"|"11100111"
				 |"11101000"|"11101001"|"11101010"|"11101011"|"11101100"|"11101101"|"11101110"|"11101111"
				 |"11110000"|"11110001"|"11110010"|"11110011"|"11110100"|"11110101"|"11110110"|"11110111"
				 |"11111000"|"11111001"|"11111010"|"11111011"|"11111100"|"11111101"|"11111110"|"11111111" =>
				null; -- NOP, undocumented

			---------------------------------------------------------------------------------------------------
			when "01111110"|"01111111" =>
				-- NOP, undocumented
				null;

			---------------------------------------------------------------------------------------------------
			-- 8 BIT LOAD GROUP
			---------------------------------------------------------------------------------------------------
			when "01010111" =>
				-- LD A,I
				-- NOP, not a DMC8 Instruction
				null;

			---------------------------------------------------------------------------------------------------
			when "01011111" =>
				-- LD A,R
				-- NOP, not a DMC8 Instruction
				null;

			---------------------------------------------------------------------------------------------------
			when "01000111" =>
				-- LD I,A
				-- NOP, not a DMC8 Instruction
				null;

			---------------------------------------------------------------------------------------------------
			when "01001111" =>
				-- LD R,A
				-- NOP, not a DMC8 Instruction
				null;

			---------------------------------------------------------------------------------------------------
			-- 16 BIT LOAD GROUP
			---------------------------------------------------------------------------------------------------
			when "01001011"|"01011011"|"01101011"|"01111011" =>
				-- LD dd,(nn)
				MCycles <= "101";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					Inc_PC <= '1';
					LDZ <= '1';
					DoRead <= '1';
				when 3 =>
					Set_Addr_To <= aZI;
					Inc_PC <= '1';
					LDW <= '1';
					DoRead <= '1';
				when 4 =>
					Read_To_Reg <= '1';
					if InstrReg(5 downto 4) = "11" then
						Set_BusA_To <= "1000";
					else
						Set_BusA_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusA_To(0) <= '1';
					end if;
					Inc_WZ <= '1';
					Set_Addr_To <= aZI;
					DoRead <= '1';
				when 5 =>
					Read_To_Reg <= '1';
					if InstrReg(5 downto 4) = "11" then
						Set_BusA_To <= "1001";
					else
						Set_BusA_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusA_To(0) <= '0';
					end if;
					DoRead <= '1';
				when others => null;
				end case;

			---------------------------------------------------------------------------------------------------
			when "01000011"|"01010011"|"01100011"|"01110011" =>
				-- LD (nn),dd
				MCycles <= "101";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					Inc_PC <= '1';
					LDZ <= '1';
					DoRead <= '1';
				when 3 =>
					Set_Addr_To <= aZI;
					Inc_PC <= '1';
					LDW <= '1';
					if InstrReg(5 downto 4) = "11" then
						Set_BusB_To <= "1000";
					else
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusB_To(0) <= '1';
						Set_BusB_To(3) <= '0';
					end if;
					DoRead <= '1';
				when 4 =>
					Inc_WZ <= '1';
					Set_Addr_To <= aZI;
					DoWrite <= '1';
					if InstrReg(5 downto 4) = "11" then
						Set_BusB_To <= "1001";
					else
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusB_To(0) <= '0';
						Set_BusB_To(3) <= '0';
					end if;
				when 5 =>
					DoWrite <= '1';
				when others => null;
				end case;

			---------------------------------------------------------------------------------------------------
			when "10100000" | "10101000" | "10110000" | "10111000" =>
				-- LDI, LDD, LDIR, LDDR
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "10100001" | "10101001" | "10110001" | "10111001" =>
				-- CPI, CPD, CPIR, CPDR
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "01000100"|"01001100"|"01010100"|"01011100"|"01100100"|"01101100"|"01110100"|"01111100" =>
				-- NEG
				Alu_OP <= "0010";
				Set_BusB_To <= "0111";
				Set_BusA_To <= "1010";
				Read_To_Acc <= '1';
				Save_ALU <= '1';

			---------------------------------------------------------------------------------------------------
			when "01000110"|"01001110"|"01100110"|"01101110" =>
				-- IM 0
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "01010110"|"01110110" =>
				-- IM 1
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "01011110"|"01110111" =>
				-- IM 2
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			-- 16 bit arithmetic
			---------------------------------------------------------------------------------------------------
			when "01001010"|"01011010"|"01101010"|"01111010" =>
				-- ADC HL,ss
				MCycles <= "011";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					ALU_Op <= "0001";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					Set_BusA_To(2 downto 0) <= "101";
					case to_integer(unsigned(InstrReg(5 downto 4))) is
					when 0|1|2 =>
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
					Set_BusB_To(0) <= '1';
						when others =>
						Set_BusB_To <= "1000";
					end case;
					TStates <= "100";
				when 3 =>
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					ALU_Op <= "0001";
					Set_BusA_To(2 downto 0) <= "100";
					case to_integer(unsigned(InstrReg(5 downto 4))) is
					when 0|1|2 =>
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusB_To(0) <= '0';
					when others =>
						Set_BusB_To <= "1001";
					end case;
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "01000010"|"01010010"|"01100010"|"01110010" =>
				-- SBC HL,ss
				MCycles <= "011";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					ALU_Op <= "0011";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					Set_BusA_To(2 downto 0) <= "101";
					case to_integer(unsigned(InstrReg(5 downto 4))) is
					when 0|1|2 =>
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
						Set_BusB_To(0) <= '1';
					when others =>
						Set_BusB_To <= "1000";
					end case;
					TStates <= "100";
				when 3 =>
					ALU_Op <= "0011";
					Read_To_Reg <= '1';
					Save_ALU <= '1';
					Set_BusA_To(2 downto 0) <= "100";
					case to_integer(unsigned(InstrReg(5 downto 4))) is
					when 0|1|2 =>
						Set_BusB_To(2 downto 1) <= InstrReg(5 downto 4);
					when others =>
							Set_BusB_To <= "1001";
					end case;
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "01101111" =>
				-- RLD
				MCycles <= "100";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					Set_Addr_To <= aXY;
				when 3 =>
					Read_To_Reg <= '1';
					Set_BusB_To(2 downto 0) <= "110";
					Set_BusA_To(2 downto 0) <= "111";
					ALU_Op <= "1101";
					TStates <= "100";
					Set_Addr_To <= aXY;
					Save_ALU <= '1';
					DoRead <= '1';
				when 4 =>
					I_RLD <= '1';
					DoWrite <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "01100111" =>
				-- RRD
				MCycles <= "100";
				case to_integer(unsigned(MCycle)) is
				when 2 =>
					Set_Addr_To <= aXY;
				when 3 =>
					Read_To_Reg <= '1';
					Set_BusB_To(2 downto 0) <= "110";
					Set_BusA_To(2 downto 0) <= "111";
					ALU_Op <= "1110";
					TStates <= "100";
					Set_Addr_To <= aXY;
					Save_ALU <= '1';
					DoRead <= '1';
				when 4 =>
					I_RRD <= '1';
					DoWrite <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "01000101"|"01001101"|"01010101"|"01011101"|"01100101"|"01101101"|"01110101"|"01111101" =>
				-- RETI, RETN
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "01000000"|"01001000"|"01010000"|"01011000"|"01100000"|"01101000"|"01110000"|"01111000" =>
				-- IN r,(C)
				MCycles <= "010";
				case to_integer(unsigned(MCycle)) is
				when 1 =>
					Set_Addr_To <= aBC;
				when 2 =>
					TStates <= "100";
					DoRead <= '1';
					DoIOReq <= '1';
					if InstrReg(5 downto 3) /= "110" then
						Read_To_Reg <= '1';
						Set_BusA_To(2 downto 0) <= InstrReg(5 downto 3);
					end if;
					I_INRC <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "01000001"|"01001001"|"01010001"|"01011001"|"01100001"|"01101001"|"01110001"|"01111001" =>
				-- OUT (C),r
				MCycles <= "010";
				case to_integer(unsigned(MCycle)) is
				when 1 =>
					Set_Addr_To <= aBC;
					Set_BusB_To(2 downto 0)	<= InstrReg(5 downto 3);
					if InstrReg(5 downto 3) = "110" then
						Set_BusB_To(3) <= '1';
					end if;
				when 2 =>
					TStates <= "100";
					DoWrite <= '1';
					DoIOReq <= '1';
				when others =>
				end case;

			---------------------------------------------------------------------------------------------------
			when "10100010" | "10101010" | "10110010" | "10111010" =>
				-- INI, IND, INIR, INDR
            -- NOP, not DMC8 Instructions
				null;

			---------------------------------------------------------------------------------------------------
			when "10100011" | "10101011" | "10110011" | "10111011" =>
				-- OUTI, OUTD, OTIR, OTDR
            -- NOP, not DMC8 Instructions
				null;

			end case;
		end case;

		-------------------------------------------------------------------------------------------------
		if MCycle = "110" then
			Inc_PC <= '1';
			if (InstrRegBit = "00110110") or
			   (InstrRegBit = "11001011") then
					Set_Addr_To <= aNone;
			end if;
		end if;
		-------------------------------------------------------------------------------------------------
		if MCycle = "111" then
			TStates <= "101";
			if ISet /= "01" then
				Set_Addr_To <= aXY;
			end if;
			Set_BusB_To(2 downto 0) <= SSS;
			Set_BusB_To(3) <= '0';
			if (InstrRegBit = "00110110") or (ISet = "01") then
				-- LD (HL),n
				Inc_PC <= '1';
				DoRead <= '1';
			end if;
		end if;
		-------------------------------------------------------------------------------------------------

		end if; -- if (IntCycle = '1') ---
	end process;
end;

--------------------------------------------------------------------------------
-- Original file Name: "T80_Reg.vhd"
--------------------------------------------------------------------------------
-- This VHDL code has been written modifying the original "T80_Reg.vhd" file,
-- originally written by Daniel Wallner (jesus@opencores.org), Copyright
-- (c) 2001-2002. The original code can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- This VHDL code describes part of the register set of the DMC8 microprocessor,
-- a modified and reduced version of the original Z80 microprocessor, as part
-- of the DEEDS (Digital Electronics Education and Design Suite), a simulation
-- tool developer at DITEN (before "DIBE"), University of Genoa, Genoa, Italy
--
-- Giuliano Donzellini
--
-- The original disclaimer and copyright notice follows.
--------------------------------------------------------------------------------
--
-- T80 Registers, technology independent
--
-- Version : 0244
--
-- Copyright (c) 2002 Daniel Wallner (jesus@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--	http://www.opencores.org/cvsweb.shtml/t51/
--
-- Limitations :
--
-- File history :
--
--	0242 : Initial release
--
--	0244 : Changed to single register file
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DMC8_Reg is
	port(
	   RESn		: in std_logic;
		CK			: in std_logic;
		WEH		: in std_logic;
		WEL		: in std_logic;
		AddrA		: in std_logic_vector(2 downto 0);
		AddrB		: in std_logic_vector(2 downto 0);
		AddrC		: in std_logic_vector(2 downto 0);
		DIH		: in std_logic_vector(7 downto 0);
		DIL		: in std_logic_vector(7 downto 0);
		DOAH		: out std_logic_vector(7 downto 0);
		DOAL		: out std_logic_vector(7 downto 0);
		DOBH		: out std_logic_vector(7 downto 0);
		DOBL		: out std_logic_vector(7 downto 0);
		DOCH		: out std_logic_vector(7 downto 0);
		DOCL		: out std_logic_vector(7 downto 0);
		-- Debug Interface ----------------------------
		DebugSel	: in std_logic_vector(2 downto 0);
		DebugDOH	: out std_logic_vector(7 downto 0);
		DebugDOL	: out std_logic_vector(7 downto 0)
	);
end DMC8_Reg;

architecture rtl of DMC8_Reg is

	type Register_Image is array (natural range <>) of std_logic_vector(7 downto 0);
	signal	RegsH	: Register_Image(0 to 7);
	signal	RegsL	: Register_Image(0 to 7);

begin

	process (RESn, CK)
	begin
		if RESn = '0' then
			RegsH(0) <= (others => '0'); 	RegsH(1) <= (others => '0'); 	RegsH(2) <= (others => '0'); 	RegsH(3) <= (others => '0');
			RegsH(4) <= (others => '0'); 	RegsH(5) <= (others => '0'); 	RegsH(6) <= (others => '0'); 	RegsH(7) <= (others => '0');
			RegsL(0) <= (others => '0'); 	RegsL(1) <= (others => '0'); 	RegsL(2) <= (others => '0'); 	RegsL(3) <= (others => '0');
			RegsL(4) <= (others => '0'); 	RegsL(5) <= (others => '0'); 	RegsL(6) <= (others => '0'); 	RegsL(7) <= (others => '0');
			--
		elsif CK'event and CK = '1' then
			if WEH = '1' then
				RegsH(to_integer(unsigned(AddrA))) <= DIH;
			end if;
			if WEL = '1' then
				RegsL(to_integer(unsigned(AddrA))) <= DIL;
			end if;
		end if;
	end process;

	DOAH <= RegsH(to_integer(unsigned(AddrA)));
	DOAL <= RegsL(to_integer(unsigned(AddrA)));
	DOBH <= RegsH(to_integer(unsigned(AddrB)));
	DOBL <= RegsL(to_integer(unsigned(AddrB)));
	DOCH <= RegsH(to_integer(unsigned(AddrC)));
	DOCL <= RegsL(to_integer(unsigned(AddrC)));

	-- Debug Register Access ----------------------------
	DebugDOH	<= RegsH(to_integer(unsigned(DebugSel)));
	DebugDOL	<= RegsL(to_integer(unsigned(DebugSel)));
end;

--------------------------------------------------------------------------------
-- Original file Name: "T80_ALU.vhd"
--------------------------------------------------------------------------------
-- This VHDL code has been written modifying the original "T80_ALU.vhd" file,
-- originally written by Daniel Wallner (jesus@opencores.org), Copyright
-- (c) 2001-2002. The original code can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- This VHDL code describes the Arithmetic and Logic Unit of the DMC8 microprocessor,
-- a modified and reduced version of the original Z80 microprocessor, as part
-- of the DEEDS (Digital Electronics Education and Design Suite), a simulation
-- tool developer at DITEN (before "DIBE"), University of Genoa, Genoa, Italy
--
-- Giuliano Donzellini
--
-- The original disclaimer and copyright notice follows.
--------------------------------------------------------------------------------
--
-- Z80 compatible microprocessor core
--
-- Version : 0247
--
-- Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
-- Limitations :
--
-- File history :
--
--	0214 : Fixed mostly flags, only the block instructions now fail the zex regression test
--
--	0238 : Fixed zero flag for 16 bit SBC and ADC
--
--	0240 : Added GB operations
--
--	0242 : Cleanup
--
--	0247 : Cleanup
--

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DMC8_ALU is
	generic(
		Flag_C : integer := 0;
		Flag_N : integer := 1;
		Flag_P : integer := 2;
		Flag_X : integer := 3;
		Flag_H : integer := 4;
		Flag_Y : integer := 5;
		Flag_Z : integer := 6;
		Flag_S : integer := 7
	);
	port(
		Arith16		: in std_logic;
		Z16	     	: in std_logic;
		ALU_Op		: in std_logic_vector(3 downto 0);
		IR	     	: in std_logic_vector(5 downto 0);
		ISet		: in std_logic_vector(1 downto 0);
		BusA		: in std_logic_vector(7 downto 0);
		BusB		: in std_logic_vector(7 downto 0);
		F_In		: in std_logic_vector(7 downto 0);
		Q	     	: out std_logic_vector(7 downto 0);
		F_Out		: out std_logic_vector(7 downto 0)
	);
end DMC8_ALU;

architecture rtl of DMC8_ALU is

	procedure AddSub(A : std_logic_vector;
			B : std_logic_vector;
			Sub : std_logic;
			Carry_In : std_logic;
			signal Res : out std_logic_vector;
			signal Carry : out std_logic) is

        variable B_i   : unsigned(A'length - 1 downto 0);
	variable Res_i : unsigned(A'length + 1 downto 0);
	begin
	  if Sub = '1' then  B_i := not unsigned(B);
	               else  B_i := unsigned(B);
	  end if;
	  Res_i := unsigned("0" & A & Carry_In) + unsigned("0" & B_i & "1");
	  Carry <= Res_i(A'length + 1);
	  Res <= std_logic_vector(Res_i(A'length downto 1));
	end;

	-- AddSub variables (temporary signals)
	signal	UseCarry		: std_logic;
	signal	Carry7_v		: std_logic;
	signal	Overflow_v		: std_logic;
	signal	HalfCarry_v		: std_logic;
	signal	Carry_v			: std_logic;
	signal	Q_v	       		: std_logic_vector(7 downto 0);

	signal	BitMask			: std_logic_vector(7 downto 0);

begin

	with IR(5 downto 3) select BitMask <= "00000001" when "000",
					      "00000010" when "001",
					      "00000100" when "010",
					      "00001000" when "011",
					      "00010000" when "100",
					      "00100000" when "101",
					      "01000000" when "110",
					      "10000000" when others;

	UseCarry <= not ALU_Op(2) and ALU_Op(0);
	AddSub(BusA(3 downto 0), BusB(3 downto 0), ALU_Op(1), ALU_Op(1) xor (UseCarry and F_In(Flag_C)), Q_v(3 downto 0), HalfCarry_v);
	AddSub(BusA(6 downto 4), BusB(6 downto 4), ALU_Op(1), HalfCarry_v, Q_v(6 downto 4), Carry7_v);
	AddSub(BusA(7 downto 7), BusB(7 downto 7), ALU_Op(1), Carry7_v, Q_v(7 downto 7), Carry_v);
	OverFlow_v <= Carry_v xor Carry7_v;

	process (Arith16, ALU_OP, F_In, BusA, BusB, IR, Q_v, Carry_v, HalfCarry_v, OverFlow_v, BitMask, ISet, Z16)
		variable Q_t : std_logic_vector(7 downto 0);
		variable DAA_Q : unsigned(8 downto 0);
	begin
		Q_t := "--------";
		F_Out <= F_In;
		DAA_Q := "---------";
		case ALU_Op is
		when "0000" | "0001" |  "0010" | "0011" | "0100" | "0101" | "0110" | "0111" =>
			F_Out(Flag_N) <= '0';
			F_Out(Flag_C) <= '0';
			case ALU_OP(2 downto 0) is
			when "000" | "001" => -- ADD, ADC
				Q_t := Q_v;
				F_Out(Flag_C) <= Carry_v;
				F_Out(Flag_H) <= HalfCarry_v;
				F_Out(Flag_P) <= OverFlow_v;
			when "010" | "011" | "111" => -- SUB, SBC, CP
				Q_t := Q_v;
				F_Out(Flag_N) <= '1';
				F_Out(Flag_C) <= not Carry_v;
				F_Out(Flag_H) <= not HalfCarry_v;
				F_Out(Flag_P) <= OverFlow_v;
			when "100" => -- AND
				Q_t(7 downto 0) := BusA and BusB;
				F_Out(Flag_H) <= '1';
			when "101" => -- XOR
				Q_t(7 downto 0) := BusA xor BusB;
				F_Out(Flag_H) <= '0';
			when others => -- OR "110"
				Q_t(7 downto 0) := BusA or BusB;
				F_Out(Flag_H) <= '0';
			end case;
			if ALU_Op(2 downto 0) = "111" then -- CP
				F_Out(Flag_X) <= BusB(3);
				F_Out(Flag_Y) <= BusB(5);
			else
				F_Out(Flag_X) <= Q_t(3);
				F_Out(Flag_Y) <= Q_t(5);
			end if;
			if Q_t(7 downto 0) = "00000000" then
				F_Out(Flag_Z) <= '1';
				if Z16 = '1' then
					F_Out(Flag_Z) <= F_In(Flag_Z);	-- 16 bit ADC,SBC
				end if;
			else
				F_Out(Flag_Z) <= '0';
			end if;
			F_Out(Flag_S) <= Q_t(7);
			case ALU_Op(2 downto 0) is
			when "000" | "001" | "010" | "011" | "111" => -- ADD, ADC, SUB, SBC, CP
			when others =>
				F_Out(Flag_P) <= not (Q_t(0) xor Q_t(1) xor Q_t(2) xor Q_t(3) xor
					Q_t(4) xor Q_t(5) xor Q_t(6) xor Q_t(7));
			end case;
			if Arith16 = '1' then
				F_Out(Flag_S) <= F_In(Flag_S);
				F_Out(Flag_Z) <= F_In(Flag_Z);
				F_Out(Flag_P) <= F_In(Flag_P);
			end if;
		when "1100" =>
			-- DAA
			F_Out(Flag_H) <= F_In(Flag_H);
			F_Out(Flag_C) <= F_In(Flag_C);
			DAA_Q(7 downto 0) := unsigned(BusA);
			DAA_Q(8) := '0';
			if F_In(Flag_N) = '0' then
				-- After addition
				-- Alow > 9 or H = 1
				if DAA_Q(3 downto 0) > 9 or F_In(Flag_H) = '1' then
					if (DAA_Q(3 downto 0) > 9) then
						F_Out(Flag_H) <= '1';
					else
						F_Out(Flag_H) <= '0';
					end if;
					DAA_Q := DAA_Q + 6;
				end if;
				-- new Ahigh > 9 or C = 1
				if DAA_Q(8 downto 4) > 9 or F_In(Flag_C) = '1' then
					DAA_Q := DAA_Q + 96; -- 0x60
				end if;
			else
				-- After subtraction
				if DAA_Q(3 downto 0) > 9 or F_In(Flag_H) = '1' then
					if DAA_Q(3 downto 0) > 5 then
						F_Out(Flag_H) <= '0';
					end if;
					DAA_Q(7 downto 0) := DAA_Q(7 downto 0) - 6;
				end if;
				if unsigned(BusA) > 153 or F_In(Flag_C) = '1' then
					DAA_Q := DAA_Q - 352; -- 0x160
				end if;
			end if;
			F_Out(Flag_X) <= DAA_Q(3);
			F_Out(Flag_Y) <= DAA_Q(5);
			F_Out(Flag_C) <= F_In(Flag_C) or DAA_Q(8);
			Q_t := std_logic_vector(DAA_Q(7 downto 0));
			if DAA_Q(7 downto 0) = "00000000" then
				F_Out(Flag_Z) <= '1';
			else
				F_Out(Flag_Z) <= '0';
			end if;
			F_Out(Flag_S) <= DAA_Q(7);
			F_Out(Flag_P) <= not (DAA_Q(0) xor DAA_Q(1) xor DAA_Q(2) xor DAA_Q(3) xor
				DAA_Q(4) xor DAA_Q(5) xor DAA_Q(6) xor DAA_Q(7));
		when "1101" | "1110" =>
			-- RLD, RRD
			Q_t(7 downto 4) := BusA(7 downto 4);
			if ALU_Op(0) = '1' then
				Q_t(3 downto 0) := BusB(7 downto 4);
			else
				Q_t(3 downto 0) := BusB(3 downto 0);
			end if;
			F_Out(Flag_H) <= '0';
			F_Out(Flag_N) <= '0';
			F_Out(Flag_X) <= Q_t(3);
			F_Out(Flag_Y) <= Q_t(5);
			if Q_t(7 downto 0) = "00000000" then
				F_Out(Flag_Z) <= '1';
			else
				F_Out(Flag_Z) <= '0';
			end if;
			F_Out(Flag_S) <= Q_t(7);
			F_Out(Flag_P) <= not (Q_t(0) xor Q_t(1) xor Q_t(2) xor Q_t(3) xor
				Q_t(4) xor Q_t(5) xor Q_t(6) xor Q_t(7));
		when "1001" =>
			-- BIT
			Q_t(7 downto 0) := BusB and BitMask;
			F_Out(Flag_S) <= Q_t(7);
			if Q_t(7 downto 0) = "00000000" then
				F_Out(Flag_Z) <= '1';
				F_Out(Flag_P) <= '1';
			else
				F_Out(Flag_Z) <= '0';
				F_Out(Flag_P) <= '0';
			end if;
			F_Out(Flag_H) <= '1';
			F_Out(Flag_N) <= '0';
			F_Out(Flag_X) <= '0';
			F_Out(Flag_Y) <= '0';
			if IR(2 downto 0) /= "110" then
				F_Out(Flag_X) <= BusB(3);
				F_Out(Flag_Y) <= BusB(5);
			end if;
		when "1010" =>
			-- SET
			Q_t(7 downto 0) := BusB or BitMask;
		when "1011" =>
			-- RES
			Q_t(7 downto 0) := BusB and not BitMask;
		when "1000" =>
			-- ROT
			case IR(5 downto 3) is
			when "000" => -- RLC
				Q_t(7 downto 1) := BusA(6 downto 0);
				Q_t(0) := BusA(7);
				F_Out(Flag_C) <= BusA(7);
			when "010" => -- RL
				Q_t(7 downto 1) := BusA(6 downto 0);
				Q_t(0) := F_In(Flag_C);
				F_Out(Flag_C) <= BusA(7);
			when "001" => -- RRC
				Q_t(6 downto 0) := BusA(7 downto 1);
				Q_t(7) := BusA(0);
				F_Out(Flag_C) <= BusA(0);
			when "011" => -- RR
				Q_t(6 downto 0) := BusA(7 downto 1);
				Q_t(7) := F_In(Flag_C);
				F_Out(Flag_C) <= BusA(0);
			when "100" => -- SLA
				Q_t(7 downto 1) := BusA(6 downto 0);
				Q_t(0) := '0';
				F_Out(Flag_C) <= BusA(7);
			when "110" => -- SLL (Undocumented) / SWAP
				Q_t(7 downto 1) := BusA(6 downto 0);
				Q_t(0) := '1';
				F_Out(Flag_C) <= BusA(7);
			when "101" => -- SRA
				Q_t(6 downto 0) := BusA(7 downto 1);
				Q_t(7) := BusA(7);
				F_Out(Flag_C) <= BusA(0);
			when others => -- SRL
				Q_t(6 downto 0) := BusA(7 downto 1);
				Q_t(7) := '0';
				F_Out(Flag_C) <= BusA(0);
			end case;
			F_Out(Flag_H) <= '0';
			F_Out(Flag_N) <= '0';
			F_Out(Flag_X) <= Q_t(3);
			F_Out(Flag_Y) <= Q_t(5);
			F_Out(Flag_S) <= Q_t(7);
			if Q_t(7 downto 0) = "00000000" then
				F_Out(Flag_Z) <= '1';
			else
				F_Out(Flag_Z) <= '0';
			end if;
			F_Out(Flag_P) <= not (Q_t(0) xor Q_t(1) xor Q_t(2) xor Q_t(3) xor
				Q_t(4) xor Q_t(5) xor Q_t(6) xor Q_t(7));
			if ISet = "00" then
				F_Out(Flag_P) <= F_In(Flag_P);
				F_Out(Flag_S) <= F_In(Flag_S);
				F_Out(Flag_Z) <= F_In(Flag_Z);
			end if;
		when others =>
			null;
		end case;
		Q <= Q_t;
	end process;
end;

