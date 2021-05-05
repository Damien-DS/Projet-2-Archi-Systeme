library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registre_commande_chargement is
    port(
        DATAIN : IN std_logic_vector(31 downto 0);
        RST, CLK, WE : IN std_logic;
        DATAOUT : OUT std_logic_vector(31 downto 0)
    );
end entity;

architecture mon_archi of registre_commande_chargement is
begin
    process(RST,CLK)
    begin
        if RST='1' then
            DATAOUT <= (others => '0');
        elsif rising_edge(CLK) then
            if WE='1' then
                 DATAOUT <= DATAIN;
            end if;
        end if;
    end process;
end architecture;

