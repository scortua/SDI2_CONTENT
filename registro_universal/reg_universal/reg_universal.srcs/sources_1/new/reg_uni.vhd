----------------------------------------------------------------------------------
-- juan abella
-- tomas montañez
-- santiago cortes
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity reg_uni is
    Port (  selector : in std_logic_vector(1 downto 0); -- selectors
            
            --DSR : in std_logic; -- desplazamiento a la derecha
            --DSL : in std_logic; -- desplazamiento a la izquierda
           
            load : in std_logic; -- habilitador de reloj
            clock : in std_logic; -- reloj
            
            reg_in : in std_logic_vector(5 downto 0); -- entrada de bits
            
            reg_out : inout std_logic_vector(3 downto 0); -- salida de los registros
            led : out std_logic
             );
end reg_uni;

architecture behavioral of reg_uni is

signal clk : integer range 0 to 200000000; -- velocidad del reloj
signal reloj: std_logic; -- reloj

signal data: std_logic_vector(4 downto 1); -- señal por si
signal DSR : std_logic; -- desplazamiento a la derecha
signal DSL : std_logic; -- desplazamiento a la izquierda

begin

led <= reloj;
-- divisor de señal para el reloj
Vreloj: process(Clock) --divisor 3

begin 
    if (Clock'event and Clock='1') then
        if(clk = 100000000)then
           clk <= 0;
           reloj <= not reloj;
        else
           clk <= clk + 1;
        end if;
    end if;
end Process;

registro: 
process (reloj)
BEGIN
    if load = '1' then
        if rising_edge(reloj) then
            if selector = "00" then
                -- mantener el numero cuando s = 00
                data <= data;            
            elsif selector = "01" then
                -- desplazar a la derecha y colocar dsr en el bit mas significativo
                data <= DSR & data(4 downto 2);            
            elsif selector = "10" then
                -- desplazar a la izquierda y coloca el dsl en el bit menos significativo
                data <= data(3 downto 1) & DSL;            
            elsif selector = "11" then
                -- cargar el numero en paralelo
                data <= reg_in(4 downto 1);
                DSR <= reg_in(5);
                DSL <= reg_in(0);
            end if;
        end if;
    end if;    
end process registro;

reg_out <= data;


end behavioral;
