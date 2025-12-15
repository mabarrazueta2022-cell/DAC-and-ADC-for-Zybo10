----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.10.2025 15:09:57
-- Design Name: 
-- Module Name: RAM_tb - Behavioral
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

entity RAM_tb is
Generic (
        d_width : integer:= 12;
        addr_width : integer:= 14);
--  Port ( );
end RAM_tb;

architecture Behavioral of RAM_tb is

component RAM is
    Generic (
        d_width : integer:= 12;
        addr_width : integer:= 14);
    Port ( clk : in STD_LOGIC;
           wr_ena : in STD_LOGIC;
           addr_rd : in STD_LOGIC_VECTOR (addr_width-1 downto 0);
           addr_wr : in STD_LOGIC_VECTOR (addr_width-1 downto 0);
           data_in : in STD_LOGIC_VECTOR (d_width-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (d_width-1 downto 0));
end component;

signal clk, wr_ena : std_logic;
signal addr_rd, addr_wr : std_logic_vector(addr_width-1 downto 0);
signal data_in, data_out : std_logic_vector(d_width-1 downto 0);

begin

UUT: RAM port map(clk=>clk,wr_ena=>wr_ena,addr_rd=>addr_rd,addr_wr=>addr_wr,data_in=>data_in,data_out=>data_out);
wr_ena <= '1';
data_in <= "111000111000","111111111111" after 100ns,"000000000000" after 300ns;
addr_wr <= "11001100110011";
addr_rd <= "11001100110011","00000000000000" after 500ns;

process
begin
clk <= '0';
wait for 5ns;
clk <= '1';
wait for 5ns;
end process;

end Behavioral;