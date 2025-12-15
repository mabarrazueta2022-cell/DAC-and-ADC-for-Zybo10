----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2025 18:25:00
-- Design Name: 
-- Module Name: FSM_ADC_tb - Behavioral
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

entity FSM_ADC_tb is
--  Port ( );
end FSM_ADC_tb;

architecture Behavioral of FSM_ADC_tb is

component FSM_ADC is
  Port (   clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           START : in STD_LOGIC;
           cntData : in STD_LOGIC_VECTOR (3 downto 0);
           DRDY: out STD_LOGIC;
           CS : out STD_LOGIC;
           en_cnt : out STD_LOGIC);
end component;

signal clk_tb : std_logic;
signal rst_tb : std_logic;
signal START_tb : std_logic;
signal cntData_tb : std_logic_vector(3 downto 0);

signal DRDY_tb : std_logic;
signal CS_tb : std_logic;
signal en_cnt_tb : std_logic;

begin

uut: FSM_ADC Port Map (
          clk => clk_tb,
          rst => rst_tb,
          START => START_tb,
          cntData => cntData_tb,
          DRDY => DRDY_tb,
          CS => CS_tb,
          en_cnt => en_cnt_tb
        );

rst_tb <= '1', '0' after 20ns;
START_tb <= '0', '1' after 100ns;
cntData_tb <= "0000", "1111" after 500ns;

clk_process : process
    begin
        clk_tb <= '0';
        wait for 10ns;
        clk_tb <= '1';
        wait for 10ns;
    end process;     

end Behavioral;
