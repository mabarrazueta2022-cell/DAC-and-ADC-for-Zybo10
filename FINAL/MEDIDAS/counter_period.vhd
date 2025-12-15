----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2025 10:28:58
-- Design Name: 
-- Module Name: counter_period - Behavioral
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

entity counter_period is 
port(
        clk_200    : in  std_logic;     -- reloj base (200 MHz recomendado)
        rst       : in  std_logic;     -- reset activo en bajo
        peak_in       : in  std_logic;     -- pulso desde detector de máximos
        period_counts : out std_logic_vector(31 downto 0)  -- cuentas del periodo
    );
end counter_period;

architecture Behavioral of counter_period is

signal count_internal : unsigned(31 downto 0) := (others => '0');    
-- Señales para sincronización
signal peak_sync_1    : std_logic := '0';
signal peak_sync_2    : std_logic := '0'; -- Usaremos esta como la señal "limpia"
signal peak_prev      : std_logic := '0';

begin

process(clk_200)
    begin
        if rising_edge(clk_200) then
            if rst = '0' then
                -- Resets...
                peak_sync_1 <= '0';
                peak_sync_2 <= '0';
                -- ... resto de resets
            else
                -- 1. ETAPA DE SINCRONIZACIÓN (Doble Flip-Flop)
                -- Esto protege contra la metaestabilidad
                peak_sync_1 <= peak_in;     -- Captura asíncrona
                peak_sync_2 <= peak_sync_1; -- Captura síncrona limpia

                -- 2. DETECTOR DE FLANCOS (Usando la señal ya sincronizada peak_sync_2)
                peak_prev <= peak_sync_2;

                if (peak_sync_2 = '1' and peak_prev = '0') then
                    -- Lógica de guardado de cuenta...
                    period_counts <= std_logic_vector(count_internal);
                    count_internal <= (others => '0');
                else
                    count_internal <= count_internal + 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
