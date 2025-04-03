----------------------------------------------------------------------------------
-- santiago cortes
-- tomas montañez
-- juan andres abella
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity maquinaEstados is
    Port ( inRst			 : in STD_LOGIC; --Resetear el proceso    
		   inClk			 : in STD_LOGIC; --Reloj del sistema		   
		   in_num            : in std_logic_vector(1 downto 0); -- numero
		   in_Preset_conteo          : in std_logic; -- colocar estado
		   		   
		   out_conteo        : out std_logic_vector(1 downto 0)-- salida del downto
		   
		   ); 
		   		   		              
end maquinaEstados;

architecture Behavioral of maquinaEstados is

--Declaración de los estados
type estado is (E1, E2, E3, E4);

--Señales para recorrer la máquina de estados
signal eAct : estado;
signal eSig : estado;

signal CONTADOR : std_logic_vector(1 downto 0) := "00";

--Señales intermedias
signal salidas 	: std_logic_vector (1 downto 0);

--Señales auxiliares
--shared variable flancoInPieza : std_logic;

--Atributo de enumeración para el sintetizador
--attribute ENUM_ENCODING: string;
--attribute ENUM_ENCODING of estado: type is "00 01 10 11";

begin

------Código secuencial de la máquina------------------
    secuencial:
	process (inClk, inRst, in_preset_conteo, in_num)
	begin
		if (inRst = '1') then
			eAct <= E1;
		elsif (rising_edge(inClk)) then
		   if (in_preset_conteo = '1' and in_num = "00") then
	           eAct <= E1;
	       elsif (in_preset_conteo = '1' and in_num = "01") then
	           eAct <= E2;
	       elsif (in_preset_conteo = '1' and in_num = "10") then
	           eAct <= E3;
	       elsif (in_preset_conteo = '1' and in_num = "11") then
	           eAct <= E4;
	       else
	           eAct <= eSig;
	       end if;
		end if;
	end process;

------Código combinacional-----------------------------
	
	combinacional:
	process (eAct, in_preset_conteo)
	begin
		case eAct is
						--Estado 1
						when E1 =>
								salidas <= "00";
								if (in_preset_conteo = '0') then
									eSig <= E2;									
								else
									eSig <= E1;
								end if;
						
						--Estado 2
						when E2 =>
								salidas <= "01"; 
								if (in_preset_conteo = '0') then
									eSig <= E3;
								else
									eSig <= E2;
								end if;
						
						--Estado 3
						when E3 =>
								salidas <= "10"; 
								if (in_preset_conteo = '0') then
									eSig <= E4;
								else
									eSig <= E3;
								end if;
						
						--Estado 4
						when E4 =>
								salidas <= "11"; 
								if (in_preset_conteo = '0') then
									eSig <= E1;
								else
									eSig <= E4;
								end if;
						
		end case;
	end process;
	
out_conteo <= salidas;
				
end Behavioral;


