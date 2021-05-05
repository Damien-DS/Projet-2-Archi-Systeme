LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity extension is
generic (N: integer := 8);
port(   -- input data
        E: in std_logic_vector (N-1 downto 0);
        -- output data 
        S: out std_logic_vector (31 downto 0)
);
end entity; 

architecture comportementale of extension is
    signal E_s : signed (N-1 downto 0);
begin
    E_s <= signed(E);
    S(31 downto N) <= (others => '1') when E_s(N-1) = '1' else (others => '0');
    S(N-1 downto 0) <= E; 
end architecture;
