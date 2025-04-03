library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package IP_RAM is

-- memoria ram llamada del bloque de ip
Component dist_mem_gen_0 is
    port (  A: in std_logic_vector(4 downto 0);
            d: in std_logic_vector(7 downto 0);
            spo: out std_logic_vector(7 downto 0);
            we: in std_logic;
            clk: in std_logic);
end component;

end package;
