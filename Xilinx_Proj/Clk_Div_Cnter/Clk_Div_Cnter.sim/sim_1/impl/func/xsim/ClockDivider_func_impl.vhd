-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Sat Jan  9 13:41:41 2021
-- Host        : Gebruiker-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/X_projects/Cnt_own/Cnt_own.sim/sim_1/impl/func/xsim/ClockDivider_func_impl.vhd
-- Design      : ClockDivider
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z007sclg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity Counter is
  port (
    ck_io0_OBUF : out STD_LOGIC;
    soBUFG : in STD_LOGIC
  );
end Counter;

architecture STRUCTURE of Counter is
  signal \Counter.cnt[0]_i_3_n_0\ : STD_LOGIC;
  signal \Counter.cnt[0]_i_4_n_0\ : STD_LOGIC;
  signal \Counter.cnt[0]_i_5_n_0\ : STD_LOGIC;
  signal \Counter.cnt[0]_i_6_n_0\ : STD_LOGIC;
  signal \Counter.cnt[0]_i_7_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg\ : STD_LOGIC_VECTOR ( 27 downto 0 );
  signal \Counter.cnt_reg[0]_i_10_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_12_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_13_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_14_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_15_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_2_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_2_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_2_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_2_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[0]_i_9_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[12]_i_1_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[12]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[12]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[12]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[12]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[20]_i_1_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[20]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[20]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[20]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[20]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[4]_i_1_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[4]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[4]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[4]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[4]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.cnt_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \Counter.cnt_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \Counter.cnt_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \Counter.cnt_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \Counter.cnt_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal \Counter.o_i_1_n_0\ : STD_LOGIC;
  signal \^ck_io0_obuf\ : STD_LOGIC;
  signal clear : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 27 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_10_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_11_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_11_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_Counter.cnt_reg[0]_i_12_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_13_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_14_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_15_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[0]_i_9_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[16]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[20]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[24]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_Counter.cnt_reg[4]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \NLW_Counter.cnt_reg[8]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_10\ : label is 35;
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_10\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_11\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_11\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_12\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_12\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_13\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_13\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_14\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_14\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_15\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_15\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_2\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_2\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[0]_i_9\ : label is 35;
  attribute OPT_MODIFIED of \Counter.cnt_reg[0]_i_9\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[12]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[12]_i_1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[16]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[16]_i_1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[20]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[20]_i_1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[24]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[24]_i_1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[4]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[4]_i_1\ : label is "SWEEP";
  attribute ADDER_THRESHOLD of \Counter.cnt_reg[8]_i_1\ : label is 11;
  attribute OPT_MODIFIED of \Counter.cnt_reg[8]_i_1\ : label is "SWEEP";
begin
  ck_io0_OBUF <= \^ck_io0_obuf\;
\Counter.cnt[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \Counter.cnt[0]_i_3_n_0\,
      I1 => \Counter.cnt[0]_i_4_n_0\,
      I2 => \Counter.cnt[0]_i_5_n_0\,
      I3 => \Counter.cnt[0]_i_6_n_0\,
      I4 => \Counter.cnt[0]_i_7_n_0\,
      O => clear
    );
\Counter.cnt[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => p_0_in(19),
      I1 => p_0_in(20),
      I2 => p_0_in(17),
      I3 => p_0_in(18),
      I4 => p_0_in(22),
      I5 => p_0_in(21),
      O => \Counter.cnt[0]_i_3_n_0\
    );
\Counter.cnt[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0001000000000000"
    )
        port map (
      I0 => p_0_in(25),
      I1 => p_0_in(26),
      I2 => p_0_in(23),
      I3 => p_0_in(24),
      I4 => \Counter.cnt_reg\(0),
      I5 => p_0_in(27),
      O => \Counter.cnt[0]_i_4_n_0\
    );
\Counter.cnt[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => p_0_in(13),
      I1 => p_0_in(14),
      I2 => p_0_in(11),
      I3 => p_0_in(12),
      I4 => p_0_in(16),
      I5 => p_0_in(15),
      O => \Counter.cnt[0]_i_5_n_0\
    );
\Counter.cnt[0]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => p_0_in(2),
      I1 => p_0_in(1),
      I2 => p_0_in(4),
      I3 => p_0_in(3),
      O => \Counter.cnt[0]_i_6_n_0\
    );
\Counter.cnt[0]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => p_0_in(7),
      I1 => p_0_in(8),
      I2 => p_0_in(5),
      I3 => p_0_in(6),
      I4 => p_0_in(10),
      I5 => p_0_in(9),
      O => \Counter.cnt[0]_i_7_n_0\
    );
\Counter.cnt[0]_i_8\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \Counter.cnt_reg\(0),
      O => p_0_in(0)
    );
\Counter.cnt_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[0]_i_2_n_7\,
      Q => \Counter.cnt_reg\(0),
      R => clear
    );
\Counter.cnt_reg[0]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_9_n_0\,
      CO(3) => \Counter.cnt_reg[0]_i_10_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_10_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(24 downto 21),
      S(3 downto 0) => \Counter.cnt_reg\(24 downto 21)
    );
\Counter.cnt_reg[0]_i_11\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_10_n_0\,
      CO(3 downto 0) => \NLW_Counter.cnt_reg[0]_i_11_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_Counter.cnt_reg[0]_i_11_O_UNCONNECTED\(3),
      O(2 downto 0) => p_0_in(27 downto 25),
      S(3) => '0',
      S(2 downto 0) => \Counter.cnt_reg\(27 downto 25)
    );
\Counter.cnt_reg[0]_i_12\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_13_n_0\,
      CO(3) => \Counter.cnt_reg[0]_i_12_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_12_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(16 downto 13),
      S(3 downto 0) => \Counter.cnt_reg\(16 downto 13)
    );
\Counter.cnt_reg[0]_i_13\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_15_n_0\,
      CO(3) => \Counter.cnt_reg[0]_i_13_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_13_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(12 downto 9),
      S(3 downto 0) => \Counter.cnt_reg\(12 downto 9)
    );
\Counter.cnt_reg[0]_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Counter.cnt_reg[0]_i_14_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_14_CO_UNCONNECTED\(2 downto 0),
      CYINIT => \Counter.cnt_reg\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(4 downto 1),
      S(3 downto 0) => \Counter.cnt_reg\(4 downto 1)
    );
\Counter.cnt_reg[0]_i_15\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_14_n_0\,
      CO(3) => \Counter.cnt_reg[0]_i_15_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_15_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(8 downto 5),
      S(3 downto 0) => \Counter.cnt_reg\(8 downto 5)
    );
\Counter.cnt_reg[0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \Counter.cnt_reg[0]_i_2_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_2_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \Counter.cnt_reg[0]_i_2_n_4\,
      O(2) => \Counter.cnt_reg[0]_i_2_n_5\,
      O(1) => \Counter.cnt_reg[0]_i_2_n_6\,
      O(0) => \Counter.cnt_reg[0]_i_2_n_7\,
      S(3 downto 1) => \Counter.cnt_reg\(3 downto 1),
      S(0) => p_0_in(0)
    );
\Counter.cnt_reg[0]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_12_n_0\,
      CO(3) => \Counter.cnt_reg[0]_i_9_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[0]_i_9_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => p_0_in(20 downto 17),
      S(3 downto 0) => \Counter.cnt_reg\(20 downto 17)
    );
\Counter.cnt_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[8]_i_1_n_5\,
      Q => \Counter.cnt_reg\(10),
      R => clear
    );
\Counter.cnt_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[8]_i_1_n_4\,
      Q => \Counter.cnt_reg\(11),
      R => clear
    );
\Counter.cnt_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[12]_i_1_n_7\,
      Q => \Counter.cnt_reg\(12),
      R => clear
    );
\Counter.cnt_reg[12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[8]_i_1_n_0\,
      CO(3) => \Counter.cnt_reg[12]_i_1_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[12]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[12]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[12]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[12]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[12]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(15 downto 12)
    );
\Counter.cnt_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[12]_i_1_n_6\,
      Q => \Counter.cnt_reg\(13),
      R => clear
    );
\Counter.cnt_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[12]_i_1_n_5\,
      Q => \Counter.cnt_reg\(14),
      R => clear
    );
\Counter.cnt_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[12]_i_1_n_4\,
      Q => \Counter.cnt_reg\(15),
      R => clear
    );
\Counter.cnt_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[16]_i_1_n_7\,
      Q => \Counter.cnt_reg\(16),
      R => clear
    );
\Counter.cnt_reg[16]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[12]_i_1_n_0\,
      CO(3) => \Counter.cnt_reg[16]_i_1_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[16]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[16]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[16]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[16]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[16]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(19 downto 16)
    );
\Counter.cnt_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[16]_i_1_n_6\,
      Q => \Counter.cnt_reg\(17),
      R => clear
    );
\Counter.cnt_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[16]_i_1_n_5\,
      Q => \Counter.cnt_reg\(18),
      R => clear
    );
\Counter.cnt_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[16]_i_1_n_4\,
      Q => \Counter.cnt_reg\(19),
      R => clear
    );
\Counter.cnt_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[0]_i_2_n_6\,
      Q => \Counter.cnt_reg\(1),
      R => clear
    );
\Counter.cnt_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[20]_i_1_n_7\,
      Q => \Counter.cnt_reg\(20),
      R => clear
    );
\Counter.cnt_reg[20]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[16]_i_1_n_0\,
      CO(3) => \Counter.cnt_reg[20]_i_1_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[20]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[20]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[20]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[20]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[20]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(23 downto 20)
    );
\Counter.cnt_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[20]_i_1_n_6\,
      Q => \Counter.cnt_reg\(21),
      R => clear
    );
\Counter.cnt_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[20]_i_1_n_5\,
      Q => \Counter.cnt_reg\(22),
      R => clear
    );
\Counter.cnt_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[20]_i_1_n_4\,
      Q => \Counter.cnt_reg\(23),
      R => clear
    );
\Counter.cnt_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[24]_i_1_n_7\,
      Q => \Counter.cnt_reg\(24),
      R => clear
    );
\Counter.cnt_reg[24]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[20]_i_1_n_0\,
      CO(3 downto 0) => \NLW_Counter.cnt_reg[24]_i_1_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[24]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[24]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[24]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[24]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(27 downto 24)
    );
\Counter.cnt_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[24]_i_1_n_6\,
      Q => \Counter.cnt_reg\(25),
      R => clear
    );
\Counter.cnt_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[24]_i_1_n_5\,
      Q => \Counter.cnt_reg\(26),
      R => clear
    );
\Counter.cnt_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[24]_i_1_n_4\,
      Q => \Counter.cnt_reg\(27),
      R => clear
    );
\Counter.cnt_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[0]_i_2_n_5\,
      Q => \Counter.cnt_reg\(2),
      R => clear
    );
\Counter.cnt_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[0]_i_2_n_4\,
      Q => \Counter.cnt_reg\(3),
      R => clear
    );
\Counter.cnt_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[4]_i_1_n_7\,
      Q => \Counter.cnt_reg\(4),
      R => clear
    );
\Counter.cnt_reg[4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[0]_i_2_n_0\,
      CO(3) => \Counter.cnt_reg[4]_i_1_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[4]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[4]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[4]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[4]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[4]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(7 downto 4)
    );
\Counter.cnt_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[4]_i_1_n_6\,
      Q => \Counter.cnt_reg\(5),
      R => clear
    );
\Counter.cnt_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[4]_i_1_n_5\,
      Q => \Counter.cnt_reg\(6),
      R => clear
    );
\Counter.cnt_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[4]_i_1_n_4\,
      Q => \Counter.cnt_reg\(7),
      R => clear
    );
\Counter.cnt_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[8]_i_1_n_7\,
      Q => \Counter.cnt_reg\(8),
      R => clear
    );
\Counter.cnt_reg[8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \Counter.cnt_reg[4]_i_1_n_0\,
      CO(3) => \Counter.cnt_reg[8]_i_1_n_0\,
      CO(2 downto 0) => \NLW_Counter.cnt_reg[8]_i_1_CO_UNCONNECTED\(2 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \Counter.cnt_reg[8]_i_1_n_4\,
      O(2) => \Counter.cnt_reg[8]_i_1_n_5\,
      O(1) => \Counter.cnt_reg[8]_i_1_n_6\,
      O(0) => \Counter.cnt_reg[8]_i_1_n_7\,
      S(3 downto 0) => \Counter.cnt_reg\(11 downto 8)
    );
\Counter.cnt_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.cnt_reg[8]_i_1_n_6\,
      Q => \Counter.cnt_reg\(9),
      R => clear
    );
\Counter.o_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7FFFFFFF80000000"
    )
        port map (
      I0 => \Counter.cnt[0]_i_7_n_0\,
      I1 => \Counter.cnt[0]_i_6_n_0\,
      I2 => \Counter.cnt[0]_i_5_n_0\,
      I3 => \Counter.cnt[0]_i_4_n_0\,
      I4 => \Counter.cnt[0]_i_3_n_0\,
      I5 => \^ck_io0_obuf\,
      O => \Counter.o_i_1_n_0\
    );
\Counter.o_reg\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => soBUFG,
      CE => '1',
      D => \Counter.o_i_1_n_0\,
      Q => \^ck_io0_obuf\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity ClockDivider is
  port (
    clk : in STD_LOGIC;
    ck_io0 : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of ClockDivider : entity is true;
  attribute ECO_CHECKSUM : string;
  attribute ECO_CHECKSUM of ClockDivider : entity is "3e1fd7df";
end ClockDivider;

architecture STRUCTURE of ClockDivider is
  signal ck_io0_OBUF : STD_LOGIC;
  signal soBUFG : STD_LOGIC;
  signal soIBUF : STD_LOGIC;
  attribute box_type : string;
  attribute box_type of cBUFG : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of cIBUF : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of cIBUF : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of cIBUF : label is "AUTO";
  attribute box_type of cIBUF : label is "PRIMITIVE";
begin
cBUFG: unisim.vcomponents.BUFG
     port map (
      I => soIBUF,
      O => soBUFG
    );
cCounter: entity work.Counter
     port map (
      ck_io0_OBUF => ck_io0_OBUF,
      soBUFG => soBUFG
    );
cIBUF: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk,
      O => soIBUF
    );
ck_io0_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => ck_io0_OBUF,
      O => ck_io0
    );
end STRUCTURE;
