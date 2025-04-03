----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.05.2023 23:37:12
-- Design Name: 
-- Module Name: mem_porc - Behavioral
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

entity mem_porc is
    Port (a: in std_logic_vector(5 downto 0);
          spo: out std_logic_vector(7 downto 0));
end mem_porc;

architecture Behavioral of mem_porc is
COMPONENT dist_mem_gen_0
  PORT (
    a : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;
begin
magnitudes : dist_mem_gen_0
  PORT MAP (
    a => a,
    spo => spo
  );

end Behavioral;
