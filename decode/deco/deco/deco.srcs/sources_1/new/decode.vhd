----------------------------------------------------------------------------------
-- santiago cortes
-- tomas montañez
-- juan abella
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.search_rom.all;

entity decode is
    Port ( 
            selector : in std_logic_vector(2 downto 0); -- selectores de entrada
            cin : in std_logic;                         -- carry de entrada
            outs : out std_logic_vector(3 downto 0)     -- salidas a la alu
            
            );
end decode;

architecture Behavioral of decode is

signal in_deco : std_logic_vector   (3 downto 0); -- entradas del deco
signal out_deco : std_logic_vector (15 downto 0); -- salidas deco
signal data_out : std_logic_vector  (3 downto 0); -- salida de la memoria
            
begin

in_deco <= cin & selector; -- definimos la entrafa del deco

decode : component decodificador port map 
        (entradas => in_deco,salidas => out_deco); -- componente decodificador
rom : component memory port map 
        (address => out_deco, data_out => data_out); -- memoria rom

outs <= data_out; -- salidad de a la alu

end Behavioral;
