library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mobo is
Port ( 
           CLK   : in STD_LOGIC;
           RESET : in STD_LOGIC;
           PIN   : in STD_LOGIC_VECTOR (7 downto 0);
           POUT  : out STD_LOGIC_VECTOR (7 downto 0)
         );
  
end Mobo;

architecture Behavioral of Mobo is

    component Processador is
    Port(
           CLK       : in STD_LOGIC;
           RESET     : in STD_LOGIC;
           PIN       : in STD_LOGIC_VECTOR (7 downto 0);
           POUT      : out STD_LOGIC_VECTOR (7 downto 0);
           opcode    : in STD_LOGIC_VECTOR (4 downto 0);
           Constante : in STD_LOGIC_VECTOR (7 downto 0);
           SEL_R_in  : in STD_LOGIC;
           Dados_M   : in STD_LOGIC_VECTOR (7 downto 0); 
           WR        : out STD_LOGIC;                    
           Endereco  : out STD_LOGIC_VECTOR (7 downto 0);
           Dados_W   : out STD_LOGIC_VECTOR (7 downto 0) 
         );
    end component;
    
    component RAM is
        Port ( DadosIN : in STD_LOGIC_VECTOR (7 downto 0);
           Endereco : in STD_LOGIC_VECTOR (7 downto 0);
           WR : in STD_LOGIC;
           CLK : in STD_LOGIC;
           DadosOUT : out std_logic_vector (7 downto 0));
    end component;
    
    component ROM_Memoria_Instrucoes is
        Port ( Endereco : in STD_LOGIC_VECTOR (7 downto 0);
           opcode : out STD_LOGIC_VECTOR (4 downto 0);
           SEL_R : out STD_LOGIC;
           Constante : out STD_LOGIC_VECTOR (7 downto 0)
           );
    end component;
    
-- fios da mem de instrucoes    
signal Endereco : std_logic_vector (7 downto 0);
signal opcode : std_logic_vector (4 downto 0);
signal Constante : std_logic_vector(7 downto 0);
signal SEL_R : std_logic;

--fios da mem de dados
signal WR : std_logic;
signal Dados_M : std_logic_vector (7 downto 0); -- Fio da RAM para o Processador
signal Dados_W : std_logic_vector (7 downto 0); -- Fio do Processador para a RAM
-- a constante ja ta em cima na ROM

begin

s_Processador : Processador 
    Port map (
           CLK=>CLK ,      
           RESET=>RESET ,    
           PIN =>PIN ,      
           POUT =>POUT ,     
           opcode =>opcode ,   
           Constante=>Constante , 
           SEL_R_in=>SEL_R , 
           Dados_M   =>Dados_M ,
           WR      =>WR ,         
           Endereco  =>Endereco ,
           Dados_W  =>Dados_W  
         );

s_RAM : RAM
    port map(
           DadosIN =>Dados_W ,
           Endereco =>Endereco ,
           WR =>WR ,
           CLK =>CLK ,
           DadosOUT =>Dados_M
           );
           
s_ROM_Memoria_Instrucoes : ROM_Memoria_Instrucoes
    port map( Endereco =>Endereco ,
           opcode =>opcode ,
           SEL_R =>SEL_R ,
           Constante =>Constante
           );


end Behavioral;
