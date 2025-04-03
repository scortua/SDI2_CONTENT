----------------------------------------------------------------------------------
-- tomas montañez
-- santiago cortes
-- juan abella
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    -- librerias comunes de vhdl

use work.IP_RAM.all;            -- libreria creada previamente

entity IPRAM is
    port (  a: in std_logic_vector(4 downto 0);     -- address o posicion de memoria single
            d: in std_logic_vector(7 downto 0);     -- data in information
            spo: out std_logic_vector(7 downto 0);  -- data out 
            we: in std_logic;                       -- whrite enable
            clk: in std_logic);                     -- clock
end IPRAM;

architecture Behavioral of IPRAM is

begin

-- componente de la memoria ram
-- aqui llamamos la ip de la ram que hay en el catalogo, debe tener las mismas instancias que la ip del catalogo
ram: dist_mem_gen_0 port map( a => a, d => d, spo => spo, we => we, clk => clk);
    
end Behavioral;
