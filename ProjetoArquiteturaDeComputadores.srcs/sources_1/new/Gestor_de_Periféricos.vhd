library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Gestor_De_Perifericos is
    Port ( ESCR_P : in STD_LOGIC;
           PIN : in STD_LOGIC_VECTOR (7 downto 0);
           POUT : out STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Operando1 : in STD_LOGIC_VECTOR (7 downto 0);
           Dados_IN : out STD_LOGIC_VECTOR (7 downto 0));
end Gestor_De_Perifericos;

architecture Behavioral of Gestor_De_Perifericos is

begin
    process(CLK)
    begin
        if rising_edge (CLK)then
            if ESCR_P = '1' then
                POUT <= Operando1;
            end if;
        end if;     
    end process;
    
    Dados_IN <= PIN when ESCR_P = '0' else (others => '0');

end Behavioral;
