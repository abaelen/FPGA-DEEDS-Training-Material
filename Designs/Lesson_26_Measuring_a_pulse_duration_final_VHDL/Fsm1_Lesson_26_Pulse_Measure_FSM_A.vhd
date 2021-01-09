---------------------------------------------------------------------------------------------------
-- Deeds (Digital Electronics Education and Design Suite)
-- VHDL Code generated on (29/12/2020, 12:44:04)
--      by the Deeds (Finite State Machine Simulator)(Deeds-FsM)
--      Ver. 2.30.041 (March 3, 2020)
-- Copyright (c) 2002-2020 University of Genoa, Italy
--      Web Site:  https://www.digitalelectronicsdeeds.com
---------------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Fsm1_Lesson_26_Pulse_Measure_FSM_A IS
  PORT( ----------------------------------->Clock & Reset:
        Ck:    IN std_logic;
        Reset: IN std_logic;
        ----------------------------------->Inputs:
        i_EN:  IN std_logic;
        i_ETX: IN std_logic;
        ----------------------------------->Outputs:
        o_TRG: OUT std_logic;
        o_CL:  OUT std_logic;
        o_BSY: OUT std_logic
        -------------------------------------------
        );
END Fsm1_Lesson_26_Pulse_Measure_FSM_A;

ARCHITECTURE behavioral OF Fsm1_Lesson_26_Pulse_Measure_FSM_A IS       -- (Behavioral Description)
  TYPE states is ( state_c,
                   state_b,
                   state_t,
                   state_w,
                   state_a,
                   dummy_101,
                   dummy_110,
                   dummy_111 );
  SIGNAL State,
         Next_State: states;
BEGIN

  -- Next State Combinational Logic ----------------------------------
  FSM: process( State, i_EN, i_ETX )
  begin
    CASE State IS
      when state_c =>
                 if (i_EN = '1') then
                   Next_State <= state_b;
                 else
                   Next_State <= state_c;
                 end if;
      when state_a =>
                 Next_State <= state_c;
      when state_b =>
                 if (i_EN = '1') then
                   Next_State <= state_b;
                 else
                   Next_State <= state_t;
                 end if;
      when state_t =>
                 Next_State <= state_w;
      when state_w =>
                 if (i_ETX = '1') then
                   Next_State <= state_a;
                 else
                   Next_State <= state_w;
                 end if;
      when OTHERS =>
                 Next_State <= state_a;
    END case;
  end process;

  -- State Register --------------------------------------------------
  REG: process( Ck, Reset )
  begin
    if (Reset = '0') then
              State <= state_a;
    elsif rising_edge(Ck) then
              State <= Next_State;
       end if;
  end process;

  -- Outputs Combinational Logic -----------------------------------
  OUTPUTS: process( State, i_EN, i_ETX )
  begin
    -- Set output defaults:
    o_TRG <= '0';
    o_CL <= '0';
    o_BSY <= '0';

    -- Set output as function of current state and input:
    CASE State IS
      when state_a =>
                 o_CL <= '1';
      when state_b =>
                 o_BSY <= '1';
      when state_t =>
                 o_TRG <= '1';
                 o_BSY <= '1';
      when state_w =>
                 o_BSY <= '1';
      when OTHERS =>
                 o_TRG <= '0';
                 o_CL <= '0';
                 o_BSY <= '0';
    END case;
  end process;

END behavioral;
