--Memoria de datos de un ciclo de ECG con ruido de lazo de tierra

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memoriaDatos is
    Port ( add  : in STD_LOGIC_VECTOR (5 downto 0);   --Direcci?n de memoria que se debe leer
           data : out STD_LOGIC_VECTOR (7 downto 0)); --Datos almacenado en la memoria
end memoriaDatos;

architecture Behavioral of memoriaDatos is
type memoriaSenial is array (0 to 40) of std_logic_vector(7 downto 0);

--Memoria de datos en complemento a 2 y normalizados entre -100 a 100
constant senial: memoriaSenial := (
                0  => x"30",
                1  => x"30",
                2  => x"30",
                3  => x"30",
                4  => x"30",
                5  => x"30",
                6  => x"30",
                7  => x"35",
                8  => x"3B",
                9  => x"21",
                10 => x"21",
                11 => x"1A",
                12 => x"13",
                13 => x"10",
                14 => x"10",
                15 => x"FD",
                16 => x"FD",
                17 => x"72",
                18 => x"19",
                19 => x"CF",
                20 => x"10",
                21 => x"10",
                22 => x"10",
                23 => x"12",
                24 => x"12",
                25 => x"12",
                26 => x"15",
                27 => x"1B",
                28 => x"53",
                29 => x"5B",
                30 => x"64",
                31 => x"6A",
                32 => x"72",
                33 => x"72",
                34 => x"65",
                35 => x"59",
                36 => x"4E",
                37 => x"47",
                38 => x"3F",
                39 => x"3F",
                40 => x"3F");
                
signal direccion: unsigned(5 downto 0);
                
begin

direccion <= unsigned(add);
data <= senial(to_integer(direccion));

end Behavioral;