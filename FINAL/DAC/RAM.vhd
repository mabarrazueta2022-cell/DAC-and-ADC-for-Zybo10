----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.10.2025 17:50:31
-- Design Name: 
-- Module Name: RAM - Behavioral
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

entity RAM is
    Generic (
        d_width : integer:= 12;
        addr_width : integer:= 14);
    Port ( clk : in STD_LOGIC;
           wr_ena : in STD_LOGIC;
           addr_rd : in STD_LOGIC_VECTOR (addr_width-1 downto 0);
           addr_wr : in STD_LOGIC_VECTOR (addr_width-1 downto 0);
           data_in : in STD_LOGIC_VECTOR (d_width-1 downto 0);
           data_out : out STD_LOGIC_VECTOR (d_width-1 downto 0));
end RAM;

architecture Behavioral of RAM is
    type memory is array((2**addr_width)-1 downto 0) of std_logic_vector(d_width-1 downto 0);
    signal ram: memory;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (wr_ena='1') then
                ram(to_integer(unsigned(addr_wr))) <= data_in;
            end if;
            data_out <= ram(to_integer(unsigned(addr_rd)));
        end if;
    end process;
end Behavioral;