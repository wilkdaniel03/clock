library ieee;
use ieee.std_logic_1164.all;

entity prescaler is
	port(clk : in std_logic; y : out std_logic_vector(6 downto 0));
end prescaler;

architecture arch of prescaler is
	signal current : std_logic_vector(6 downto 0) := "0000000";
	signal first_dout : std_logic_vector(3 downto 0) := "0000";
	signal first_det_max : std_logic := '0';
begin
	first_counter : entity work.counter port map(clk => clk, en => '1', rst => first_det_max, dout => first_dout);
	first_det_max <= first_dout(3) and first_dout(1);
	current(6) <= first_det_max;

	counters : for i in 5 downto 0 generate
		signal dout : std_logic_vector(3 downto 0) := "0000";
		signal dout_det_max : std_logic := '0';
	begin
		counter : entity work.counter port map(clk => clk, en => current(i+1), rst => dout_det_max, dout => dout);
		dout_det_max <= dout(3) and dout(1);
		current(i) <= dout_det_max;
	end generate;

	y <= current;
end arch;
