library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necessário para a função to_unsigned

entity tb_ROM_Memoria_Instrucoes is
-- Um testbench não tem portos de entrada/saída
end tb_ROM_Memoria_Instrucoes;

architecture Behavioral of tb_ROM_Memoria_Instrucoes is

    -- Declaração do componente a testar (DUT)
    component ROM_Memoria_Instrucoes
        Port ( 
            Endereco  : in STD_LOGIC_VECTOR (7 downto 0);
            opcode    : out STD_LOGIC_VECTOR (4 downto 0);
            SEL_R     : out STD_LOGIC;
            Constante : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Sinais internos para ligar às portas do componente
    signal Endereco_tb  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal opcode_tb    : STD_LOGIC_VECTOR(4 downto 0);
    signal SEL_R_tb     : STD_LOGIC;
    signal Constante_tb : STD_LOGIC_VECTOR(7 downto 0);

begin

    -- Instanciação do componente (Mapeamento)
    uut: ROM_Memoria_Instrucoes PORT MAP (
        Endereco  => Endereco_tb,
        opcode    => opcode_tb,
        SEL_R     => SEL_R_tb,
        Constante => Constante_tb
    );

    -- Processo de estímulos
    stim_proc: process
    begin
        -- Aguarda um pouco antes de começar
        wait for 20 ns;

        -- Ciclo FOR para testar os endereços de 0 a 40
        -- (Os endereços de 0 a 36 têm instruções reais, do 37 ao 40 devem dar NOP/Zeros)
        for i in 0 to 40 loop
            
            -- Converte o inteiro 'i' para um vetor binário de 8 bits e aplica à entrada
            Endereco_tb <= std_logic_vector(to_unsigned(i, 8));
            
            -- Espera 10 ns para permitir a leitura da waveform
            wait for 10 ns;
            
        end loop;

        -- Teste concluído, pára a simulação
        wait;
    end process;

end Behavioral;