----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.10.2025 13:54:25
-- Design Name: 
-- Module Name: detector_flanco - Behavioral
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

entity detector_flanco is
    Port ( DONE : in STD_LOGIC;
           clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           enCnt : out STD_LOGIC);
end detector_flanco;

architecture Behavioral of detector_flanco is

signal btn_rg1 : std_logic :='0';
signal btn_rg2 : std_logic;

begin

    detecta_flanco : process(rst,clk_in)
    begin
    if rst='0' then
        enCnt<='0';
        btn_rg1<='0';
        btn_rg2<='0';
     elsif rising_edge(clk_in) then
        btn_rg1<=DONE;
        btn_rg2<=btn_rg1;
        
         enCnt<= btn_rg1 and not btn_rg2;
        
    end if;
    
    end process;
       
end Behavioral;