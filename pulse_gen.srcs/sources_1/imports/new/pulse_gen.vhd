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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_gen is
    port(
        clk         :   in  std_logic; -- clock input
        out_1_hz    :   out std_logic  -- 1 Hz pulse output
    );    
end pulse_gen;

architecture Behavioral of pulse_gen is 
    --1 hz clock divider
    signal clkCount_hz : STD_LOGIC_VECTOR(27 downto 0) := X"0000000";
    constant cntEndVal_hz : STD_LOGIC_VECTOR(27 downto 0) := X"5F5E100"; -- 1 second
    signal hz_clk : std_logic := '0';

begin 
    --------------------------------
    --            1hz Clock Divider
    --  Timing for refreshing the
    --               SSD, etc.
    --------------------------------
    one_hertz: process(clk) begin
            if rising_edge(clk) then
                    if(clkCount_hz = cntEndVal_hz) then
                            hz_clk <= not hz_clk;
                            clkCount_hz <= X"0000000";
                    else
                            clkCount_hz <= clkCount_hz + 1;
                    end if;
            end if;                    
    end process;

    -- 1Hz led
    out_1_Hz <= hz_clk;
     
end Behavioral;