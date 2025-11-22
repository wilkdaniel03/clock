library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(clk : in std_logic; seg11,seg12,seg13,seg14,seg15,seg16,seg17 : out std_logic; y : out std_logic);
end clock;

architecture arch of clock is
	signal prescaler_out : std_logic_vector(6 downto 0) := "0000000";
	signal clk_1hz_out : std_logic_vector(3 downto 0) := "0000";
	signal clk_1hz_det_max : std_logic := '0';
	signal counter_out : std_logic_vector(3 downto 0) := "0000";
	signal counter_det_max : std_logic := '0';
	signal seg_enc_out : std_logic_vector(6 downto 0) := "0000000";
begin
	prescaler : entity work.prescaler port map(clk => clk, y => prescaler_out);
	counter_1hz : entity work.counter port map(clk => clk, en => prescaler_out(0), rst => clk_1hz_det_max, dout => clk_1hz_out);
	clk_1hz_det_max <= clk_1hz_out(2) and clk_1hz_out(0);
	counter : entity work.counter port map(clk => clk, en => clk_1hz_det_max, rst => counter_det_max, dout => counter_out);
	seg_encoder : entity work.seg_encoder port map(din => counter_out, dout => seg_enc_out);
	counter_det_max <= counter_out(3) and counter_out(1);
	seg11 <= seg_enc_out(6);
	seg12 <= seg_enc_out(5);
	seg13 <= seg_enc_out(4);
	seg14 <= seg_enc_out(3);
	seg15 <= seg_enc_out(2);
	seg16 <= seg_enc_out(1);
	seg17 <= seg_enc_out(0);
end arch;
