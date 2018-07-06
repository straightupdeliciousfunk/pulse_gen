----------------------------------------------------------------------------------
-- Company: N/A
-- Engineer: Tim
-- 
-- Create Date: 06/29/2018 08:21:07 PM
-- Design Name: 
-- Module Name: pulse_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: generic clock divider. need to add several  
--              other divided clocks for multiple output pulse
--              frequencies. also need to add adjustable freq
--              clk divider for the led onboard the Arty dev
--              board.
-- Dependencies: N/A
-- 
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_gen_controller is
    Port (  
            CLK         :   in std_logic;
            trig        :   in std_logic;
            hz_led      :   out std_logic;
            blink_led   :   out std_logic);
end pulse_gen_controller;

architecture Behavioral of pulse_gen_controller is

    component pulse_gen is
        port(
             clk        : in std_logic;
             out_1_hz   : out std_logic);  -- 1 Hz pulse output
    end component;
    
    component one_shot_gen is
        port(
            clk :   in  std_logic;
            trigger :   in std_logic;
            pulse   :   out std_logic);
    end component;
    
begin

    num_0 : pulse_gen port map( 
        clk => CLK,
        out_1_hz => hz_led);
             
    pgen1 : one_shot_gen port map(
        clk => CLK,
        trigger => trig,
        pulse   => blink_led);         
                  
end Behavioral;
