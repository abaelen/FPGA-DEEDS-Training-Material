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

ENTITY Fsm2_Lesson_26_Pulse_Measure_FSM_B IS
  PORT( ----------------------------------->Clock & Reset:
        Ck:    IN std_logic;
        Reset: IN std_logic;
        ----------------------------------->Inputs:
        i_TRG: IN std_logic;
        i_C0:  IN std_logic;
        i_C1:  IN std_logic;
        i_C2:  IN std_logic;
        ----------------------------------->Outputs:
        o_SER: OUT std_logic;
        o_ETX: OUT std_logic
        -------------------------------------------
        );
END Fsm2_Lesson_26_Pulse_Measure_FSM_B;

ARCHITECTURE behavioral OF Fsm2_Lesson_26_Pulse_Measure_FSM_B IS       -- (Behavioral Description)
  TYPE states is ( state_a,
                   state_b,
                   state_a0,
                   state_a1,
                   state_b0,
                   state_b1,
                   state_c0,
                   state_c1,
                   state_e,
                   dummy_1001,
                   dummy_1010,
                   dummy_1011,
                   dummy_1100,
                   dummy_1101,
                   dummy_1110,
                   dummy_1111 );
  SIGNAL State,
         Next_State: states;
BEGIN

  -- Next State Combinational Logic ----------------------------------
  FSM: process( State, i_TRG, i_C0, i_C1, i_C2 )
  begin
    CASE State IS
      when state_a =>
                 if (i_TRG = '1') then
                   Next_State <= state_b;
                 else
                   Next_State <= state_a;
                 end if;
      when state_b =>
                 if (i_C0 = '1') then
                   Next_State <= state_a1;
                 else
                   Next_State <= state_a0;
                 end if;
      when state_a0 =>
                 if (i_C1 = '1') then
                   Next_State <= state_b1;
                 else
                   Next_State <= state_b0;
                 end if;
      when state_a1 =>
                 if (i_C1 = '1') then
                   Next_State <= state_b1;
                 else
                   Next_State <= state_b0;
                 end if;
      when state_b0 =>
                 if (i_C2 = '1') then
                   Next_State <= state_c1;
                 else
                   Next_State <= state_c0;
                 end if;
      when state_b1 =>
                 if (i_C2 = '1') then
                   Next_State <= state_c1;
                 else
                   Next_State <= state_c0;
                 end if;
      when state_c0 =>
                 Next_State <= state_e;
      when state_c1 =>
                 Next_State <= state_e;
      when state_e =>
                 Next_State <= state_a;
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
  OUTPUTS: process( State, i_TRG, i_C0, i_C1, i_C2 )
  begin
    -- Set output defaults:
    o_SER <= '0';
    o_ETX <= '0';

    -- Set output as function of current state and input:
    CASE State IS
      when state_b =>
                 o_SER <= '1';
      when state_a1 =>
                 o_SER <= '1';
      when state_b1 =>
                 o_SER <= '1';
      when state_c1 =>
                 o_SER <= '1';
      when state_e =>
                 o_ETX <= '1';
      when OTHERS =>
                 o_SER <= '0';
                 o_ETX <= '0';
    END case;
  end process;

END behavioral;
