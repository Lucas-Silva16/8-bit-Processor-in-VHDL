library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Registos_A_e_B is

end tb_Registos_A_e_B;

architecture behavior of tb_Registos_A_e_B is

    component Registos_A_e_B
    Port ( 
        CLK       : in STD_LOGIC;
        ESCR_R    : in STD_LOGIC;
        Dados_R   : in STD_LOGIC_VECTOR (7 downto 0);
        Sel_R     : in STD_LOGIC;
        Operando1 : out STD_LOGIC_VECTOR (7 downto 0);
        Operando2 : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;

    -- 2. Sinais internos para ligar às portas do componente
    -- Sinais de entrada (inicializados a '0')
    signal CLK     : std_logic := '0';
    signal ESCR_R  : std_logic := '0';
    signal Dados_R : std_logic_vector(7 downto 0) := (others => '0');
    signal Sel_R   : std_logic := '0';

    -- Sinais de saída
    signal Operando1 : std_logic_vector(7 downto 0);
    signal Operando2 : std_logic_vector(7 downto 0);

    -- 3. Definição do período do sinal de relógio (ex: 10 nanossegundos)
    constant CLK_period : time := 10 ns;

begin

    -- 4. Instanciar o nosso componente e ligar os sinais
    uut: Registos_A_e_B PORT MAP (
        CLK       => CLK,
        ESCR_R    => ESCR_R,
        Dados_R   => Dados_R,
        Sel_R     => Sel_R,
        Operando1 => Operando1,
        Operando2 => Operando2
    );

    -- 5. Processo que gera o sinal de relógio continuamente (alterna entre 0 e 1)
    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

    -- 6. Processo de estímulos (onde enviamos os dados de teste)
    stim_proc: process
    begin
        -- Esperar um pouco antes de começar (para ver tudo a zero no início do gráfico)
        wait for 20 ns;

        -- TESTE 1: Escrever no Registo A
        ESCR_R  <= '1';                   -- Autoriza a escrita
        Sel_R   <= '0';                   -- Seleciona o Registo A
        Dados_R <= "10101010";            -- Vamos tentar guardar este valor (AA em hexa)
        wait for CLK_period;              -- Espera 1 ciclo de relógio para a escrita se concretizar

        -- TESTE 2: Escrever no Registo B
        ESCR_R  <= '1';                   -- Mantém a autorização de escrita
        Sel_R   <= '1';                   -- Agora seleciona o Registo B
        Dados_R <= "01010101";            -- Vamos tentar guardar este valor diferente (55 em hexa)
        wait for CLK_period;              -- Espera 1 ciclo de relógio

        -- TESTE 3: Tentar alterar sem autorização de escrita (ESCR_R = '0')
        ESCR_R  <= '0';                   -- Retira a autorização de escrita!
        Sel_R   <= '0';                   -- Volta a selecionar o Registo A
        Dados_R <= "11111111";            -- Tenta meter tudo a '1' (FF em hexa)
        wait for CLK_period * 2;          -- Espera 2 ciclos de relógio

        -- Fim da simulação (o "wait;" sem tempo pára este processo para sempre)
        wait;
    end process;

end behavior;