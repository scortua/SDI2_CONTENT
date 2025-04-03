---------------------------------------------------------------------------------
-- santiago cortes 
-- tomas montañes
-- juan andres abella
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    port (
          Sin : in std_logic_vector (2 downto 0); -- selectores
          
          inA : in std_logic_vector (3 downto 0); -- numero a
          inB : in std_logic_vector (3 downto 0); -- numero b
          
          CIN : in std_logic; -- carry in
          cout : out std_logic; -- carry out
          overflow : out std_logic; -- sobreflujo
          outY : out std_logic_vector (3 downto 0) -- salida mux
          
          );
end ALU;
    
architecture Behavioral of ALU is

signal carry : std_logic_vector (4 downto 0);
signal outsuma : std_logic_vector (3 downto 0);
signal outcout : std_logic;

signal carry1 : std_logic_vector (4 downto 0);
signal outsuma1 : std_logic_vector (3 downto 0);
signal outcout1 : std_logic;

--signal outAmenos : std_logic_vector (3 downto 0);

signal carry2 : std_logic_vector (4 downto 0);
signal outsuma2 : std_logic_vector (3 downto 0);
signal outcout2 : std_logic;

signal AandB : std_logic_vector (3 downto 0);

signal AorB : std_logic_vector (3 downto 0);

signal nota : std_logic_vector (3 downto 0);

signal carry4 : std_logic_vector(4 downto 0); 
signal desplazadoi : std_logic_vector (3 downto 0);
signal outcout4 : std_logic;

signal carry3 : std_logic_vector(4 downto 0);
signal outsuma3 : std_logic_vector (3 downto 0);
signal outcout3 : std_logic;

signal carry5: std_logic_vector(4 downto 0);
signal outsuma5 : std_logic_vector (3 downto 0);
signal outcout5 : std_logic;

signal AnandB : std_logic_vector (3 downto 0);

signal AxorB : std_logic_vector (3 downto 0);

signal AnorB : std_logic_vector (3 downto 0);

signal desplazadoD : std_logic_vector (3 downto 0);

signal sobreflujo: std_logic;
signal sobreflujo1: std_logic;
signal sobreflujo2: std_logic;
signal sobreflujo3: std_logic;
signal sobreflujo4: std_logic;

begin

carry(0) <= cin; -- Acarreo del 1 sumador
sumador:
   for i in 0 to 3 generate
		signal semiSuma : std_logic;
		begin
         semiSuma <= inA(i) xor inB(i);
			outSuma(i) <= semiSuma xor carry(i);
			carry(i+1) <= (inA(i) and inB(i)) or (semiSuma and carry(i));
   end generate;
outCout <= carry(4); -- salida de carreo 1 sumado
sobreflujo <= (not inA(3) and not inB(3) and outsuma(3))or(inA(3) and inB(3) and (not outsuma(3)));

carry1(0) <= cin; -- carry entrada 2
sumadorComplemento:
   for i in 0 to 3 generate
		signal semiSuma1 : std_logic;
		begin
         semiSuma1 <= inA(i) xor (not inB(i));
			outSuma1(i) <= semiSuma1 xor carry1(i);
			carry1(i+1) <= (inA(i) and (not inB(i))) or (semiSuma1 and carry1(i));
   end generate;
outCout1 <= carry1(4); -- carry salida 2
sobreflujo1 <= (not inA(3) and inB(3) and outsuma1(3))or(inA(3) and  (not inB(3)) and (not outsuma1(3)));

carry2(0) <= cin; -- carry entrada 3
amenos1 :
    for i in 0 to 3 generate
		signal semiSuma : std_logic;
		begin
         semiSuma <= inA(i) xor '1';
			outSuma2(i) <= semiSuma xor carry2(i);
			carry2(i+1) <= inA(i) or (semiSuma and carry2(i));
   end generate;
outCout2 <= carry2(4); -- carry salida 3
sobreflujo2 <= (not inA(3) and not inB(3) and outsuma2(3))or(inA(3) and inB(3) and (not outsuma2(3)));

carry3(0) <= cin; -- carry entrada 4
mostrarnumeroA:
   for i in 0 to 3 generate
		signal semiSuma : std_logic;
		begin
         semiSuma <= inA(i) ;
			outSuma3(i) <= semiSuma xor carry3(i);
			carry3(i+1) <= (semiSuma and carry3(i));
   end generate;
outCout3 <= carry3(4); -- carry salida 4
sobreflujo3 <= (not inA(3) and not inB(3) and outsuma3(3))or(inA(3) and inB(3) and (not outsuma3(3)));

AB :
    AandB <= inA and inB;

AoB :
    AorB <= inA or inB;
    
nA :
    nota <= not inA;

carry4(0) <= cin; -- carry entrada 5
desplazarizquierda: 
  for i in 0 to 3 generate
		signal semiSuma : std_logic;
		begin
         semiSuma <= inA(i) xor inA(i);
			desplazadoi(i) <= semiSuma xor carry4(i);
			carry4(i+1) <= (inA(i) and inA(i)) or (semiSuma and carry4(i));
   end generate;
outCout4 <= inA(3); -- carry salida 5

carry5(0) <= '1'; -- carry entrada 6
BmenosA:
   for i in 0 to 3 generate
		signal semiSuma : std_logic;
		begin
         semiSuma <= inB(i)xor (Not inA(i));
			outSuma5(i) <= semiSuma xor carry5(i);
			carry5(i+1) <= ((not inA(i)) and inB(i)) or (semiSuma and carry5(i));
   end generate;
outCout5 <= carry5(4); -- carry salida 6
sobreflujo4 <= (not inA(3) and not inB(3) and outsuma5(3))or(inA(3) and inB(3) and (not outsuma5(3)));


ANB:
    AnandB <= inA Nand inB;
    
    
AequisorB:
    AxorB <= inA xor inB;
    
    
ANoRsB:
    AnorB <= inA nor inB; 
    
    
desplazarderecha:

desplazadoD(0) <= inA(1);
desplazadoD(1) <= inA(2);
desplazadoD(2) <= inA(3);
desplazadoD(3) <= '0';

mux_salida:

outY <= outSuma     when Sin = "000" else
        outSuma1    when Sin = "001" else
        outSuma3    when Sin = "010" else
        outSuma2    when (Sin = "011" and CIN = '0')else
        AandB       when (Sin = "100" and CIN = '0')else
        AorB        when (Sin = "101" and CIN = '0')else
        nota        when (Sin = "110" and CIN = '0')else
        desplazadoi when (Sin = "111" and CIN = '0')else
        outSuma5    when (Sin = "011" and CIN = '1')else
        AnandB      when (Sin = "100" and CIN = '1')else
        AxorB       when (Sin = "101" and CIN = '1')else
        AnorB       when (Sin = "110" and CIN = '1')else
        desplazadoD when (Sin = "111" and CIN = '1')else
        "0101";
        
mux_de_acarreos:
        
cout <= outcout     when (Sin = "000" )else
        outcout1    when (Sin = "001" )else
        outcout2    when (Sin = "011" and CIN = '0' )else
        outcout3    when (Sin = "010" and CIN = '1')else
        outcout4    when (Sin = "111" and CIN = '0')else
        outcout5    when (Sin = "011" and CIN = '0')else
        inA(0)      when ((Sin = "011" and CIN = '1')or(Sin = "111" and CIN = '1'))else
        '0';

mux_de_overflow:

overflow <= sobreflujo  when sin = "000" else
            sobreflujo1 when sin = "001" else
            sobreflujo2 when (Sin = "011" and CIN = '0')  else
            sobreflujo3 when (Sin = "011" and CIN = '1')  else
            sobreflujo4 when (Sin = "011" and CIN = '0')  else
            '0';
        
end Behavioral;
