----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2026 20:11:57
-- Design Name: 
-- Module Name: REGISTO_FLAGS - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity REGISTO_FLAGS is
    Port ( CLK : in STD_LOGIC;
           E_FLAG : in STD_LOGIC_VECTOR (4 downto 0);
           ESCR_FLAG : in STD_LOGIC;
           SEL_FLAG : in STD_LOGIC_VECTOR (2 downto 0);
           S_FLAG : out STD_LOGIC);
end REGISTO_FLAGS;

architecture Behavioral of REGISTO_FLAGS is
    signal registo_interno : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
begin
    --FUNCAO PARA GUARDAR A ENTRADA
    process(CLK)
    begin
        if rising_edge(CLK) then
            if ESCR_FLAG = '1' then
                registo_interno <= E_FLAG;
            end if;
        end if;    
    end process;
    --FUNCAO PARA FAZER A LOGICA DE LEITURA
    process(SEL_FLAG, registo_interno)
    begin
        case SEL_FLAG is
            when "000" => S_FLAG <= registo_interno(0);
            when "001" => S_FLAG <= registo_interno(1);
            when "010" => S_FLAG <= registo_interno(2);
            when "011" => S_FLAG <= registo_interno(3);
            when "100" => S_FLAG <= registo_interno(4);
            when others => S_FLAG <= 'X';
        end case;
    end process;
end Behavioral;
