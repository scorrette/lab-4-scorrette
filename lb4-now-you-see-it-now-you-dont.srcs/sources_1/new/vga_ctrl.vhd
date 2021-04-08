----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2021 08:08:42 PM
-- Design Name: 
-- Module Name: vga_ctrl - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vga_ctrl is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           hcount : out STD_LOGIC_VECTOR (9 downto 0);
           vcount : out STD_LOGIC_VECTOR (9 downto 0);
           vid : out STD_LOGIC;
           hs : out STD_LOGIC;
           vs : out STD_LOGIC);
end vga_ctrl;

architecture Behavioral of vga_ctrl is
    signal hcounter, vcounter : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');
begin
    hcount <= hcounter;
    vcount <= vcounter;

    process(clk)
    begin
        if rising_edge(clk)
        then
            if en = '1'
            then
                if unsigned(hcounter) < 799 then
                    hcounter <= std_logic_vector(unsigned(hcounter) + 1);
                else
                    hcounter <= (others => '0');
                    
                    if unsigned(vcounter) < 524 then
                        vcounter <= std_logic_vector(unsigned(vcounter) + 1);
                    else
                        vcounter <= (others => '0');
                    end if;
                end if;
            end if;
        end if;
    end process;
    
    process(hcounter, vcounter)
    begin
        if unsigned(hcounter) < 640 and unsigned(vcounter) < 480 then
            vid <= '1';
        else
            vid <= '0';
        end if;
    end process;
    
    process(hcounter)
    begin
        if unsigned(hcounter) >= 656 and unsigned(hcounter) <= 751 then
            hs <= '0';
        else
            hs <= '1';
        end if;
    end process;
    
    process(vcounter)
    begin
        if unsigned(vcounter) >= 490 and unsigned(vcounter) <= 491 then
            vs <= '0';
        else
            vs <= '1';
        end if;
    end process;
end Behavioral;
