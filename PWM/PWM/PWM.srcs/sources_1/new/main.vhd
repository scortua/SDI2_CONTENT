----------------------------------------------------------------------------------

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use work.paquete.all;


entity main is
    Port (led_pwm           :out std_logic_vector(7 downto 0);
          anodos_display    :out std_logic_vector(3 downto 0);
          clk               :in std_logic;
          cpu_reset         :in std_logic;
          otros_anods         :out std_logic_vector(3 downto 0);
          leds_display      :out std_logic_vector(6 downto 0));
end main;

architecture Behavioral of main is

signal s_clk_div        : std_logic;

signal datos_pico_out   : std_logic_vector(7 downto 0);

signal datos_pico_in    : std_logic_vector(7 downto 0);

signal s_write_strobe   : std_logic;

signal s_read_strobe    : std_logic;

signal out_mem_porc     : std_logic_vector(7 downto 0);

signal out_mem_magn     : std_logic_vector(7 downto 0);

signal datos_in         : std_logic_vector(7 downto 0);

signal sal_ff_in        : std_logic_vector(7 downto 0);

signal instrucciones    : std_logic_vector(17 downto 0);

signal n_instruccion    : std_logic_vector(11 downto 0);

signal bram_enable      : std_logic;

signal in_port          : std_logic_vector(7 downto 0);

signal out_port         : std_logic_vector(7 downto 0);

signal port_id          : std_logic_vector(7 downto 0);

signal k_write_strobe   : std_logic;

signal interrupt        : std_logic;

signal interrupt_ack    : std_logic;

signal kcpsm6_sleep     : std_logic;

signal kcpsm6_reset     : std_logic;

signal rdl              : std_logic;

signal address_mem      : std_logic_vector(7 downto 0);

signal numero_ancho     : std_logic_vector(7 downto 0);

begin

kcpsm6_sleep <= '0';

kcpsm6_reset <= cpu_reset or rdl;

interrupt <= interrupt_ack;

div_frecuencia      : divifreg port map(CLK => clk, divclk => s_clk_div);

mem_datos           : memoriadatos port map(add => address_mem(5 downto 0), data => out_mem_magn);

memoria_porc        : mem_porc port map(a => address_mem(5 downto 0), spo => out_mem_porc);

mux_entrada         : mux port map(i0 => out_mem_porc, i1 => out_mem_magn, sel => port_id(0), y => datos_in);

procesador          : kcpsm6
                            generic map(hwbuild                 => X"00",
                                        interrupt_vector        => X"3FF",
                                        scratch_pad_memory_size => 64)   
                            port map (in_port => sal_ff_in, instruction => instrucciones, address => n_instruccion,bram_enable => bram_enable, port_id => port_id, write_strobe => s_write_strobe, k_write_strobe => k_write_strobe, out_port => datos_pico_out, read_strobe => s_read_strobe, interrupt => interrupt, interrupt_ack => interrupt_ack, sleep => kcpsm6_sleep, reset => kcpsm6_reset, clk => s_clk_div);

mem_prog            : pwm 
                            generic map(C_FAMILY             => "7S",
                                        C_RAM_SIZE_KWORDS    => 2,
                                        C_JTAG_LOADER_ENABLE => 1)
                            port map(address => n_instruccion, instruction => instrucciones, enable => bram_enable, clk => s_clk_div, rdl => rdl);

ff_in               : flipflop port map(out_port => datos_in, port_id => '1', write_read_strobe => s_read_strobe, clk => s_clk_div, output => sal_ff_in);

ff_pwm              : flipflop port map(out_port => datos_pico_out, port_id => port_id(0), write_read_strobe => k_write_strobe, clk => s_clk_div, output => led_pwm);

ff_display          : flipflop port map(out_port => datos_pico_out, port_id => port_id(1), write_read_strobe => s_write_strobe, clk => s_clk_div,  output => numero_ancho);

ff_address          : flipflop port map(out_port => datos_pico_out, port_id => port_id(2), write_read_strobe => s_write_strobe, clk => s_clk_div, output => address_mem);

ins_display         : VIS_DIN_4DIG port map(clk => s_clk_div, n => numero_ancho, anods => anodos_display, sal7seg => leds_display);

otros_anods <= "1111";

end Behavioral;
