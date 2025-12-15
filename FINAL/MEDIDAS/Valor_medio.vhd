----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2025 19:03:59
-- Design Name: 
-- Module Name: Acumulaor_Periodo - Behavioral
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

entity Acumulador_Periodo is
    Port ( 
        clk         : in STD_LOGIC;                      -- Reloj del sistema
        rst         : in STD_LOGIC;                      -- Reset activo bajo
        DRDY        : in STD_LOGIC;                      -- Señal Data Ready del ADC
        peak_in     : in STD_LOGIC;                      -- Señal 'en_cnt' que viene del Detector_max
        Dato        : in STD_LOGIC_VECTOR (11 downto 0); -- Dato crudo del ADC (12 bits)
        
        -- Salidas hacia Vitis (Registros AXI)
        sum_out     : out STD_LOGIC_VECTOR (31 downto 0); -- Suma total del periodo (32 bits)
        count_out   : out STD_LOGIC_VECTOR (31 downto 0) -- Nº de muestras (32 bits)
    );
end Acumulador_Periodo;

architecture Behavioral of Acumulador_Periodo is

    -- Registros internos de acumulación (32 bits para todo)
    signal acc_internal   : unsigned(31 downto 0) := (others => '0');
    signal count_internal : unsigned(31 downto 0) := (others => '0');
    
    -- Detección de flanco de DRDY (para sincronizar con reloj rápido)
    signal drdy_reg       : std_logic := '0';
    signal drdy_rising    : std_logic;

begin

    -- Detector de flanco de subida de DRDY
    -- Esto es crucial si tu CLK (ej. 100MHz) es más rápido que el DRDY del ADC
    drdy_rising <= '1' when (DRDY = '1' and drdy_reg = '0') else '0';

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                -- Reset general
                acc_internal   <= (others => '0');
                count_internal <= (others => '0');
                sum_out        <= (others => '0');
                count_out      <= (others => '0');
                drdy_reg       <= '0';
            else
                -- Registro de historia para detectar flancos
                drdy_reg <= DRDY;
               

                -- Lógica principal: Solo actuamos cuando llega un DATO NUEVO
                if drdy_rising = '1' then
                    
                    -- CASO 1: FIN DE PERIODO (Detectamos pico justo ahora)
                    -- 'peak_in' viene del detector que también va con DRDY, 
                    -- así que estarán alineados.
                    if peak_in = '1' then
                        -- A) Volcamos los resultados del periodo que acaba de terminar
                        sum_out    <= std_logic_vector(acc_internal);
                        count_out  <= std_logic_vector(count_internal);
                        
                        -- B) Iniciamos el NUEVO periodo
                        -- IMPORTANTE: El acumulador empieza con el Dato actual, no con 0.
                        -- El contador empieza en 1.
                        acc_internal   <= resize(unsigned(Dato), 32);
                        count_internal <= to_unsigned(1, 32);
                        
                    -- CASO 2: MUESTRA NORMAL (Dentro del periodo)
                    else
                        -- Acumulamos el dato (resize de 12 a 32 bits)
                        acc_internal   <= acc_internal + resize(unsigned(Dato), 32);
                        -- Incrementamos contador
                        count_internal <= count_internal + 1;
                    end if;
                    
                end if;
            end if;
        end if;
    end process;

end Behavioral;