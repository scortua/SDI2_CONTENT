library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divifreg is
    Port (CLK: in std_logic;
          divclk: out std_logic);
end divifreg;

architecture Behavioral of divifreg is

signal divisor_40k: integer range 0 to 1250;

signal div_freg_40k: std_logic := '0';

begin

ins_div_40k: process(clk)
    begin
        if(rising_edge(clk))then
            if (divisor_40k = 1250)then
                divisor_40k <= 0;
                div_freg_40k <= not div_freg_40k;
            else
                divisor_40k <= divisor_40k + 1;
            end if;
        end if;
end process;
divclk <= div_freg_40k;
end Behavioral;