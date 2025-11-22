library ieee;
use ieee.std_logic_1164.all;

entity prescaler_tb is
	port(clk_10,clk_100,clk_1000,clk_10000,clk_100000,clk_1000000,clk_10000000 : out std_logic);
end prescaler_tb;

architecture arch of prescaler_tb is
	signal clk : std_logic := '1';
	signal current : std_logic_vector(6 downto 0) := "0000000";
begin
	clk <= not clk after 10 ps;
	uut : entity work.prescaler port map(clk => clk, y => current);
	clk_10 <= current(6);
	clk_100 <= current(5);
	clk_1000 <= current(4);
	clk_10000 <= current(3);
	clk_100000 <= current(2);
	clk_1000000 <= current(1);
	clk_10000000 <= current(0);
process begin
	wait for 10 us;
end process;
end arch;
