-------------------------------------------------------------------------------------------
-- santiago cortes
-- tomas monta�ez
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
    -- Definici�n del tipo "rom_array" como un array de 16 elementos de 8 bits

    constant rom_array: rom (0 to 15) :=(
        -- Contenido de la memoria ROM
        "0000", -- Direcci�n 0
        "0001", -- Direcci�n 1
        "0010", -- Direcci�n 2
        "0011", -- Direcci�n 3
        "0100", -- Direcci�n 4
        "0101", -- Direcci�n 5
        "0110", -- Direcci�n 6
        "0111", -- Direcci�n 7
        "1000", -- Direcci�n 8
        "1001", -- Direcci�n 9
        "1010", -- Direcci�n 10
        "1011", -- Direcci�n 11
        "1100", -- Direcci�n 12
        "1101", -- Direcci�n 13
        "1110", -- Direcci�n 14
        "1111"  -- Direcci�n 15
    );
begin
    data_out <= search (address, rom_array);
    
end architecture Behavioral;
