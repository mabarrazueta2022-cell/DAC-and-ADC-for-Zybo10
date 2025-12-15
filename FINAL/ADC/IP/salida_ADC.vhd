----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2025 14:29:05
-- Design Name: 
-- Module Name: salida_ADC - Behavioral
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

entity salida_ADC is
    Port ( val_reg0 : in STD_LOGIC_VECTOR (31 downto 0);
           data : out STD_LOGIC_VECTOR (11 downto 0));
end salida_ADC;

architecture Behavioral of salida_ADC is

begin

    data <= val_reg0(11 downto 0);

end Behavioral;
