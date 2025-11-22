library ieee;
use ieee.std_logic_1164.all;

entity clock is
	port(y : out std_logic);
end clock;

architecture arch of clock is
begin
	y <= '1';
end arch;
