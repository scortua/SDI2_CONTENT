library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity DisplayController is
    Port (
        clk       : in  STD_LOGIC;        
        number_in : in  STD_LOGIC_VECTOR (7 downto 0);
        display   : out STD_LOGIC_VECTOR (6 downto 0);
        anode     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end DisplayController;

 

architecture Behavioral of DisplayController is
    signal counter    : unsigned(1 downto 0) := "00";
    signal digit_out  : unsigned(3 downto 0) := "0000";
    signal number_abs : unsigned(7 downto 0);
    signal negative   : STD_LOGIC := '0';
    signal divisor : integer range 0 to 100;
    signal reloj : std_logic:= '0';
    signal Q: STD_LOGIC_VECTOR(1 DOWNTO 0);
begin

process(Clk) --divisor
begin
    if (Clk'event and Clk='1') then
        if(divisor = 100)then
            divisor <= 0;
            reloj <= not reloj;
        else
            divisor <= divisor + 1;
        end if;
    end if;
end Process;

CONTADOR: PROCESS(reloj) --DEBE SER A 200 Hz
BEGIN
if reloj' event and reloj='0' then
    Q <= Q + "01";
end if;
END PROCESS CONTADOR;

reloj_ins:process(reloj)
    begin
    if rising_edge(reloj) then
            if counter = "00" then
                number_abs <= unsigned(number_in);
                negative <= number_in(7);
                counter <= "01";
            elsif counter = "01" then
                digit_out <= number_abs(3 downto 0);
                counter <= "10";
            elsif counter = "10" then
                digit_out <= number_abs(7 downto 4);
                counter <= "11";
            else
                digit_out <= "0000";
                counter <= "00";
            end if;
        end if;
end process;

 

process(digit_out, negative)
    begin
        case digit_out is
            when "0000" => display <= "1000000"; -- 0
            when "0001" => display <= "1111001"; -- 1
            when "0010" => display <= "0100100"; -- 2
            when "0011" => display <= "0110000"; -- 3
            when "0100" => display <= "0011001"; -- 4
            when "0101" => display <= "0010010"; -- 5
            when "0110" => display <= "0000010"; -- 6
            when "0111" => display <= "1111000"; -- 7
            when "1000" => display <= "0000000"; -- 8
            when "1001" => display <= "0010000"; -- 9

            when others => display <= "1000000"; -- Default to 0
        end case;

 

        if negative = '1' then
            anode <= "1110"; -- Turn on negative sign display
        else
            anode <= "0111" WHEN Q="00" ELSE
                     "1011" WHEN Q="01" ELSE
                     "1101" WHEN Q="10" ELSE
                     "1110";
           
        end if;
    end process;

 

end Behavioral;