------------------------------------------------------------------------------
-- santiago cortes
-- juan abella
-- tomas montañez
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    port (
        clk: in std_logic;                  -- reloj de la FPGA
        
        in_out_enable: in std_logic;        -- habilitador d esalidas
        in_write_enable: in std_logic;      -- habilitador de escritura en ram
        in_chip_enable : in std_logic;      -- habilitador del chip o sea la memoria
        
        in_address: in unsigned(4 downto 0);-- posicion de la memoria
        
        data_in: in unsigned(7 downto 0);   -- informacion de entrada
        data_out: out unsigned(7 downto 0)  -- informacion de 
    );
end entity ram;

architecture behavioral of ram is

    type ram_type is array(0 to 31) of unsigned(7 downto 0); -- memoria ram de 32x8
    signal ram: ram_type;                                    -- señal de la memoria
    
begin
    
    memoria_ram:
    process(clk)
    
    begin
    
        if in_chip_enable = '0' then
        
            if rising_edge(clk) then
        
                if in_out_enable = '0' then
                    data_out <= ram(to_integer(in_address));
                end if;
            
                if in_write_enable = '0' then
                    ram(to_integer(in_address)) <= data_in;
                end if;
            
            end if;
        end if;
        
    end process memoria_ram;
    
end architecture behavioral;
