library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessário para usar a função to_unsigned no loop

entity tb_Descodificacao_ROM is
-- Um testbench não tem portos de entrada/saída, a entidade fica vazia.
end tb_Descodificacao_ROM;

architecture behavior of tb_Descodificacao_ROM is

    -- Declaração do componente a ser testado (DUT - Device Under Test)
    component Descodificacao_ROM
        Port ( 
            Opcode   : in STD_LOGIC_VECTOR (4 downto 0);
            SEL_ALU  : out STD_LOGIC_VECTOR (3 downto 0);
            ESCR_P   : out STD_LOGIC;
            SEL_DATA : out STD_LOGIC_VECTOR (1 downto 0);
            ESCR_R   : out STD_LOGIC;
            WR       : out STD_LOGIC;
            SEL_PC   : out STD_LOGIC_VECTOR (2 downto 0);
            ESCR_F   : out STD_LOGIC;
            SEL_F    : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Sinais internos para ligar às entradas e saídas do componente
    signal Opcode_tb   : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal SEL_ALU_tb  : STD_LOGIC_VECTOR(3 downto 0);
    signal ESCR_P_tb   : STD_LOGIC;
    signal SEL_DATA_tb : STD_LOGIC_VECTOR(1 downto 0);
    signal ESCR_R_tb   : STD_LOGIC;
    signal WR_tb       : STD_LOGIC;
    signal SEL_PC_tb   : STD_LOGIC_VECTOR(2 downto 0);
    signal ESCR_F_tb   : STD_LOGIC;
    signal SEL_F_tb    : STD_LOGIC_VECTOR(2 downto 0);

begin

    -- Instanciação do componente (Mapeamento dos portos aos sinais do testbench)
    uut: Descodificacao_ROM PORT MAP (
        Opcode   => Opcode_tb,
        SEL_ALU  => SEL_ALU_tb,
        ESCR_P   => ESCR_P_tb,
        SEL_DATA => SEL_DATA_tb,
        ESCR_R   => ESCR_R_tb,
        WR       => WR_tb,
        SEL_PC   => SEL_PC_tb,
        ESCR_F   => ESCR_F_tb,
        SEL_F    => SEL_F_tb
    );

    -- Processo que gera os estímulos (as entradas que vão ser testadas)
    stim_proc: process
    begin
        -- Aguarda 20 ns antes de começar a enviar valores (boa prática)
        wait for 20 ns;

        -- Ciclo FOR que testa todos os 32 opcodes possíveis (de 0 a 31)
        for i in 0 to 31 loop
            -- Converte o número inteiro 'i' para um vetor binário de 5 bits
            Opcode_tb <= std_logic_vector(to_unsigned(i, 5));
            
            -- Espera 10 ns para deixar os sinais estabilizarem e poderes ver na wave
            wait for 10 ns;
        end loop;

        -- Teste concluído, pára a simulação indefinidamente
        wait;
    end process;

end behavior;