----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.10.2025 17:27:44
-- Design Name: 
-- Module Name: Counter - Behavioral
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

entity Counter is
 
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           enCnt : in STD_LOGIC;
           addr_rd : out STD_LOGIC_VECTOR (13 downto 0));
end Counter;

architecture Behavioral of Counter is

    signal cuenta_bcd : unsigned (13 downto 0);
    signal ini: std_logic;
    
begin

P_conta: process (clk_in, rst)
 begin
   if rst = '0' then
     cuenta_bcd <= (others => '0');
   elsif rising_edge(clk_in) then
   if enCnt = '1' then
        cuenta_bcd <= cuenta_bcd + 1;
      end if;
    end if;
 end process;
 
 addr_rd<=std_logic_vector(cuenta_bcd);
 
end Behavioral;
