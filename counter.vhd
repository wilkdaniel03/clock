library ieee;
use ieee.std_logic_1164.all;

entity counter is
	port(clk : in std_logic; rst : in std_logic := '0'; dout : out std_logic_vector(3 downto 0));
end counter;

architecture arch of counter is
	signal current : std_logic_vector(3 downto 0) := "0000";
begin
	dout <= current;
process(clk,rst) begin
	if rising_edge(clk) then
		current(3) <= (current(3) and (not(current(2) and current(1) and current(0)))) or (not(current(3)) and current(2) and current(1) and current(0));
		current(2) <= (not(current(2)) and current(1) and current(0)) or (current(2) and (current(1) nand current(0)));
		current(1) <= current(1) xor current(0);
		current(0) <= not(current(0));
		if rst = '1' then
			current <= "0000";
		end if;
	end if;
end process;
end arch;
