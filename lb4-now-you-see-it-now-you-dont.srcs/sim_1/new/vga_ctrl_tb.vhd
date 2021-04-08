----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2021 08:55:12 PM
-- Design Name: 
-- Module Name: vga_ctrl_tb - tb
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

entity vga_ctrl_tb is
end vga_ctrl_tb;

architecture tb of vga_ctrl_tb is
    component vga_ctrl is
        Port ( clk : in STD_LOGIC;
               en : in STD_LOGIC;
               hcount : out STD_LOGIC_VECTOR (9 downto 0);
               vcount : out STD_LOGIC_VECTOR (9 downto 0);
               vid : out STD_LOGIC;
               hs : out STD_LOGIC;
               vs : out STD_LOGIC);
    end component;
    
    signal clk, en : std_logic := '0';
    signal vid, hs, vs : std_logic;
    signal hcount, vcount : std_logic_vector (9 downto 0);
begin
    gen_clk : process
    begin
        wait for 4ns;
        clk <= not clk;
    end process gen_clk;

    gen_en : process
    begin
        wait for 40ns;
        en <= not en;
    end process gen_en;

    dut : vga_ctrl
    port map(
        clk => clk,
        en => en,
        hcount => hcount,
        vcount => vcount,
        vid => vid,
        hs => hs,
        vs => vs
    );
end tb;
