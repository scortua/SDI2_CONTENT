-------------------------------------------------------------------------------------------
-- santiago cortes
-- tomas montañez
-- juan abella
-------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.search_rom.all;

entity memory is
    port (
        address : in std_logic_vector(15 downto 0); -- lugar de memoria
        data_out : out std_logic_vector(3 downto 0) -- salida de la memoria
        );
end entity memory;

architecture Behavioral of memory is
    --type rom_array is array (0 to 15) of std_logic_vector(3 downto 0);
    -- Definición del tipo "rom_array" como un array de 16 elementos de 8 bits

    constant rom_array: rom (0 to 15) :=(
        -- Contenido de la memoria ROM
        "0000", -- Dirección 0
        "0001", -- Dirección 1
        "0010", -- Dirección 2
        "0011", -- Dirección 3
        "0100", -- Dirección 4
        "0101", -- Dirección 5
        "0110", -- Dirección 6
        "0111", -- Dirección 7
        "1000", -- Dirección 8
        "1001", -- Dirección 9
        "1010", -- Dirección 10
        "1011", -- Dirección 11
        "1100", -- Dirección 12
        "1101", -- Dirección 13
        "1110", -- Dirección 14
        "1111"  -- Dirección 15
    );
begin
    data_out <= search (address, rom_array);
    
end architecture Behavioral;
