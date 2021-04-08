----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/23/2021 09:11:23 PM
-- Design Name: 
-- Module Name: image_top - rtl_structural
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

entity image_top is
    Port ( clk : in STD_LOGIC;
--           vga_hs : out STD_LOGIC;
--           vga_vs : out STD_LOGIC;
--           vga_r : out STD_LOGIC_VECTOR (3 downto 0);
--           vga_b : out STD_LOGIC_VECTOR (3 downto 0);
--           vga_g : out STD_LOGIC_VECTOR (3 downto 0));
           hdmi_tx_clk_p : out STD_LOGIC;
           hdmi_tx_clk_n : out STD_LOGIC;
           hdmi_tx_p : out STD_LOGIC_VECTOR (2 downto 0);
           hdmi_tx_n : out STD_LOGIC_VECTOR (2 downto 0));
--           hdmi_out_en : out STD_LOGIC);
end image_top;

architecture rtl_structural of image_top is
    component clock_div is
        Port ( clk : in std_logic;
               div : out std_logic );
    end component;
    component picture
        Port ( clka : in STD_LOGIC;
               addra : in STD_LOGIC_VECTOR(17 downto 0);
               douta : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    component vga_ctrl is
        Port ( clk : in STD_LOGIC;
               en : in STD_LOGIC;
               hcount : out STD_LOGIC_VECTOR (9 downto 0);
               vcount : out STD_LOGIC_VECTOR (9 downto 0);
               vid : out STD_LOGIC;
               hs : out STD_LOGIC;
               vs : out STD_LOGIC);
    end component;
    component pixel_pusher is
        Port ( clk : in STD_LOGIC;
               en : in STD_LOGIC;
               vs : in STD_LOGIC;
               pixel : in STD_LOGIC_VECTOR (7 downto 0);
               hcount : in STD_LOGIC_VECTOR (9 downto 0);
               vid : in STD_LOGIC;
               r : out STD_LOGIC_VECTOR (2 downto 0);
               b : out STD_LOGIC_VECTOR (1 downto 0);
               g : out STD_LOGIC_VECTOR (2 downto 0);
               addr : out STD_LOGIC_VECTOR (17 downto 0));
    end component;
    component rgb2dvi_0 is
        Port ( aRst : in STD_LOGIC;
               PixelClk : in STD_LOGIC;
               SerialClk : in STD_LOGIC;
               vid_pData : in STD_LOGIC_VECTOR(23 downto 0);
               vid_pHSync : in STD_LOGIC;
               vid_pVSync : in STD_LOGIC;
               vid_pVDE : in STD_LOGIC;
               TMDS_Clk_p : out STD_LOGIC;
               TMDS_Clk_n : out STD_LOGIC;
               TMDS_Data_p : out STD_LOGIC_VECTOR(2 downto 0);
               TMDS_Data_n : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    signal en, vs, hs, vid : std_logic;
    signal r, g : std_logic_vector(2 downto 0);
    signal b : std_logic_vector(1 downto 0);
    signal r8, g8, b8 : unsigned(7 downto 0);
    signal rgb : std_logic_vector(23 downto 0);
    signal pixel : std_logic_vector(7 downto 0);
    signal hcount : std_logic_vector(9 downto 0);
    signal addr : std_logic_vector(17 downto 0);
begin
--    vga_vs <= vs;
--    vga_hs <= hs;
--    vga_r <= r;
--    vga_g <= g;
--    vga_b <= b;
    r8 <= to_unsigned(to_integer(unsigned(r)) * 255 / 7, r8'length);
    g8 <= to_unsigned(to_integer(unsigned(g)) * 255 / 7, g8'length);
    b8 <= to_unsigned(to_integer(unsigned(b)) * 255 / 3, b8'length);
    rgb <= std_logic_vector(r8) & std_logic_vector(g8) & std_logic_vector(b8);
--    hdmi_out_en <= '1';

    cd : clock_div
    port map(
        clk => clk,
        div => en
    );
    
    pic : picture
    port map(
        clka => clk,
        addra => addr,
        douta => pixel
    );
    
    pp : pixel_pusher
    port map(
        clk => clk,
        en => en,
        vs => vs,
        pixel => pixel,
        hcount => hcount,
        vid => vid,
        r => r,
        g => g,
        b => b,
        addr => addr
    );
    
    vc : vga_ctrl
    port map(
        clk => clk,
        en => en,
        hcount => hcount,
        vid => vid,
        hs => hs,
        vs => vs
    );
    
    vga2hdmi : rgb2dvi_0
    port map(
        aRst => '0',
        PixelClk => en,
        SerialClk => clk,
        vid_pData => rgb,
        vid_pHSync => hs,
        vid_pVSync => vs,
        vid_pVDE => vid,
        TMDS_Clk_p => hdmi_tx_clk_p,
        TMDS_Clk_n => hdmi_tx_clk_n,
        TMDS_Data_p => hdmi_tx_p,
        TMDS_Data_n => hdmi_tx_n
   );
end rtl_structural;
