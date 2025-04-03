library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

package PAQUETE  is 
    component kcpsm6                    --Declaracion del componente KCPSM6.
      generic( hwbuild                 : std_logic_vector(7 downto 0)  := X"00";
               interrupt_vector        : std_logic_vector(11 downto 0) := X"3FF";
               scratch_pad_memory_size : integer := 64);
      port( address        : out std_logic_vector(11 downto 0);
            instruction    : in  std_logic_vector(17 downto 0);
            bram_enable    : out std_logic;
            in_port        : in  std_logic_vector(7 downto 0);
            out_port       : out std_logic_vector(7 downto 0);
            port_id        : out std_logic_vector(7 downto 0);
            write_strobe   : out std_logic;
            k_write_strobe : out std_logic;
            read_strobe    : out std_logic;
            interrupt      : in  std_logic;
            interrupt_ack  : out std_logic;
            sleep          : in  std_logic;
            reset          : in  std_logic;
            clk            : in  std_logic);
   end component;
   
   component memoriaDatos is
   
   Port ( add  : in STD_LOGIC_VECTOR (5 downto 0);   --Direcci?n de memoria que se debe leer
          data : out STD_LOGIC_VECTOR (7 downto 0)); --Datos almacenado en la memoria
           
   end component;
    
    component divifreg is
    Port (CLK: in std_logic;
          divclk: out std_logic);
    end component;
    
    component pwm is
      generic(             C_FAMILY : string := "S6"; 
                  C_RAM_SIZE_KWORDS : integer := 1;
               C_JTAG_LOADER_ENABLE : integer := 0);
      Port (      address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                      rdl : out std_logic;                    
                      clk : in std_logic);
    end component;
      
    component flipflop is
    Port (out_port          :in std_logic_vector(7 downto 0);
          port_id           :in std_logic;
          write_read_strobe :in std_logic;
          clk               :in std_logic;
          output            :out std_logic_vector(7 downto 0));
    end component;

    component mux is
    Port (i0    : in std_logic_vector(7 downto 0);
          i1    : in std_logic_vector(7 downto 0);
          sel   : in std_logic; 
          y     : out std_logic_vector(7 downto 0));
    end component;

    component mem_porc is
    Port (a: in std_logic_vector(5 downto 0);
          spo: out std_logic_vector(7 downto 0));
    end component;
    
    component VIS_DIN_4DIG is

    Port ( clk: IN STD_LOGIC;

           n : in std_logic_vector(7 downto 0);

           ANODS : out  STD_LOGIC_VECTOR (3 DOWNTO 0);

           SAL7SEG : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));

    end component;

    function signo (n: in std_logic_vector(7 downto 0)) return std_logic_vector;
    function centenas(n: std_logic_vector(7 downto 0))return std_logic_vector;
    function decenas(n: std_logic_vector(7 downto 0))return std_logic_vector;
    function unidades(n: std_logic_vector(7 downto 0))return std_logic_vector;
end package;
    package body paquete is
        function signo (n: in std_logic_vector(7 downto 0)) return std_logic_vector is
        variable numero: integer;
        begin
        numero := TO_INTEGER(signed(n));
        if (numero >= 0)then
            return "1110";
        else
            return "1111";
        end if;
        end function;
        function centenas(n: std_logic_vector(7 downto 0))return std_logic_vector is
        variable numero: integer;
        begin
        numero := TO_INTEGER(signed(n));
        if (numero >= 0)then
            if (numero >= 100) then
                return "0001";
            else
                return "0000";
            end if;
        else
            if (numero <= -100)then
                return "0001";
            else
                return "0000";
            end if;
        end if;
        end function;
        function decenas(n: std_logic_vector(7 downto 0))return std_logic_vector is
        variable numero, n_centenas, temporal: integer;
        begin
        numero := TO_INTEGER(signed(n));
        if (numero >= 0)then
            if (numero >= 100) then
                n_centenas := -100;
            else
                n_centenas := 0;
            end if;
        else
            if (numero <= -100)then
                n_centenas := 100;
            else
                n_centenas := 0;
            end if;
        end if;
        if (numero >= 0)then
            temporal := numero + n_centenas;
        else
            temporal := -(numero + n_centenas);
        end if;
        if (temporal >= 90)then
            return "1001";
        elsif (temporal >= 80) then
            return "1000";
        elsif (temporal >= 70) then
            return "0111";
        elsif (temporal >= 60) then
            return "0110";
        elsif (temporal >= 50) then
            return "0101";
        elsif (temporal >= 40) then
            return "0100";
        elsif (temporal >= 30) then
            return "0011";
        elsif (temporal >= 20) then
            return "0010";
        elsif (temporal >= 10) then
            return "0001";
        else
            return "0000";
        end if;
        end function;
        function unidades(n: std_logic_vector(7 downto 0))return std_logic_vector is
        variable numero, n_centenas, temporal, n_decenas ,unidades: integer;
        begin
        numero := TO_INTEGER(signed(n));
        if (numero >= 0)then
            if (numero >= 100) then
                n_centenas := -100;
            else
                n_centenas := 0;
            end if;
        else
            if (numero <= -100)then
                n_centenas := 100;
            else
                n_centenas := 0;
            end if;
        end if;
        if (numero >= 0)then
            temporal := numero + n_centenas;
        else
            temporal := -(numero + n_centenas);
        end if;
        if (temporal >= 90)then
            n_decenas := 90;
        elsif (temporal >= 80) then
            n_decenas := 80;
        elsif (temporal >= 70) then
            n_decenas := 70;
        elsif (temporal >= 60) then
            n_decenas := 60;
        elsif (temporal >= 50) then
            n_decenas := 50;
        elsif (temporal >= 40) then
            n_decenas := 40;
        elsif (temporal >= 30) then
            n_decenas := 30;
        elsif (temporal >= 20) then
            n_decenas := 20;
        elsif (temporal >= 10) then
            n_decenas := 10;
        else
            n_decenas := 0;
        end if;
        unidades := temporal - n_decenas;
        if (unidades = 9)then
            return "1001";
        elsif (unidades = 8)then
            return "1000";
        elsif (unidades = 7)then
            return "0111";
        elsif (unidades = 6)then
            return "0110";
        elsif (unidades = 5)then
            return "0101";
        elsif (unidades = 4)then
            return "0100";
        elsif (unidades = 3)then
            return "0011";
        elsif (unidades = 2)then
            return "0010";
        elsif (unidades = 1)then
            return "0001";
        else
            return "0000";
        end if;
        end function;
    end package body;
