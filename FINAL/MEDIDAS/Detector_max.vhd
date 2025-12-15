----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.12.2025 10:09:07
-- Design Name: 
-- Module Name: Detector_max - Behavioral
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

entity Detector_max is
    Port ( DRDY : in STD_LOGIC;
           Dato : in STD_LOGIC_VECTOR (11 downto 0);
           en_cnt : out STD_LOGIC);
end Detector_max;

architecture Behavioral of Detector_max is

    -- PARÁMETROS UNIVERSALES (Para señales de amplitud ~2000)
    
    -- 1. Umbral de Inicio (TH_UP): 
    --    La señal debe superar 1200 para que empecemos a buscar un pico.
    --    Al ser alto, nos protege totalmente del ruido en la base.
    constant TH_UP : unsigned(11 downto 0) := to_unsigned(1200, 12);
    
    -- 2. Histéresis (HYST): 
    --    Confirmamos el pico cuando la señal cae 300 puntos desde el máximo encontrado.
    --    300 es mayor que el ruido observado (~150) pero captura bien la caída de las 3 señales.
    constant HYST : unsigned(11 downto 0) := to_unsigned(300, 12);
    
    -- 3. Umbral de Rearme (TH_DOWN): 
    --    El sistema se "apaga" hasta que la señal vuelve a bajar de 600.
    --    Evita dobles conteos en ondas anchas como la cuadrada.
    constant TH_DOWN : unsigned(11 downto 0) := to_unsigned(600, 12);

    -- MÁQUINA DE ESTADOS
    type state_type is (IDLE_LOW, TRACKING_RISE, WAITING_RESET);
    signal state : state_type := IDLE_LOW;

    signal curr_max : unsigned(11 downto 0) := (others => '0'); 
    signal max_hold : unsigned(11 downto 0) := (others => '0'); 

begin

process(DRDY)
    variable val_in : unsigned(11 downto 0);
begin
    if rising_edge(DRDY) then
        val_in := unsigned(Dato);
        
        -- Pulso por defecto a 0
        en_cnt <= '0';

        case state is
            -- ESTADO 1: ESPERANDO QUE LA SEÑAL SUBA
            when IDLE_LOW =>
                -- Si superamos el umbral alto, asumimos que viene un pico
                if val_in > TH_UP then
                    state <= TRACKING_RISE;
                    curr_max <= val_in; -- Empezamos a rastrear desde aquí
                end if;

            -- ESTADO 2: RASTREANDO EL PICO (SUBIDA)
            when TRACKING_RISE =>
                -- Si el valor sigue subiendo, actualizamos nuestro registro de máximo
                if val_in > curr_max then
                    curr_max <= val_in;
                
                -- Si el valor cae significativamente (Histéresis) respecto al máximo visto...
                -- (Usamos check de seguridad para no restar si curr_max < HYST)
                elsif (curr_max > HYST) and (val_in < (curr_max - HYST)) then
                    
                    -- ¡Pico Confirmado! (Justo en el flanco de bajada)
                    en_cnt <= '1';            -- Pulso de detección
                    max_hold <= curr_max;     -- Guardamos la amplitud real del pico
                    state <= WAITING_RESET;   -- Vamos a esperar a que la señal muera
                end if;

            -- ESTADO 3: ESPERANDO QUE LA SEÑAL BAJE (REARME)
            when WAITING_RESET =>
                -- Ignoramos todo hasta que la señal baje a casi cero (nivel seguro)
                if val_in < TH_DOWN then
                    state <= IDLE_LOW; -- Sistema listo para el siguiente ciclo
                end if;
                
        end case;

    end if;
end process;

end Behavioral;