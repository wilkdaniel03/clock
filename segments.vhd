library ieee;
use ieee.std_logic_1164.all;

entity segments is
	port(clk,en : in std_logic; modes : in std_logic_vector(2 downto 0); seg1,seg2,seg3,seg4: out std_logic_vector(6 downto 0));
end segments;

architecture arch of segments is
	signal seg_din_1 : std_logic_vector(3 downto 0) := "0000";
	signal seg_din_det1_max : std_logic := '0';
	signal seg_din_2 : std_logic_vector(3 downto 0) := "0000";
	signal seg_din_det2_max : std_logic := '0';
	signal seg_din_cond1 : std_logic := '0';
	signal seg_din_cond2 : std_logic := '0';
	signal seg_din_3 : std_logic_vector(3 downto 0) := "0000";
	signal seg_din_det3_max : std_logic := '0';
	signal seg_din_4 : std_logic_vector(3 downto 0) := "0000";
	signal seg_din_det4_max : std_logic := '0';
begin
	-- counter 1
	seg_din_cond1 <= en when modes(1) = '0' else '0';
	counter_1 : entity work.counter port map(clk => clk, en => seg_din_cond1, rst => seg_din_det1_max, dout => seg_din_1);
	seg_din_det1_max <= seg_din_1(3) and seg_din_1(1);
	seg_enc1 : entity work.seg_encoder port map(din => seg_din_1, dout => seg1);
	-- counter 2
	counter_2 : entity work.counter port map(clk => clk, en => seg_din_det1_max, rst => seg_din_det2_max, dout => seg_din_2);
	seg_din_det2_max <= seg_din_2(2) and seg_din_2(1);
	seg_enc2 : entity work.seg_encoder port map(din => seg_din_2, dout => seg2);
	-- counter 3
	seg_din_cond2 <= seg_din_det2_max when modes(2) = '1' else
					en when modes(1) = '1' else '0';
	counter_3 : entity work.counter port map(clk => clk, en => seg_din_cond2, rst => seg_din_det3_max, dout => seg_din_3);
	seg_din_det3_max <= (seg_din_3(3) and seg_din_3(1)) or (seg_din_4(1) and seg_din_3(2));
	seg_enc3 : entity work.seg_encoder port map(din => seg_din_3, dout => seg3);
	-- counter 4
	counter_4 : entity work.counter port map(clk => clk, en => seg_din_det3_max, rst => seg_din_det4_max, dout => seg_din_4);
	seg_din_det4_max <= seg_din_4(1) and seg_din_3(2);
	seg_enc4 : entity work.seg_encoder port map(din => seg_din_4, dout => seg4);
end arch;
