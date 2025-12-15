----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 15:59:33
-- Design Name: 
-- Module Name: fms - Behavioral
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

entity fms is
  Port (   clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           START : in STD_LOGIC;
           ShiftCounter : in STD_LOGIC_VECTOR (3 downto 0);
          DONE: out STD_LOGIC;
          LoadData : out STD_LOGIC;
            nSYNC : out STD_LOGIC;
           enShift: out STD_LOGIC);
end fms;

architecture Behavioral of fms is
  type estados is (SyncData, IDLE, SiftOut);
    signal e_act, e_sig : estados;
    signal counter : std_logic_vector(3 downto 0);
    
begin
   counter <= ShiftCounter;
   
  P_S_FSM: process (clk, rst)
    begin
       if rst = '0' then
            e_act <= IDLE;
        elsif rising_edge(clk) then
            e_act<= e_sig;
        end if;
    end process;
    
    process(e_act, START)
    begin
     
        enShift  <= '0';
        DONE     <= '0';
        LoadData <= '0';
        nSYNC    <= '1';  
       e_sig <= e_act;

        case e_act is
            when IDLE =>
                enShift  <= '0';
                DONE     <= '1';
                LoadData <= '1';
                nSYNC    <= '1';
                if START = '1' then
                   e_sig <= SiftOut;
                end if;

            when SiftOut =>
                enShift  <= '1';
                DONE     <= '0';
                LoadData <= '0';
                nSYNC    <= '0';
                if counter = "1111" then
                    e_sig <= SyncData;
                end if;

            when SyncData =>
                enShift  <= '0';
                DONE     <= '0';
                LoadData <= '0';
                nSYNC    <= '1';
              e_sig <= IDLE;

            when others =>
               e_sig <= IDLE;
        end case;
       end process;
end Behavioral;