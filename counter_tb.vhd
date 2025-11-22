library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
	port(y : out std_logic_vector(3 downto 0));
end counter_tb;

architecture arch of counter_tb is
	signal clk : std_logic := '1';
	signal rst : std_logic := '0';
	signal dout : std_logic_vector(3 downto 0) := "0000";
begin
	clk <= not clk after 500 ps;
	rst <= dout(3) and dout(0);
	y <= dout;
	uut : entity work.counter port map(clk => clk, rst => rst, dout => dout);
process begin
	wait for 16 ns;
end process;
end arch;
