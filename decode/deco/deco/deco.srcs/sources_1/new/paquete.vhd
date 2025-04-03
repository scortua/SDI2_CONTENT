----------------------------------------------------------------------------------
-- santiago cortes
-- tomas montañez
-- juan avella
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

--
package search_rom is

	--Declaración del tipo 1d
	type rom is array (natural range <>) of std_logic_vector(3 downto 0);
	
	component decodificador
    port (  
            entradas : in std_logic_vector(3 downto 0);
            salidas : out std_logic_vector(15 downto 0)
          );
    end component;

    component memory
        port (
            address : in std_logic_vector(15 downto 0); -- lugar de memoria
            data_out : out std_logic_vector(3 downto 0) -- sali
            );
    end component;

	   --Declaración de la función 
	   function search ( address: in std_logic_vector; rom :rom) return std_logic_vector ;
    end package;

--Cuerpo del paquete "operacionMatriz" con operaciones entre matrices
package body search_rom is
	function search ( address: in std_logic_vector; rom :rom) return std_logic_vector is
	variable posicion : integer := 0;
	begin
	
	    for i in 0 to rom'length - 1 loop
	       if address(i) = '1' then
	           posicion := i;
	       end if;
	    end loop;   
	    --posicion := to_integer(unsigned(address));
	 return rom (posicion);							
	end function;
end package body;


