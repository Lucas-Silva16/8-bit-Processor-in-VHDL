library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registos_A_e_B is
    Port ( CLK : in STD_LOGIC;
           ESCR_R : in STD_LOGIC;
           Dados_R : in STD_LOGIC_VECTOR (7 downto 0);
           Sel_R : in STD_LOGIC;
           Operando1 : out STD_LOGIC_VECTOR (7 downto 0);
           Operando2 : out STD_LOGIC_VECTOR (7 downto 0));
end Registos_A_e_B;

architecture Behavioral of Registos_A_e_B is

signal R_a : std_logic_vector  (7 downto 0);
signal R_b : std_logic_vector (7 downto 0);

begin
    process(CLK)
    begin
    if rising_edge(CLK)then
        if ESCR_R = '1' then
            if SEL_R = '1' then
                R_b <= Dados_R;
            else
                R_a <= Dados_R;
            end if;
    
        end if;
    end if;
    end process;

Operando1 <= R_a;
Operando2 <= R_b;

end Behavioral;
