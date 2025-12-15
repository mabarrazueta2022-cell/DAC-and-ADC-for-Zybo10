----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 15:20:09
-- Design Name: 
-- Module Name: prescaler_tb - Behavioral
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

entity prescaler_tb is
--  Port ( );
end prescaler_tb;

architecture Behavioral of prescaler_tb is

component prescaler is

  Port (   clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_DIV : out STD_LOGIC);
end component;

signal clk_in : STD_LOGIC;
signal clk_DIV : STD_LOGIC;
 signal rst : STD_LOGIC;
begin

  UUT: prescaler
        port map ( clk_in => clk_in,
                    clk_DIV => clk_DIV,
                   rst => rst);
                   
           rst<='0', '1' after 500ns;
           
    process

begin


clk_in <= '0';

wait for 20 ns;

clk_in <= '1';

wait for 20 ns;

end process;

end Behavioral;