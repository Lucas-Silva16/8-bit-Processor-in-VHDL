library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_REGISTO_FLAGS is
-- Um testbench não tem portos de entrada/saída
end tb_REGISTO_FLAGS;

architecture Behavioral of tb_REGISTO_FLAGS is

    -- 1. Declaração do Componente a testar
    component REGISTO_FLAGS
    Port ( CLK : in STD_LOGIC;
           E_FLAG : in STD_LOGIC_VECTOR (4 downto 0);
           ESCR_FLAG : in STD_LOGIC;
           SEL_FLAG : in STD_LOGIC_VECTOR (2 downto 0);
           S_FLAG : out STD_LOGIC);
    end component;

    -- 2. Sinais internos para ligar ao Componente
    signal CLK : STD_LOGIC := '0';
    signal E_FLAG : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal ESCR_FLAG : STD_LOGIC := '0';
    signal SEL_FLAG : STD_LOGIC_VECTOR (2 downto 0) := "000";
    signal S_FLAG : STD_LOGIC;

    -- Constante para o período do relógio
    constant clk_period : time := 10 ns;

begin

    -- 3. Instanciar o Componente (Unit Under Test - UUT)
    uut: REGISTO_FLAGS port map (
        CLK => CLK,
        E_FLAG => E_FLAG,
        ESCR_FLAG => ESCR_FLAG,
        SEL_FLAG => SEL_FLAG,
        S_FLAG => S_FLAG
    );

    -- 4. Processo que gera o sinal de Clock
    clk_process :process
    begin
        CLK <= '0';
        wait for clk_period/2;
        CLK <= '1';
        wait for clk_period/2;
    end process;

    -- 5. Processo de Estímulos (Onde a magia acontece)
    stim_proc: process
    begin
        -- Esperar que o circuito estabilize
        wait for 20 ns;
        
        -------------------------------------------------------------
        -- TESTE 1: Escrever um valor de teste no registo ("10110")
        -------------------------------------------------------------
        E_FLAG <= "10110";  -- Entrada de 5 bits
        ESCR_FLAG <= '1';   -- Permite a escrita
        wait for clk_period;
        
        ESCR_FLAG <= '0';   -- Desativa a escrita
        wait for clk_period;
        
        -------------------------------------------------------------
        -- TESTE 2: Ler todas as posições (Teste ao processo Assíncrono)
        -------------------------------------------------------------
        SEL_FLAG <= "000"; wait for 10 ns; -- Bit 0: Deve ler '0'
        SEL_FLAG <= "001"; wait for 10 ns; -- Bit 1: Deve ler '1'
        SEL_FLAG <= "010"; wait for 10 ns; -- Bit 2: Deve ler '1'
        SEL_FLAG <= "011"; wait for 10 ns; -- Bit 3: Deve ler '0'
        SEL_FLAG <= "100"; wait for 10 ns; -- Bit 4: Deve ler '1'
        SEL_FLAG <= "111"; wait for 10 ns; -- Others: Deve ler 'X'
        
        -------------------------------------------------------------
        -- TESTE 3: Garantir que a memória mantém o valor sem ESCR_FLAG
        -------------------------------------------------------------
        E_FLAG <= "11111"; -- Tentamos enviar tudo a '1' na entrada
        SEL_FLAG <= "001"; -- Lemos o bit 1 (que era '1' no valor "10110")
        wait for clk_period * 2;
        -- Ao olhar para as waveforms, a saída não deve mudar para os
        -- novos valores de E_FLAG porque ESCR_FLAG continua a '0'.

        -- Parar a simulação
        wait;
    end process;

end Behavioral;