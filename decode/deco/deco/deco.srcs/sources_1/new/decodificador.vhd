----------------------------------------------------------------------------------
-- santiago cortes
-- tomas montañez
-- juan abella
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decodificador is
    Port ( 
            entradas : in std_logic_vector (3 downto 0); -- entradas del decodificador carry in & selectores
            salidas : out std_logic_vector (15 downto 0) -- salidas en 1 y 0 del decodificador
            
            );
end decodificador;

architecture behavioral of decodificador is

begin

salidas(0) <= '1' when entradas = "0000" else '0'; --0                      
salidas(1) <= '1' when entradas = "0001" else '0'; --1                     
salidas(2) <= '1' when entradas = "0010" else '0'; --2                     
salidas(3) <= '1' when entradas = "0011" else '0'; --3                      
salidas(4) <= '1' when entradas = "0100" else '0'; --4                      
salidas(5) <= '1' when entradas = "0101" else '0'; --5                         
salidas(6) <= '1' when entradas = "0110" else '0'; --6                      
salidas(7) <= '1' when entradas = "0111" else '0'; --7                      
salidas(8) <= '1' when entradas = "1000" else '0'; --8                      
salidas(9) <= '1' when entradas = "1001" else '0'; --9                      
salidas(10) <= '1' when entradas = "1010" else '0'; --10                    
salidas(11) <= '1' when entradas = "1011" else '0'; --11                    
salidas(12) <= '1' when entradas = "1100" else '0'; --12                    
salidas(13) <= '1' when entradas = "1101" else '0'; --13                    
salidas(14) <= '1' when entradas = "1110" else '0'; --14                        
salidas(15) <= '1' when entradas = "1111" else '0'; --15                    

end behavioral;
