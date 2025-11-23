library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(clk,btn,btn1,btn2,btn3 : in std_logic;
	seg11,seg12,seg13,seg14,seg15,seg16,seg17,
	seg21,seg22,seg23,seg24,seg25,seg26,seg27,
	seg31,seg32,seg33,seg34,seg35,seg36,seg37,
	seg41,seg42,seg43,seg44,seg45,seg46,seg47 : out std_logic; y1,y2,y3 : out std_logic);
end clock;

architecture arch of clock is
	signal prescaler_out : std_logic_vector(6 downto 0) := "0000000";
	signal clk_in : std_logic := '0';
	signal clk_in_cond : std_logic := '0';
	signal clk_5_out : std_logic_vector(3 downto 0) := "0000";
	signal clk_5_det_max : std_logic := '0';
	signal counter_out : std_logic_vector(3 downto 0) := "0000";
	signal counter_det_max : std_logic := '0';
	signal seg_enc1_out : std_logic_vector(6 downto 0) := "0000000";
	signal seg_enc2_out : std_logic_vector(6 downto 0) := "0000000";
	signal seg_enc3_out : std_logic_vector(6 downto 0) := "0000000";
	signal seg_enc4_out : std_logic_vector(6 downto 0) := "0000000";
	signal btn_din : std_logic_vector(2 downto 0) := "000";
	signal mode_dout : std_logic_vector(2 downto 0) := "000";
begin
	prescaler : entity work.prescaler port map(clk => clk, y => prescaler_out);
	clk_in <= prescaler_out(0) when btn = '1' else prescaler_out(2);
	clk_in_cond <= clk_in when mode_dout(2) = '1' else prescaler_out(1);
	counter_5 : entity work.counter port map(clk => clk, en => clk_in_cond, rst => clk_5_det_max, dout => clk_5_out);
	clk_5_det_max <= clk_5_out(2) and clk_5_out(1);
	segments : entity work.segments port map(clk => clk, en => clk_5_det_max, modes => mode_dout, seg1 => seg_enc1_out, seg2 => seg_enc2_out, seg3 => seg_enc3_out, seg4 => seg_enc4_out);
	btn_din(2) <= not btn1;
	btn_din(1) <= not btn2;
	btn_din(0) <= not btn3;
	mode : entity work.mode port map(clk => clk, btn1 => btn_din(2), btn2 => btn_din(1), btn3 => btn_din(0), y3 => mode_dout(2), y2 => mode_dout(1), y1 => mode_dout(0));
	seg11 <= seg_enc1_out(6);
	seg12 <= seg_enc1_out(5);
	seg13 <= seg_enc1_out(4);
	seg14 <= seg_enc1_out(3);
	seg15 <= seg_enc1_out(2);
	seg16 <= seg_enc1_out(1);
	seg17 <= seg_enc1_out(0);
	seg21 <= seg_enc2_out(6);
	seg22 <= seg_enc2_out(5);
	seg23 <= seg_enc2_out(4);
	seg24 <= seg_enc2_out(3);
	seg25 <= seg_enc2_out(2);
	seg26 <= seg_enc2_out(1);
	seg27 <= seg_enc2_out(0);
	seg31 <= seg_enc3_out(6);
	seg32 <= seg_enc3_out(5);
	seg33 <= seg_enc3_out(4);
	seg34 <= seg_enc3_out(3);
	seg35 <= seg_enc3_out(2);
	seg36 <= seg_enc3_out(1);
	seg37 <= seg_enc3_out(0);
	seg41 <= seg_enc4_out(6);
	seg42 <= seg_enc4_out(5);
	seg43 <= seg_enc4_out(4);
	seg44 <= seg_enc4_out(3);
	seg45 <= seg_enc4_out(2);
	seg46 <= seg_enc4_out(1);
	seg47 <= seg_enc4_out(0);
end arch;
