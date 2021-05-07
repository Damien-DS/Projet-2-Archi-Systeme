library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VIC is
    port ( 
        --INPUTS
        CLK,RST : IN std_logic;
        IRQ_SERV, IRQ0, IRQ1 : IN std_logic;
        --OUPUTS
        IRQ : OUT std_logic;
        VICPC : OUT std_logic_vector(31 downto 0)
    );
end entity; 

Architecture RTL of VIC is
signal last_IRQ0, last_IRQ1, IRQ0_memo, IRQ1_memo : std_logic;
begin
    process(CLK,RST)
    begin
        last_IRQ0 <= IRQ0;
        last_IRQ0 <= IRQ1;
        if RST = '1' then
            VIPC <= x"0";
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
        elsif rising_edge(clk) then
            if last_IRQ0 = '0' and IRQ0 = '1' then 
                IRQ0_memo <= '1'
            end if;
            if last_IRQ1 = '0' and IRQ1 = '1' then 
                IRQ1_memo <= '1'
            end if;            
        end if;
    end process;

    process(IRQ0_memo,IRQ1_memo)
    begin
        if IRQ0_memo = '1' then
            VIPC <= x"9";
        elsif IRQ1_memo = '1' then
            VIPC <= x"15";
        end if;        
    end process;

    process(IRQ_SERV)
    begin 
        if IRQ_SERV = '1' then
            IRQ0_memo <= '0';
            IRQ1_memo <= '0';
        end if;
    end process;

    IRQ <= IRQ1_memo OR IRQ0_memo;

end architecture;
            
