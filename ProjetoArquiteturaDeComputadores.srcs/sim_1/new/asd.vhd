library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ProgramCounter is
-- O testbench não tem portos de entrada/saída
end tb_ProgramCounter;

architecture Behavioral of tb_ProgramCounter is

    -- Declaração do componente ProgramCounter (DUT)
    component ProgramCounter
        Port ( 
            Constante : in STD_LOGIC_VECTOR (7 downto 0);
            Salto     : in STD_LOGIC;
            Clock     : in STD_LOGIC;
            Reset     : in STD_LOGIC;
            Endereco  : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Sinais internos para estimular as entradas do DUT
    signal Constante_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Salto_tb     : STD_LOGIC := '0';
    signal Clock_tb     : STD_LOGIC := '0';
    signal Reset_tb     : STD_LOGIC := '0';
    
    -- Sinal interno para ler a saída
    signal Endereco_tb  : STD_LOGIC_VECTOR(7 downto 0);

    -- Definição do período do relógio
    constant clk_period : time := 10 ns;

begin

    -- Instanciação do Device Under Test (DUT)
    uut: ProgramCounter PORT MAP (
        Constante => Constante_tb,
        Salto     => Salto_tb,
        Clock     => Clock_tb,
        Reset     => Reset_tb,
        Endereco  => Endereco_tb
    );

    -- Processo para gerar o sinal de Clock contínuo
    clk_process : process
    begin
        Clock_tb <= '0';
        wait for clk_period/2;
        Clock_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Processo de estímulos (Reset, Contagem e Salto)
    stim_proc: process
    begin
        -- FASE 1: Testar o Reset (garantir que o PC arranca a zero)
        Reset_tb <= '1';
        Salto_tb <= '0';
        Constante_tb <= x"00";
        wait for clk_period * 2; 

        -- FASE 2: Contagem Normal
        -- Desligar o reset, o PC deve começar a contar: 1, 2, 3, 4...
        Reset_tb <= '0';
        wait for clk_period * 5; -- Deixa contar durante 5 ciclos de relógio

        -- FASE 3: Testar o Salto (Jump)
        -- Simular uma instrução de salto para o endereço x"30" (48 em decimal)
        Salto_tb <= '1';
        Constante_tb <= x"30";
        wait for clk_period; -- O salto demora apenas 1 ciclo de relógio a carregar

        -- FASE 4: Contagem após o Salto
        -- Desligar o salto, o PC deve continuar a contar a partir de x"30": x"31", x"32"...
        Salto_tb <= '0';
        wait for clk_period * 4;

        -- FASE 5: Reset a meio do funcionamento
        -- Garantir que o reset tem prioridade e limpa o PC independentemente de onde ele está
        Reset_tb <= '1';
        wait for clk_period * 2;

        -- Terminar a simulação
        wait;
    end process;

end Behavioral;