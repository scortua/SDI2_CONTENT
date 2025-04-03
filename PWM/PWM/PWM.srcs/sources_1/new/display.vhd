library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.paquete.all;

 

entity VIS_DIN_4DIG is

    Port ( clk: IN STD_LOGIC;

           n : in std_logic_vector(7 downto 0);

           ANODS : out  STD_LOGIC_VECTOR (3 DOWNTO 0);

           SAL7SEG : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));

end VIS_DIN_4DIG;

 

architecture Behavioral of VIS_DIN_4DIG is

signal unidades_n: std_logic_vector(3 downto 0);

signal decenas_n: std_logic_vector(3 downto 0);

signal centenas_n: std_logic_vector(3 downto 0);

signal signo_n: std_logic_vector(3 downto 0);

SIGNAL BCD: STD_LOGIC_VECTOR (3 DOWNTO 0);

SIGNAL Q: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

signal divisor : integer range 0 to 100;

signal reloj : std_logic := '0';

 

begin

signo_n <= signo(n);
centenas_n <= centenas(n);
decenas_n <= decenas(n);
unidades_n <= unidades(n);

divisor_frecuencia: process(CLK) begin
    if (CLK'event and CLK = '1')then
        if (divisor = 100) then
            divisor <= 0;
            reloj <= not reloj;
         else
            divisor <= divisor + 1;
        end if;
    end if;
end process;

CONTADOR: PROCESS(reloj) --DEBE SER A 200 Hz

BEGIN

if reloj' event and reloj='0' then

    Q<=Q+1;

end if;

END PROCESS CONTADOR;

 

--mux

BCD  <=     signo_n WHEN Q="00" ELSE

            centenas_n WHEN Q="01" ELSE

            decenas_n WHEN Q="10" ELSE

            unidades_n;


ANODS<=    "0111" WHEN Q="00" ELSE

           "1011" WHEN Q="01" ELSE

           "1101" WHEN Q="10" ELSE

           "1110";


    SAL7SEG <=  "1000000" WHEN BCD="0000" ELSE --0

                "1111001" WHEN BCD="0001" ELSE --1

                "0100100" WHEN BCD="0010" ELSE --2

                "0110000" WHEN BCD="0011" ELSE --3

                "0011001" WHEN BCD="0100" ELSE --4

                "0010010" WHEN BCD="0101" ELSE --5 

                "0000010" WHEN BCD="0110" ELSE --6

                "1111000" WHEN BCD="0111" ELSE --7

                "0000000" WHEN BCD="1000" ELSE --8

                "0010000" WHEN BCD="1001" ELSE --9


                "0111111" WHEN BCD="1111" ELSE --negativo

                "1111111" WHEN BCD="1110" ELSE --positivo

                "0001001";
       

end Behavioral;