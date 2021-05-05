library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity banc is
    port (  RA,RB,RW : IN std_logic_vector(3 downto 0);
            W : IN std_logic_vector(31 downto 0);
            A,B : OUT std_logic_vector(31 downto 0);
            WE,clk : IN std_logic);
end entity; 


architecture mon_archi of banc is
-- Declaration Type Tableau Memoire
type table is array(15 downto 0) of
std_logic_vector(31 downto 0);
-- Fonction d'Initialisation du Banc de Registres
function init_banc return table is
variable result : table;
begin
for i in 14 downto 0 loop
result(i) := (others=>'0');
end loop;
result(15):=X"00000030";
return result;
end init_banc;

-- Declaration et Initialisation du Banc de Registres 16x32 bits
signal Banc: table:=init_banc;
signal s_RA, s_RB, s_RW : Integer RANGE 0 to 16;
begin
    s_RA<=to_integer(unsigned(RA));
    s_RB<=to_integer(unsigned(RB));
    s_RW<=to_integer(unsigned(RW));
    A<=Banc(s_RA);
    B<=Banc(s_RB);
    process(clk)
    begin
        if rising_edge(clk) then
            if WE='1' then
                Banc(s_RW)<=W;
            end if;
        end if;
    end process;
end architecture;

