library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity MAE is
    port ( 
        --INPUTS
        CLK,RST : IN std_logic;
        IRQ : IN std_logic;
        INST_MEM : IN std_logic_vector(31 downto 0);
        INST_REG : IN std_logic_vector(31 downto 0);
        --OUPUTS
        IRQ_SERV : OUT std_logic;
        N : OUT std_logic;
        LRWrEn, PCWrEn, PCSel, AdrSel, MemRdEn, MemWrEn, IRWrEn, Wsel, RegWrEn, 
        ALUSelA, ALUSelB, ALUOP, CPSRSel, CPSRWrEn, SPSRWrEn, ResWrEn : OUT std_logic
    );
end entity;

architecture RTL of MAE is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, BX);
    signal instr_courante : enum_instruction;
    signal ISR : std_logic;
    begin
        process(Instruction)
        begin
            if Instruction(27)= '0' then
                case Instruction(27 downto 20) is
                    --LDR Immediate
                    when  "01100001" => instr_courante <= LDR;
                    --STR Immediate
                    when  "01100000" => instr_courante <= STR;
                    --ADD immediate
                    when  "00101000" => instr_courante <= ADDi;
                    --ADD register
                    when  "00001000" => instr_courante <= ADDr;
                    --MOV Immediate
                    when  "00111010" => instr_courante <= MOV;
                    --CMP Immediate
                    when  "00110101" => instr_courante <= CMP;
                    when others => NULL;
                end case;
            else
                case Instruction(31 downto 24) is
                    --BAL 
                    when "11101010" => instr_courante <= BAL;
                    --BLT
                    when "10111010" => instr_courante <= BLT;
                    --BX
                    when "11101011" => instr_courante <= BX;
                    when others => NULL;
                end case;
            end if;
        end process;
    
        process(CLK,RST)
        begin
            case instr_courante is
                when ADDi => nPCsel <= '0';
                            RegWr  <= '1';
                            PSREn  <= '0';
                            ALUsrc <= '1';
                            ALUCtr <= "00";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Rn <= Instruction(19 downto 16);
                            Rd <= Instruction(15 downto 12);
                            Imm <= Instruction(7 downto 0);
    
                
                when ADDr => nPCsel <= '0';
                            RegWr  <= '1';
                            PSREn  <= '0';
                            ALUsrc <= '0';
                            ALUCtr <= "00";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Rn <= Instruction(19 downto 16);
                            Rd <= Instruction(15 downto 12);
                            Rm <= Instruction(3 downto 0);
    
                when BAL => nPCsel <= '1';
                            RegWr  <= '0';
                            PSREn  <= '0';
                            ALUsrc <= '0';
                            ALUCtr <= "00";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Offset <= Instruction(23 downto 0);
    
                when BLT => nPCsel <= PSR_in(0);
                            RegWr  <= '0';
                            PSREn  <= '0';
                            ALUsrc <= '0';
                            ALUCtr <= "00";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Offset <= Instruction(23 downto 0);            
                
                when CMP => nPCsel <= '0';
                            RegWr  <= '0';
                            PSREn  <= '1';
                            ALUsrc <= '1';
                            ALUCtr <= "10";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Rn <= Instruction(19 downto 16);
                            Imm <= Instruction(7 downto 0);
                
                when LDR => nPCsel <= '0';
                            RegWr  <= '1';
                            PSREn  <= '0';
                            ALUsrc <= '1';
                            ALUCtr <= "00";
                            WrSrc <= '1';
                            RegSel <= '0';
                            MemWr <= '0';
                            Rn <= Instruction(19 downto 16);
                            Rd <= Instruction(15 downto 12);
                            Imm <= Instruction(7 downto 0);
                
                when MOV => nPCsel <= '0';
                            RegWr  <= '1';
                            PSREn  <= '0';
                            ALUsrc <= '1';
                            ALUCtr <= "01";
                            WrSrc <= '0';
                            RegSel <= '0';
                            MemWr <= '0';
                            Rd <= Instruction(15 downto 12);
                            Imm <= Instruction(7 downto 0);
                            
                when STR => nPCsel <= '0';
                            RegWr  <= '0';
                            PSREn  <= '0';
                            ALUsrc <= '1';
                            ALUCtr <= "00";
                            MemWr <= '1';
                            RegSel <= '1';
                            WrSrc <= '0';
                            Rn <= Instruction(19 downto 16);
                            Rd <= Instruction(15 downto 12);
                            Imm <= Instruction(7 downto 0);
            end case;
        end process;
