----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2025 10:28:08
-- Design Name: 
-- Module Name: ShiftR_ADC_tb - Behavioral
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

entity ShiftR_ADC_tb is
--  Port ( );
end ShiftR_ADC_tb;

architecture Behavioral of ShiftR_ADC_tb is

component SR_ADC is           
       Port ( -- ENTRADAS
              clk    : in STD_LOGIC; -- señal de reloj (20 MHz)
              in_D1  : in STD_LOGIC; -- entrada dato 1 serie
              en_clk : in STD_LOGIC; -- habilita el reloj
               
              -- SALIDAS
              out_D1      : out STD_LOGIC_VECTOR (11 downto 0); -- salida dato 1 en bus
              Sft_Counter : out STD_LOGIC_VECTOR (3 downto 0)); -- contador de cambio
end component SR_ADC;

signal clk, in_D1, en_clk : STD_LOGIC;
signal out_D1 : STD_LOGIC_VECTOR (11 downto 0);
signal Sft_Counter : STD_LOGIC_VECTOR (3 downto 0);

begin
    UUT: SR_ADC port map( clk => clk,
                          in_D1 => in_D1,
                          en_clk => en_clk,
                          out_D1 => out_D1,
                          Sft_Counter => Sft_Counter);
    
    CLK_gen: process
    begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;
    
    in_D1 <= '1';
    
    en_clk <= '0', '1' after 33 ns;
    
    
    
end Behavioral;
