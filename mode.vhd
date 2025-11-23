library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mode is
	port(clk,btn1,btn2,btn3 : in std_logic; y3,y2,y1 : out std_logic);
end mode;

architecture arch of mode is
	-- S1,S0,S,Ug,Um
	type mem_t is array(0 to 2**5-1) of std_logic_vector(4 downto 0);
	signal memory : mem_t :=
		(
			"00100","01001","10010","10010","00100","00100","00100","00100",
			"01001","01001","10010","10010","00100","00100","00100","00100",
			"10010","01001","10010","10010","00100","00100","00100","00100",
			"00100","00100","00100","00100","00100","00100","00100","00100"
		);
	signal addr : std_logic_vector(4 downto 0) := "00000";
	signal current : std_logic_vector(1 downto 0) := "00";
	signal next_state : std_logic_vector(4 downto 0) := "00000";
begin
process(clk) begin
	if rising_edge(clk) then
		addr(4 downto 3) <= current;
		addr(2) <= btn1;
		addr(1) <= btn2;
		addr(0) <= btn3;
		next_state <= memory(to_integer(unsigned(addr)));
		current <= next_state(4 downto 3);
	end if;
end process;
	y3 <= next_state(2);
	y2 <= next_state(1);
	y1 <= next_state(0);
end arch;
