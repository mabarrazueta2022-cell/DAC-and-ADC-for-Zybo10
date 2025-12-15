----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2025 13:49:12
-- Design Name: 
-- Module Name: ADC_sinAXI - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADC_sinAXI is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           data_in : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (11 downto 0));
end ADC_sinAXI;

architecture Behavioral of ADC_sinAXI is

component prescaler is
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           DIV : in unsigned(3 downto 0);
           clk_out : out STD_LOGIC);
end component;

component FSM_ADC is
  Port (   clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           START : in STD_LOGIC;
           cntData : in STD_LOGIC_VECTOR (3 downto 0);
           DRDY: out STD_LOGIC;
           CS : out STD_LOGIC;
           en_cnt : out STD_LOGIC);
end component;

component SR_ADC is           
       Port ( -- ENTRADAS
              clk    : in STD_LOGIC; -- señal de reloj (20 MHz)
              in_D1  : in STD_LOGIC; -- entrada dato 1 serie
              en_clk : in STD_LOGIC; -- habilita el reloj
               
              -- SALIDAS
              out_D1      : out STD_LOGIC_VECTOR (11 downto 0); -- salida dato 1 en bus
              Sft_Counter : out STD_LOGIC_VECTOR (3 downto 0)); -- contador de cambio
end component;

-- ==============================================================
    -- SEÑALES INTERNAS (Cables de interconexión)
    -- ==============================================================
    
    -- Señal de reloj de 20MHz generada por el prescaler
    signal clk_20MHz_int : std_logic;
    
    -- Señales de control entre FSM y ShiftRegister
    signal enable_sr     : std_logic;                     -- Cable de FSM(en_cnt) -> SR(en_clk)
    signal counter_bits  : std_logic_vector(3 downto 0);  -- Cable de SR(Sft_Counter) -> FSM(cntData)
    
    -- Datos
    signal adc_data_12   : std_logic_vector(11 downto 0); -- Salida de 12 bits del SR
    
    -- Señales de estado (No tienen puerto de salida en tu entity principal, 
    -- pero la FSM las genera, así que las dejamos internas o "open")
    signal cs_internal   : std_logic; 
    signal drdy_internal : std_logic;

    -- Constante para dividir 100MHz a 20MHz (División por 5)
    constant DIV_5       : unsigned(3 downto 0) := "0101"; 

begin

    -- ==============================================================
    -- 1. INSTANCIA DEL PRESCALER (Generador de Reloj)
    -- Entrada: 100 MHz | Salida: 20 MHz
    -- ==============================================================
    inst_prescaler: prescaler
    Port map ( 
        clk_in  => clk,           -- Reloj principal (100 MHz)
        rst     => rst,
        clk_en  => '1',           -- Siempre habilitado
        DIV     => DIV_5,         -- Constante "0101" (5)
        clk_out => clk_20MHz_int  -- Señal interna resultante (20 MHz)
    );

    -- ==============================================================
    -- 2. INSTANCIA DE LA FSM (Control)
    -- Funciona con el reloj rápido (100 MHz) para controlar la lógica
    -- ==============================================================
    inst_fsm: FSM_ADC
    Port map ( 
        clk     => clk,           -- Usa reloj de 100 MHz
        rst     => rst,
        START   => start,
        cntData => counter_bits,  -- Lee cuántos bits lleva el SR
        DRDY    => drdy_internal, 
        CS      => cs_internal,   -- Chip Select (normalmente iría a un puerto de salida)
        en_cnt  => enable_sr      -- Ordena al SR que empiece a desplazar
    );

    -- ==============================================================
    -- 3. INSTANCIA DEL SHIFT REGISTER (Adquisición de datos)
    -- Funciona con el reloj lento (20 MHz) sincronizado con el ADC
    -- ==============================================================
    inst_sr: SR_ADC
    Port map ( 
        clk         => clk_20MHz_int, -- Usa el reloj lento generado
        in_D1       => data_in,       -- Entrada serie (bit que viene del ADC)
        en_clk      => enable_sr,     -- Habilitación que viene de la FSM
        out_D1      => adc_data_12,   -- Resultado paralelo de 12 bits
        Sft_Counter => counter_bits   -- Cuenta actual de bits desplazados
    );

    -- ==============================================================
    -- ASIGNACIÓN DE SALIDAS
    -- ==============================================================
    
    -- Tu salida final es de 16 bits, pero el ADC (SR) da 12 bits.
    -- Rellenamos con ceros los 4 bits superiores y ponemos el dato en los inferiores.
    data_out <= adc_data_12;

end Behavioral;
