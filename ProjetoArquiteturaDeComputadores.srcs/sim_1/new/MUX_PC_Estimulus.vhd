library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_MUX_PC is
-- Entidade vazia, como é habitual nos testbenches
end tb_MUX_PC;

architecture behavior of tb_MUX_PC is

    -- Declaração do componente que vamos testar
    component MUX_PC
        Port ( 
           S_FLAG    : in std_logic;
           VCC       : in std_logic;
           GROUND    : in std_logic;
           Operando1 : in std_logic_vector (7 downto 0);
           SEL_PC    : in std_logic_vector (2 downto 0);
           ESCR_PC   : out std_logic    
        );
    end component;

    -- Sinais internos para estimular as entradas
    signal S_FLAG_tb    : std_logic := '0';
    signal VCC_tb       : std_logic := '1';
    signal GROUND_tb    : std_logic := '0';
    signal Operando1_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal SEL_PC_tb    : std_logic_vector(2 downto 0) := "000";
    
    -- Sinal interno para ler a saída
    signal ESCR_PC_tb   : std_logic;

begin

    -- Instanciação do DUT (Device Under Test)
    uut: MUX_PC PORT MAP (
        S_FLAG    => S_FLAG_tb,
        VCC       => VCC_tb,
        GROUND    => GROUND_tb,
        Operando1 => Operando1_tb,
        SEL_PC    => SEL_PC_tb,
        ESCR_PC   => ESCR_PC_tb
    );

    -- Processo de estímulos
    stim_proc: process
    begin
        -- Aguardar um pouco no início da simulação
        wait for 20 ns;

        -- Teste 1: SEL_PC = "000" (Deve dar saída GROUND, ou seja, '0')
        SEL_PC_tb <= "000";
        wait for 20 ns;

        -- Teste 2: SEL_PC = "001" (Deve dar saída VCC, ou seja, '1')
        SEL_PC_tb <= "001";
        wait for 20 ns;

        -- Teste 3: SEL_PC = "010" com S_FLAG = '0', depois '1' (Passa o valor de S_FLAG)
        SEL_PC_tb <= "010";
        S_FLAG_tb <= '0';
        wait for 20 ns;
        S_FLAG_tb <= '1';
        wait for 20 ns;

        -- Teste 4: SEL_PC = "011" (NOR de todos os bits de Operando1)
        -- Deve dar '1' quando Operando1 é zero
        SEL_PC_tb <= "011";
        Operando1_tb <= "00000000"; 
        wait for 20 ns;
        -- Deve dar '0' quando Operando1 tem algum bit a '1'
        Operando1_tb <= "00010000"; 
        wait for 20 ns;

        -- Teste 5: SEL_PC = "100" (Passa apenas o bit 7 de Operando1)
        SEL_PC_tb <= "100";
        -- Se o bit 7 for '1', a saída deve ser '1'
        Operando1_tb <= "10000000"; 
        wait for 20 ns;
        -- Se o bit 7 for '0' (mesmo com outros bits a '1'), a saída deve ser '0'
        Operando1_tb <= "01111111"; 
        wait for 20 ns;

        -- Teste 6: SEL_PC = Outros valores (Deve dar 'X' - Desconhecido)
        SEL_PC_tb <= "111";
        wait for 20 ns;

        -- Fim da simulação
        wait;
    end process;

end behavior;