----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2021 04:17:52 PM
-- Design Name: 
-- Module Name: clock_div - divider
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
use ieee.numeric_std.all;

entity clock_div is
  Port ( clk : in std_logic;
         div : out std_logic );
end clock_div;

architecture divider of clock_div is
    signal cnt : std_logic_vector( 3 downto 0 ) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (unsigned(cnt) < 4) then
                cnt <= std_logic_vector(unsigned(cnt) + 1);
                div <= '0';
            else
                div <= '1';
                cnt <= (others => '0');                
            end if;
        end if;
    end process;
end divider;