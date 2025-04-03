----------------------------------------------------------------------------------
-- VISUALIZACION DINÁMICA DE 8 DIGITOS HEXADECIMALES
----------------------------------------------------------------------------------
-- grupo good   sdi--
--       ECI       --
--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity visualizador is
    port (
        clk : in std_logic; -- reloj de nexys
        data_in : in std_logic_vector(4 downto 0); -- dato entrada, numero a poner en displays
        anodo : out std_logic_vector(7 downto 0); -- anodos de la fpga
        segmento : out std_logic_vector(6 downto 0) -- 7 segmentos de display
    );
end visualizador;

architecture Behavioral of visualizador is

    signal contador : integer range 0 to 7 := 0;
	-- se utiliza para encender los displays secuencialmente, contador se utiliza para seleccionar cada anodo en un tiempo que vea la persona
    signal display_1, display_2 : std_logic_vector(6 downto 0) := (others => '0'); -- displays para mostrar el numero

    signal divisor 	: integer range 0 to 125000;

    signal reloj 	: std_logic;

begin
    
    process(clk)
    begin
    if (Clk'event and Clk='1') then
        if(divisor = 125000)then
            divisor <= 0;
            reloj <= not reloj;
        else
            divisor <= divisor + 1;
        end if;
    end if;
    end process;

    process (reloj)
    begin
        if rising_edge(reloj) then
            contador <= contador + 1;
            case contador is
                when 0 =>
                    anodo <= "11111110";
                    segmento <= display_1;
                when 1 =>
                    anodo <= "11111101";
                    segmento <= display_2;
                when others =>
                    anodo <= "11111111";
                    segmento <= (others => '0');
            end case;
        end if;

    end process;
    
    process (data_in)
    begin
        case data_in is
            when "00000" =>
                display_1 <= "1000000"; -- 0
                display_2 <= "1000000";
            when "00001" =>
                display_1 <= "1111001"; -- 1
                display_2 <= "1000000";
            when "00010" =>
                display_1 <= "0100100"; -- 2
                display_2 <= "1000000";
            when "00011" =>
                display_1 <= "0110000"; -- 3
                display_2 <= "1000000";
            when "00100" =>
                display_1 <= "0011001"; -- 4
                display_2 <= "1000000";
            when "00101" =>
                display_1 <= "0010010"; -- 5
                display_2 <= "1000000";
            when "00110" =>
                display_1 <= "0000010"; -- 6
                display_2 <= "1000000";
            when "00111" =>
                display_1 <= "1111000"; -- 7
                display_2 <= "1000000";
            when "01000" =>
                display_1 <= "0000000"; -- 8
                display_2 <= "1000000";
            when "01001" =>
                display_1 <= "0010000"; -- 9
                display_2 <= "1000000";
		when "01010" =>
		    display_1 <= "1000000"; -- 10
                display_2 <= "1111001";
		when "01011" =>
		    display_1 <= "1111001"; -- 11
                display_2 <= "1111001";
		when "01100" =>
		    display_1 <= "0100100"; -- 12
                display_2 <= "1111001";
		when "01101" =>
		    display_1 <= "0110000"; -- 13
                display_2 <= "1111001";
		when "01110" =>
		    display_1 <= "0011001"; -- 14
                display_2 <= "1111001";
		when "01111" =>
		    display_1 <= "0010010"; -- 15
                display_2 <= "1111001";
		when "10000" =>
		    display_1 <= "0000010"; -- 16
                display_2 <= "1111001";
		when "10001" =>
		    display_1 <= "1111000"; -- 17
                display_2 <= "1111001";
		when "10010" =>
		    display_1 <= "0000000"; -- 18
                display_2 <= "1111001";
		when "10011" =>
		    display_1 <= "0010000"; -- 19
                display_2 <= "1111001";
		when "10100" =>
		    display_1 <= "1000000"; -- 20
                display_2 <= "0100100";
		when "10101" =>
		    display_1 <= "1111001"; -- 21
                display_2 <= "0100100";
		when "10110" =>
		    display_1 <= "0100100"; -- 22
                display_2 <= "0100100";
		when "10111" =>
		    display_1 <= "0110000"; -- 23
                display_2 <= "0100100";
		when "11000" =>
		    display_1 <= "0011001"; -- 24
                display_2 <= "0100100";
		when "11001" =>
		    display_1 <= "0010010"; -- 25
                display_2 <= "0100100";
		when "11010" =>
		    display_1 <= "0000010"; -- 26
                display_2 <= "0100100";
		when "11011" =>
		    display_1 <= "1111000"; -- 27
                display_2 <= "0100100";
		when "11100" =>
		    display_1 <= "0000000"; -- 28
                display_2 <= "0100100";
		when "11101" =>
		    display_1 <= "0010000"; -- 29
                display_2 <= "0100100";
		when "11110" =>
		    display_1 <= "1000000"; -- 30
                display_2 <= "0110000";
		when "11111" =>
		    display_1 <= "1111001"; -- 31
                display_2 <= "0110000";
            
            --when others =>
              --  display_1 <= "1111111";
                --display_2 <= "1111111";
        end case;
    end process;
end Behavioral;
