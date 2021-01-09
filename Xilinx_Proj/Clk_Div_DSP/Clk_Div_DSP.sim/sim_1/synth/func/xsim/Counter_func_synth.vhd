-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Sat Jan  9 00:59:43 2021
-- Host        : Gebruiker-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/X_projects/Cnt/Cnt.sim/sim_1/synth/func/xsim/Counter_func_synth.vhd
-- Design      : Counter
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Reset is
  port (
    soRESET : out STD_LOGIC
  );
end Reset;

architecture STRUCTURE of Reset is
  signal \Reset.pu_reg_i_1_n_0\ : STD_LOGIC;
  signal \Reset.tr_reg_i_1_n_0\ : STD_LOGIC;
  signal o_reg_i_1_n_0 : STD_LOGIC;
  signal pu : STD_LOGIC;
  signal tr : STD_LOGIC;
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of \Reset.pu_reg\ : label is "LD";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \Reset.pu_reg_i_1\ : label is "soft_lutpair0";
  attribute XILINX_LEGACY_PRIM of \Reset.tr_reg\ : label is "LD";
  attribute SOFT_HLUTNM of \Reset.tr_reg_i_1\ : label is "soft_lutpair0";
  attribute XILINX_LEGACY_PRIM of o_reg : label is "LD";
begin
\Reset.pu_reg\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => '1',
      G => \Reset.pu_reg_i_1_n_0\,
      GE => '1',
      Q => pu
    );
\Reset.pu_reg_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"4"
    )
        port map (
      I0 => pu,
      I1 => tr,
      O => \Reset.pu_reg_i_1_n_0\
    );
\Reset.tr_reg\: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => '1',
      G => \Reset.tr_reg_i_1_n_0\,
      GE => '1',
      Q => tr
    );
\Reset.tr_reg_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => tr,
      I1 => pu,
      O => \Reset.tr_reg_i_1_n_0\
    );
o_reg: unisim.vcomponents.LDCE
    generic map(
      INIT => '0'
    )
        port map (
      CLR => '0',
      D => o_reg_i_1_n_0,
      G => tr,
      GE => '1',
      Q => soRESET
    );
o_reg_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => tr,
      I1 => pu,
      O => o_reg_i_1_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity unimacro_COUNTER_TC_MACRO is
  port (
    ck_io0_OBUF : out STD_LOGIC;
    soRESET : in STD_LOGIC
  );
end unimacro_COUNTER_TC_MACRO;

architecture STRUCTURE of unimacro_COUNTER_TC_MACRO is
  signal CNTR_OUT : STD_LOGIC_VECTOR ( 47 downto 0 );
  signal \bl.DSP48E_2_i_1_n_0\ : STD_LOGIC;
  signal \bl.DSP48E_2_i_2_n_0\ : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_10_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_11_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_12_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_13_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_2_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_3_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_4_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_5_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_6_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_7_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_8_n_0 : STD_LOGIC;
  signal ck_io0_OBUF_inst_i_9_n_0 : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_CARRYCASCOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_MULTSIGNOUT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_OVERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_PATTERNBDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_PATTERNDETECT_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_UNDERFLOW_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_bl.DSP48E_2_ACOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 29 downto 0 );
  signal \NLW_bl.DSP48E_2_BCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 17 downto 0 );
  signal \NLW_bl.DSP48E_2_CARRYOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_bl.DSP48E_2_PCOUT_UNCONNECTED\ : STD_LOGIC_VECTOR ( 47 downto 0 );
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of \bl.DSP48E_2\ : label is "{SYNTH-13 {cell *THIS*}}";
  attribute box_type : string;
  attribute box_type of \bl.DSP48E_2\ : label is "PRIMITIVE";
begin
\bl.DSP48E_2\: unisim.vcomponents.DSP48E1
    generic map(
      ACASCREG => 1,
      ADREG => 0,
      ALUMODEREG => 1,
      AREG => 1,
      AUTORESET_PATDET => "NO_RESET",
      A_INPUT => "DIRECT",
      BCASCREG => 1,
      BREG => 1,
      B_INPUT => "DIRECT",
      CARRYINREG => 1,
      CARRYINSELREG => 1,
      CREG => 1,
      DREG => 0,
      INMODEREG => 1,
      IS_ALUMODE_INVERTED => B"0000",
      IS_CARRYIN_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_INMODE_INVERTED => B"00000",
      IS_OPMODE_INVERTED => B"0000000",
      MASK => X"3FFFFFFFFFFF",
      MREG => 0,
      OPMODEREG => 1,
      PATTERN => X"000000000000",
      PREG => 1,
      SEL_MASK => "MASK",
      SEL_PATTERN => "PATTERN",
      USE_DPORT => false,
      USE_MULT => "NONE",
      USE_PATTERN_DETECT => "NO_PATDET",
      USE_SIMD => "ONE48"
    )
        port map (
      A(29 downto 0) => B"000000000000000000000000000000",
      ACIN(29 downto 0) => B"000000000000000000000000000000",
      ACOUT(29 downto 0) => \NLW_bl.DSP48E_2_ACOUT_UNCONNECTED\(29 downto 0),
      ALUMODE(3 downto 0) => B"0000",
      B(17 downto 0) => B"000000000000000001",
      BCIN(17 downto 0) => B"000000000000000000",
      BCOUT(17 downto 0) => \NLW_bl.DSP48E_2_BCOUT_UNCONNECTED\(17 downto 0),
      C(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      CARRYCASCIN => '0',
      CARRYCASCOUT => \NLW_bl.DSP48E_2_CARRYCASCOUT_UNCONNECTED\,
      CARRYIN => '0',
      CARRYINSEL(2 downto 0) => B"000",
      CARRYOUT(3 downto 0) => \NLW_bl.DSP48E_2_CARRYOUT_UNCONNECTED\(3 downto 0),
      CEA1 => '0',
      CEA2 => '0',
      CEAD => '0',
      CEALUMODE => '0',
      CEB1 => '0',
      CEB2 => '0',
      CEC => '0',
      CECARRYIN => '0',
      CECTRL => '0',
      CED => '0',
      CEINMODE => '0',
      CEM => '0',
      CEP => '0',
      CLK => '0',
      D(24 downto 0) => B"0000000000000000000000000",
      INMODE(4 downto 0) => B"00000",
      MULTSIGNIN => '0',
      MULTSIGNOUT => \NLW_bl.DSP48E_2_MULTSIGNOUT_UNCONNECTED\,
      OPMODE(6) => '0',
      OPMODE(5) => \bl.DSP48E_2_i_1_n_0\,
      OPMODE(4 downto 2) => B"000",
      OPMODE(1) => \bl.DSP48E_2_i_1_n_0\,
      OPMODE(0) => \bl.DSP48E_2_i_1_n_0\,
      OVERFLOW => \NLW_bl.DSP48E_2_OVERFLOW_UNCONNECTED\,
      P(47 downto 0) => CNTR_OUT(47 downto 0),
      PATTERNBDETECT => \NLW_bl.DSP48E_2_PATTERNBDETECT_UNCONNECTED\,
      PATTERNDETECT => \NLW_bl.DSP48E_2_PATTERNDETECT_UNCONNECTED\,
      PCIN(47 downto 0) => B"000000000000000000000000000000000000000000000000",
      PCOUT(47 downto 0) => \NLW_bl.DSP48E_2_PCOUT_UNCONNECTED\(47 downto 0),
      RSTA => soRESET,
      RSTALLCARRYIN => soRESET,
      RSTALUMODE => soRESET,
      RSTB => soRESET,
      RSTC => soRESET,
      RSTCTRL => soRESET,
      RSTD => soRESET,
      RSTINMODE => soRESET,
      RSTM => soRESET,
      RSTP => soRESET,
      UNDERFLOW => \NLW_bl.DSP48E_2_UNDERFLOW_UNCONNECTED\
    );
\bl.DSP48E_2_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFD"
    )
        port map (
      I0 => ck_io0_OBUF_inst_i_4_n_0,
      I1 => ck_io0_OBUF_inst_i_5_n_0,
      I2 => ck_io0_OBUF_inst_i_6_n_0,
      I3 => ck_io0_OBUF_inst_i_7_n_0,
      I4 => \bl.DSP48E_2_i_2_n_0\,
      I5 => ck_io0_OBUF_inst_i_3_n_0,
      O => \bl.DSP48E_2_i_1_n_0\
    );
\bl.DSP48E_2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFEFFF"
    )
        port map (
      I0 => ck_io0_OBUF_inst_i_8_n_0,
      I1 => CNTR_OUT(1),
      I2 => CNTR_OUT(6),
      I3 => CNTR_OUT(0),
      I4 => soRESET,
      I5 => CNTR_OUT(7),
      O => \bl.DSP48E_2_i_2_n_0\
    );
ck_io0_OBUF_inst_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000010"
    )
        port map (
      I0 => ck_io0_OBUF_inst_i_2_n_0,
      I1 => ck_io0_OBUF_inst_i_3_n_0,
      I2 => ck_io0_OBUF_inst_i_4_n_0,
      I3 => ck_io0_OBUF_inst_i_5_n_0,
      I4 => ck_io0_OBUF_inst_i_6_n_0,
      I5 => ck_io0_OBUF_inst_i_7_n_0,
      O => ck_io0_OBUF
    );
ck_io0_OBUF_inst_i_10: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => CNTR_OUT(24),
      I1 => CNTR_OUT(20),
      I2 => CNTR_OUT(44),
      I3 => CNTR_OUT(32),
      O => ck_io0_OBUF_inst_i_10_n_0
    );
ck_io0_OBUF_inst_i_11: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => CNTR_OUT(29),
      I1 => CNTR_OUT(17),
      I2 => CNTR_OUT(41),
      I3 => CNTR_OUT(37),
      O => ck_io0_OBUF_inst_i_11_n_0
    );
ck_io0_OBUF_inst_i_12: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => CNTR_OUT(30),
      I1 => CNTR_OUT(18),
      I2 => CNTR_OUT(42),
      I3 => CNTR_OUT(38),
      O => ck_io0_OBUF_inst_i_12_n_0
    );
ck_io0_OBUF_inst_i_13: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => CNTR_OUT(27),
      I1 => CNTR_OUT(23),
      I2 => CNTR_OUT(46),
      I3 => CNTR_OUT(35),
      O => ck_io0_OBUF_inst_i_13_n_0
    );
ck_io0_OBUF_inst_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFBFF"
    )
        port map (
      I0 => ck_io0_OBUF_inst_i_8_n_0,
      I1 => CNTR_OUT(1),
      I2 => CNTR_OUT(0),
      I3 => CNTR_OUT(6),
      I4 => soRESET,
      I5 => CNTR_OUT(7),
      O => ck_io0_OBUF_inst_i_2_n_0
    );
ck_io0_OBUF_inst_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => CNTR_OUT(8),
      I1 => CNTR_OUT(10),
      I2 => CNTR_OUT(13),
      I3 => CNTR_OUT(15),
      I4 => ck_io0_OBUF_inst_i_9_n_0,
      O => ck_io0_OBUF_inst_i_3_n_0
    );
ck_io0_OBUF_inst_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => CNTR_OUT(36),
      I1 => CNTR_OUT(40),
      I2 => CNTR_OUT(16),
      I3 => CNTR_OUT(28),
      I4 => ck_io0_OBUF_inst_i_10_n_0,
      O => ck_io0_OBUF_inst_i_4_n_0
    );
ck_io0_OBUF_inst_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => CNTR_OUT(33),
      I1 => CNTR_OUT(45),
      I2 => CNTR_OUT(21),
      I3 => CNTR_OUT(25),
      I4 => ck_io0_OBUF_inst_i_11_n_0,
      O => ck_io0_OBUF_inst_i_5_n_0
    );
ck_io0_OBUF_inst_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => CNTR_OUT(34),
      I1 => CNTR_OUT(47),
      I2 => CNTR_OUT(22),
      I3 => CNTR_OUT(26),
      I4 => ck_io0_OBUF_inst_i_12_n_0,
      O => ck_io0_OBUF_inst_i_6_n_0
    );
ck_io0_OBUF_inst_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => CNTR_OUT(39),
      I1 => CNTR_OUT(43),
      I2 => CNTR_OUT(19),
      I3 => CNTR_OUT(31),
      I4 => ck_io0_OBUF_inst_i_13_n_0,
      O => ck_io0_OBUF_inst_i_7_n_0
    );
ck_io0_OBUF_inst_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => CNTR_OUT(2),
      I1 => CNTR_OUT(5),
      I2 => CNTR_OUT(9),
      I3 => CNTR_OUT(4),
      O => ck_io0_OBUF_inst_i_8_n_0
    );
ck_io0_OBUF_inst_i_9: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => CNTR_OUT(11),
      I1 => CNTR_OUT(3),
      I2 => CNTR_OUT(14),
      I3 => CNTR_OUT(12),
      O => ck_io0_OBUF_inst_i_9_n_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Counter is
  port (
    clk : in STD_LOGIC;
    ck_io0 : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of Counter : entity is true;
end Counter;

architecture STRUCTURE of Counter is
  signal ck_io0_OBUF : STD_LOGIC;
  signal soRESET : STD_LOGIC;
begin
cCOUNTER_TC: entity work.unimacro_COUNTER_TC_MACRO
     port map (
      ck_io0_OBUF => ck_io0_OBUF,
      soRESET => soRESET
    );
cRESET: entity work.Reset
     port map (
      soRESET => soRESET
    );
ck_io0_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => ck_io0_OBUF,
      O => ck_io0
    );
end STRUCTURE;
