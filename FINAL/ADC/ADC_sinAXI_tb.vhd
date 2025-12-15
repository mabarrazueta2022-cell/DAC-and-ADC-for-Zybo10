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

entity ADC_sinAXI_tb is
--  Port ( );
end ADC_sinAXI_tb;

architecture Behavioral of ADC_sinAXI_tb is

component ADC_sinAXI is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           data_in : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal clk_tb : std_logic;
signal rst_tb : std_logic;
signal start_tb : std_logic;
signal data_in_tb : std_logic;

signal data_out_tb : std_logic_vector(11 downto 0) := (others=>'0');

begin

UUT: ADC_sinAXI Port Map (
          clk => clk_tb,
          rst => rst_tb,
          start => start_tb,
          data_in => data_in_tb,
          data_out => data_out_tb
        );

rst_tb <= '1', '0' after 20ns;
start_tb <= '0', '1' after 100ns;
data_in_tb <= '1';

clk_process : process
    begin
        clk_tb <= '0';
        wait for 10ns;
        clk_tb <= '1';
        wait for 10ns;
    end process;     

end Behavioral;
