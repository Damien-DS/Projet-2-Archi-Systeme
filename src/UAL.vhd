library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UAL is 
port (	OP : IN std_logic_vector(1 downto 0);
		A,B : IN std_logic_vector(31 downto 0);
		S : OUT std_logic_vector(31 downto 0);
		N : OUT std_logic);
end entity;

architecture combinatoire of UAL is
	signal S_signal : std_logic_vector(31 downto 0);
begin
	S_signal <= 	std_logic_vector(signed(A)+signed(B)) when OP = "00" else
					B when OP = "01" else
					std_logic_vector(signed(A)-signed(B)) when OP = "10"else
					A;
	N <= S_signal(31);
	S <= S_signal;
end architecture; 
