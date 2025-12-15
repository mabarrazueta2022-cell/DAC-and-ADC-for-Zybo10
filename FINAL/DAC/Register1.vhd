----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.10.2025 17:42:27
-- Design Name: 
-- Module Name: Register - Behavioral
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

entity Register1 is
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           enCnt : in STD_LOGIC;
           START : out STD_LOGIC);
end Register1;

architecture Behavioral of Register1 is

signal btn_rg1 : std_logic :='0';
signal btn_rg2 : std_logic;

begin

    detecta_flanco : process(rst,clk_in)
    begin
    if rst='0' then
        START<='0';
        btn_rg1<='0';
        btn_rg2<='0';
     elsif rising_edge(clk_in) then
        btn_rg1<=enCnt;
        btn_rg2<=btn_rg1;
        
         START<= btn_rg1 and not btn_rg2;
        
    end if;
    
    end process;

end Behavioral;