----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.10.2025 15:10:13
-- Design Name: 
-- Module Name: fms_tb - Behavioral
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

entity fms_tb is
--  Port ( );
end fms_tb;

architecture Behavioral of fms_tb is

component fms is
 Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           START : in STD_LOGIC;
           ShiftCounter : in STD_LOGIC_VECTOR (3 downto 0);
          DONE: out STD_LOGIC;
          LoadData : out STD_LOGIC;
            nSYNC : out STD_LOGIC;
           enShift: out STD_LOGIC);
    end component;
    
    
   signal clk : STD_LOGIC;
   signal rst : STD_LOGIC;
   signal DONE :  STD_LOGIC;
   signal LoadData :  STD_LOGIC;
   signal START :  STD_LOGIC;
   signal nSYNC :  STD_LOGIC;
   signal enShift :  STD_LOGIC;
   signal ShiftCounter : STD_LOGIC_VECTOR (3 downto 0);

   
begin

UUT: fms
        port map ( clk => clk,
                   rst => rst,
                  DONE =>DONE,
                  LoadData=> LoadData,
                  START => START,
                  nSYNC => nSYNC,
                  enShift=> enshift,
                  shiftCounter=> ShiftCounter);
                  
    rst<='0', '1' after 500ns;
    START <= '0','1' after 1000ns,'0' after 4000ns ;
     ShiftCounter <= "1111" after 1300ns, "0000" after 3000ns; 
process

begin

clk <= '0';

wait for 500ns;

clk <= '1';

wait for 500ns;

end process;
                 

end Behavioral;