----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/06/2018 02:17:52 PM
-- Design Name: 
-- Module Name: one_shot_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: debounced one-shot trigger button
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity one_shot_gen is
    port(   clk     :   in std_logic;
            trigger :   in std_logic;
            pulse   :   out std_logic);
end one_shot_gen;

architecture Behavioral of one_shot_gen is
    -- debounced button control signal
    signal debounce_cnt     :   std_logic_vector(19 downto 0) := X"F4240"; -- 10ms
    signal debounced_trig    :   std_logic := '0';
    
    -- one-shot duration timer
    signal duration         :   std_logic_vector(23 downto 0) := X"000000";
    signal oneshot          :   std_logic := '0';
    
    signal mySignal_d : std_logic := '0'; 
    signal mySignal_re : std_logic;
    
begin

    --------------------------------
    -- button debounce
    --------------------------------
    process(clk, trigger) begin
        if rising_edge(clk) then
            if (trigger = '1') then 
                if (debounce_cnt > 0) then
                    debounced_trig <= '0';
                    debounce_cnt <= debounce_cnt - 1;
                else 
                    debounced_trig <= '1';
                    debounce_cnt <= X"00000";
                end if;
            else
                debounced_trig <= '0';
                debounce_cnt <= X"F4240";
            end if;
        end if;
    end process;
    
    ------------------------------------
    -- one-shot timer
    ------------------------------------
    process(clk, debounced_trig, mySignal_re) begin
        if rising_edge(clk) then
            if (mySignal_re = '1') then
                duration <= X"000000";
            elsif (debounced_trig = '1') then
                if (duration < X"989680") then -- 100ms duration
                    oneshot <= '1';
                    duration <= duration + 1;
                else
                    oneshot <= '0';
                end if;
            else
                oneshot <= '0';
            end if;
        end if;
    end process;
    
    -- mySignal_re: rising edge of debounced_trig
    mySignal_d <= debounced_trig when rising_edge(clk); 
    mySignal_re <= not mySignal_d and debounced_trig;   
    
    pulse <= oneshot;
    
end Behavioral;
