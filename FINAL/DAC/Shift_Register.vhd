----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.10.2025 15:48:57
-- Design Name: 
-- Module Name: Shift_Register - Behavioral
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

entity Shift_Register is
    Port ( DATA1 : in STD_LOGIC_VECTOR (11 downto 0);
           LoadData : in STD_LOGIC;
           enShift : in STD_LOGIC;
           clk : in STD_LOGIC;
           ShiftCounter : out STD_LOGIC_VECTOR (3 downto 0);
           D1 : out  STD_LOGIC);
end Shift_Register;


architecture Behavioral of Shift_Register is

signal DATA : STD_LOGIC_VECTOR (15 downto 0);
 signal Counter :  unsigned (3 downto 0);
 
begin
    process(clk)
    begin
    if rising_edge(clk) then
    if LoadData = '1' then
           DATA(15 downto 12) <= "0000";
           DATA(11 downto 0) <= DATA1;
           Counter <= "0000";
    elsif enShift ='1' then
        D1<= DATA(15);
       DATA(15 downto 1) <= DATA (14 downto 0);
          Counter <= Counter +1;
       end if;
       end if;
    end process;
        
     ShiftCounter <= std_logic_vector(Counter);
            
    
   
     
                              
                          

                               

end Behavioral;