----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.10.2025 14:05:48
-- Design Name: 
-- Module Name: detector_flanco_tb - Behavioral
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

entity detector_flanco_tb is
--  Port ( );
end detector_flanco_tb;

architecture Behavioral of detector_flanco_tb is
component detector_flanco is
    Port ( btn : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           salida : out STD_LOGIC);
end component;

signal btn,clk,rst,salida : std_logic;

begin

UUT: detector_flanco port map(clk=>clk,rst=>rst,btn=>btn,salida=>salida);
rst <= '1', '0' after 100ns;
btn <= '0', '1' after 205ns, '0' after 305ns, '1' after 505ns;

process
begin
clk <= '0';
wait for 5ns;
clk <= '1';
wait for 5ns;
end process;

end Behavioral;