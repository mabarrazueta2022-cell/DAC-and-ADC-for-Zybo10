----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2025 15:52:43
-- Design Name: 
-- Module Name: prescaler - Behavioral
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

entity prescaler is
    Port ( clk_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           DIV : in unsigned(4 downto 0);
           clk_out : out STD_LOGIC);
end prescaler;

architecture Behavioral of prescaler is

signal count   : unsigned(15 downto 0) := (others => '0');
signal clk_reg : std_logic := '0';

begin

    process(clk_in, rst)
    begin
        if rst = '0' then
            count   <= (others => '0');
            clk_reg <= '0';

        elsif rising_edge(clk_in) then
            if clk_en = '1' then
                if count = DIV - 1 then
                    count <= (others => '0');
                else
                    count <= count + 1;
                end if;
                if count < (DIV / 2) then
                    clk_reg <= '1';
                else
                    clk_reg <= '0';
                end if;                
            end if;
        end if;
    end process;

    clk_out <= clk_reg;
        
end Behavioral;
