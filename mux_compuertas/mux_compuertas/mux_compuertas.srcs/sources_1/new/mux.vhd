----------------------------------------------------------------------------------
-- Santiago Cortes Tovar
-- Juan Andres Abella
-- Tomas Felipe Montañez

-- Generacion de mux con compuertas logicas
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port ( a_in : in std_logic_vector(3 downto 0); -- las entradas de 4 bits
           b_in : in std_logic_vector(3 downto 0);
           c_in : in std_logic_vector(3 downto 0);
           d_in : in std_logic_vector(3 downto 0);
           
           selector : in std_logic_vector(1 downto 0); -- seleccionar entrada
           hab : in std_logic; -- habilitador
           
           Y_out : out std_logic_vector(3 downto 0)); -- salida del mux
end mux;

architecture Behavioral of mux is

begin

y_out(0) <= ((not selector(1) and not selector(0) and a_in(0)) or 
         (not selector(1) and selector(0) and b_in(0)) or 
         (selector(1) and not selector(0) and c_in(0)) or 
         (selector(1) and selector(0) and d_in(0))) and  hab;

y_out(1) <= ((not selector(1) and not selector(0) and a_in(1)) or 
         (not selector(1) and selector(0) and b_in(1)) or 
         (selector(1) and not selector(0) and c_in(1)) or 
         (selector(1) and selector(0) and d_in(1))) and  hab;
         
y_out(2) <= ((not selector(1) and not selector(0) and a_in(2)) or 
         (not selector(1) and selector(0) and b_in(2)) or 
         (selector(1) and not selector(0) and c_in(2)) or 
         (selector(1) and selector(0) and d_in(2))) and  hab;
         
y_out(3) <= ((not selector(1) and not selector(0) and a_in(3)) or 
         (not selector(1) and selector(0) and b_in(3)) or 
         (selector(1) and not selector(0) and c_in(3)) or 
         (selector(1) and selector(0) and d_in(3))) and  hab;


end Behavioral;
