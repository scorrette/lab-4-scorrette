----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 07:28:57 PM
-- Design Name: 
-- Module Name: image_top_tb - tb
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top_tb is
--  Port ( );
end image_top_tb;

architecture tb of image_top_tb is
    component image_top is
        Port ( clk : in STD_LOGIC;
--             vga_hs : out STD_LOGIC;
--             vga_vs : out STD_LOGIC;
--             vga_r : out STD_LOGIC_VECTOR (4 downto 0);
--             vga_b : out STD_LOGIC_VECTOR (4 downto 0);
--             vga_g : out STD_LOGIC_VECTOR (5 downto 0);
               hdmi_tx_clk_p : out STD_LOGIC;
               hdmi_tx_clk_n : out STD_LOGIC;
               hdmi_tx_p : out STD_LOGIC_VECTOR (2 downto 0);
               hdmi_tx_n : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
    
    signal clk : STD_LOGIC := '0';
    signal hdmi_tx_clk_p, hdmi_tx_clk_n : STD_LOGIC;
    signal hdmi_tx_p, hdmi_tx_n : STD_LOGIC_VECTOR(2 downto 0);
begin
    process
    begin
        wait for 40ns;
        clk <= not clk;
    end process;

    dut : image_top
    port map(
        clk => clk,
        hdmi_tx_clk_p => hdmi_tx_clk_p,
        hdmi_tx_clk_n => hdmi_tx_clk_n,
        hdmi_tx_p => hdmi_tx_p,
        hdmi_tx_n => hdmi_tx_n
    );
end tb;
