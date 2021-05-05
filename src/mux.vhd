LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity mux is
generic (N: integer := 32);
port(   -- input data
        A,B: in std_logic_vector (N-1 downto 0);
        COM: in std_logic;
        -- output data 
        S: out std_logic_vector (N-1 downto 0)
);
end mux; 

architecture comportementale of mux is
begin
    S <= A when com = '0' else
         B;
end architecture;