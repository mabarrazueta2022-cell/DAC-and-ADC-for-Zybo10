library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADC_Controller_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface ADC_AXI
		C_ADC_AXI_DATA_WIDTH	: integer	:= 32;
		C_ADC_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        DATA : in std_logic_vector(11 downto 0);
        DRDY : in std_logic;
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface ADC_AXI
		adc_axi_aclk	: in std_logic;
		adc_axi_aresetn	: in std_logic;
		adc_axi_awaddr	: in std_logic_vector(C_ADC_AXI_ADDR_WIDTH-1 downto 0);
		adc_axi_awprot	: in std_logic_vector(2 downto 0);
		adc_axi_awvalid	: in std_logic;
		adc_axi_awready	: out std_logic;
		adc_axi_wdata	: in std_logic_vector(C_ADC_AXI_DATA_WIDTH-1 downto 0);
		adc_axi_wstrb	: in std_logic_vector((C_ADC_AXI_DATA_WIDTH/8)-1 downto 0);
		adc_axi_wvalid	: in std_logic;
		adc_axi_wready	: out std_logic;
		adc_axi_bresp	: out std_logic_vector(1 downto 0);
		adc_axi_bvalid	: out std_logic;
		adc_axi_bready	: in std_logic;
		adc_axi_araddr	: in std_logic_vector(C_ADC_AXI_ADDR_WIDTH-1 downto 0);
		adc_axi_arprot	: in std_logic_vector(2 downto 0);
		adc_axi_arvalid	: in std_logic;
		adc_axi_arready	: out std_logic;
		adc_axi_rdata	: out std_logic_vector(C_ADC_AXI_DATA_WIDTH-1 downto 0);
		adc_axi_rresp	: out std_logic_vector(1 downto 0);
		adc_axi_rvalid	: out std_logic;
		adc_axi_rready	: in std_logic
	);
end ADC_Controller_v1_0;

architecture arch_imp of ADC_Controller_v1_0 is

	-- component declaration
	component ADC_Controller_v1_0_ADC_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		val_reg0 : in STD_LOGIC_VECTOR(12-1 downto 0);
		val_reg1 : in STD_LOGIC;--_VECTOR(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component ADC_Controller_v1_0_ADC_AXI;

    signal reg0 : std_logic_vector(31 downto 0);
    signal reg1 : std_logic_vector(31 downto 0);
    
begin

-- Instantiation of Axi Bus Interface ADC_AXI
ADC_Controller_v1_0_ADC_AXI_inst : ADC_Controller_v1_0_ADC_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_ADC_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_ADC_AXI_ADDR_WIDTH
	)
	port map (
	    val_reg0 => DATA,
	    val_reg1 => DRDY,
		S_AXI_ACLK	=> adc_axi_aclk,
		S_AXI_ARESETN	=> adc_axi_aresetn,
		S_AXI_AWADDR	=> adc_axi_awaddr,
		S_AXI_AWPROT	=> adc_axi_awprot,
		S_AXI_AWVALID	=> adc_axi_awvalid,
		S_AXI_AWREADY	=> adc_axi_awready,
		S_AXI_WDATA	=> adc_axi_wdata,
		S_AXI_WSTRB	=> adc_axi_wstrb,
		S_AXI_WVALID	=> adc_axi_wvalid,
		S_AXI_WREADY	=> adc_axi_wready,
		S_AXI_BRESP	=> adc_axi_bresp,
		S_AXI_BVALID	=> adc_axi_bvalid,
		S_AXI_BREADY	=> adc_axi_bready,
		S_AXI_ARADDR	=> adc_axi_araddr,
		S_AXI_ARPROT	=> adc_axi_arprot,
		S_AXI_ARVALID	=> adc_axi_arvalid,
		S_AXI_ARREADY	=> adc_axi_arready,
		S_AXI_RDATA	=> adc_axi_rdata,
		S_AXI_RRESP	=> adc_axi_rresp,
		S_AXI_RVALID	=> adc_axi_rvalid,
		S_AXI_RREADY	=> adc_axi_rready
	);

	-- Add user logic here
--        reg0(11 downto 0) <= DATA;
--        reg0(31 downto 12) <= (others=>'0');
--        reg1(0) <= DRDY;
--        reg1(31 downto 1) <= (others=>'0');
	-- User logic ends

end arch_imp;
