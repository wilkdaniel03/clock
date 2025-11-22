library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(clk : in std_logic; y : out std_logic);
end clock;

architecture arch of clock is
	signal prescaler_out : std_logic_vector(6 downto 0) := "0000000";
	signal clk_1hz_out : std_logic_vector(3 downto 0) := "0000";
	signal counter_out : std_logic_vector(3 downto 0) := "0000";
begin
	prescaler : entity work.prescaler port map(clk => clk, y => prescaler_out);
	counter_1hz : entity work.counter port map(clk => clk, en => prescaler_out(0), rst => clk_1hz_out(2), dout => clk_1hz_out);
	counter : entity work.counter port map(clk => clk, en => clk_1hz_out(2), dout => counter_out);
	y <= counter_out(0);
end arch;
