library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_RAM is
-- O testbench não tem portos
end tb_RAM;

architecture Behavioral of tb_RAM is

    -- Declaração do componente RAM
    component RAM
        Port ( 
            DadosIN  : in STD_LOGIC_VECTOR (7 downto 0);
            Endereco : in STD_LOGIC_VECTOR (7 downto 0);
            WR       : in STD_LOGIC;
            CLK      : in STD_LOGIC;
            DadosOUT : out std_logic_vector (7 downto 0)
        );
    end component;

    -- Sinais internos para ligar ao componente
    signal DadosIN_tb  : std_logic_vector(7 downto 0) := (others => '0');
    signal Endereco_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal WR_tb       : std_logic := '0';
    signal CLK_tb      : std_logic := '0';
    signal DadosOUT_tb : std_logic_vector(7 downto 0);

    -- Definição do período do relógio (ex: 10 ns -> 100 MHz)
    constant clk_period : time := 10 ns;

begin

    -- Instanciação do Device Under Test (DUT)
    uut: RAM PORT MAP (
        DadosIN  => DadosIN_tb,
        Endereco => Endereco_tb,
        WR       => WR_tb,
        CLK      => CLK_tb,
        DadosOUT => DadosOUT_tb
    );

    -- Processo para gerar o sinal de Clock continuamente
    clk_process : process
    begin
        CLK_tb <= '0';
        wait for clk_period/2;
        CLK_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Processo de estímulos (Escrita e Leitura)
    stim_proc: process
    begin
        -- Espera inicial para estabilizar o sistema
        wait for 20 ns;

        -----------------------------------------------------------
        -- FASE 1: TESTE DE ESCRITA (WR = '1')
        -----------------------------------------------------------
        WR_tb <= '1';
        
        -- Escrever x"AA" no endereço 10
        Endereco_tb <= x"0A"; 
        DadosIN_tb  <= x"AA";
        wait for clk_period;
        
        -- Escrever x"55" no endereço 11
        Endereco_tb <= x"0B"; 
        DadosIN_tb  <= x"55";
        wait for clk_period;
        
        -- Escrever x"FF" no endereço 12
        Endereco_tb <= x"0C"; 
        DadosIN_tb  <= x"FF";
        wait for clk_period;

        -----------------------------------------------------------
        -- FASE 2: TESTE DE LEITURA (WR = '0')
        -----------------------------------------------------------
        WR_tb <= '0';
        DadosIN_tb <= x"00"; -- Limpar a entrada só para garantir que não interfere
        
        -- Ler endereço 10 (Deve aparecer x"AA" no DadosOUT_tb)
        Endereco_tb <= x"0A";
        wait for clk_period;

        -- Ler endereço 11 (Deve aparecer x"55" no DadosOUT_tb)
        Endereco_tb <= x"0B";
        wait for clk_period;

        -- Ler endereço 12 (Deve aparecer x"FF" no DadosOUT_tb)
        Endereco_tb <= x"0C";
        wait for clk_period;

        -- Parar a simulação
        wait;
    end process;

end Behavioral;