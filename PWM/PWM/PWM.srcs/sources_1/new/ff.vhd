----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2023 20:56:10
-- Design Name: 
-- Module Name: ff - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity flipflop is
    Port (out_port          :in std_logic_vector(7 downto 0);
          port_id           :in std_logic;
          write_read_strobe :in std_logic;
          clk               :in std_logic;
          output            :out std_logic_vector(7 downto 0):= "00000000");
end flipflop;

architecture Behavioral of flipflop is
signal s_and: std_logic;
begin
s_and <= port_id and write_read_strobe;
process(clk, port_id,out_port,write_read_strobe)
begin
    if (rising_edge(clk))then
        if(s_and = '1')then
            output <=out_port;  
        end if; 
    end if;
end process;

end Behavioral;
