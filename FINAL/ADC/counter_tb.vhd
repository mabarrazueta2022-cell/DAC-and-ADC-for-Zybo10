----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2025 16:48:36
-- Design Name: 
-- Module Name: counter_tb - Behavioral
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

entity counter_tb is
--  Port ( );
end counter_tb;

architecture Behavioral of counter_tb is

component counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           fcuenta : out STD_LOGIC;
           cuenta : out STD_LOGIC_VECTOR (7 downto 0);
           N : in unsigned(7 downto 0);
           en_cnt : in STD_LOGIC);
end component;

signal clk : STD_LOGIC;
signal rst : STD_LOGIC;
signal fcuenta : STD_LOGIC;
signal cuenta : STD_LOGIC_VECTOR (7 downto 0);
signal N : unsigned(7 downto 0);
signal en_cnt : STD_LOGIC;

begin

UUT : counter port map(clk=>clk, rst=>rst, fcuenta=>fcuenta, cuenta=>cuenta, N=>N, en_cnt=>en_cnt);

en_cnt<='0', '1' after 100ns;
rst<='1', '0' after 200ns;
N <= "00000011";

process
    begin
        clk<='0';
        wait for 10ns;
        clk<='1';
        wait for 10ns;
end process;

end Behavioral;
