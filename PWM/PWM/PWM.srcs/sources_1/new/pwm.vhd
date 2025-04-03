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

entity pwm is
    Port (address: in std_logic_vector(11 downto 0);
          instruction: out std_logic_vector(17 downto 0);
          enable: in std_logic;
          clk: in std_logic;
          rdl: out std_logic);
end pwm;

architecture Behavioral of pwm is
COMPONENT dist_mem_gen_1
  PORT (
    a : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    spo : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;
begin
rdl <= '0';
your_instance_name : dist_mem_gen_1
  PORT MAP (
    a=> address(5 downto 0),
    spo => instruction
  );
end Behavioral;