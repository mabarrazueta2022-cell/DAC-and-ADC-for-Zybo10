library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Medidas_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI_Medidas
		C_S00_AXI_Medidas_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_Medidas_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        period_counts : in std_logic_vector(31 downto 0);
        sum_out : in std_logic_vector(31 downto 0);
        count_out : in std_logic_vector(31 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI_Medidas
		s00_axi_medidas_aclk	: in std_logic;
		s00_axi_medidas_aresetn	: in std_logic;
		s00_axi_medidas_awaddr	: in std_logic_vector(C_S00_AXI_Medidas_ADDR_WIDTH-1 downto 0);
		s00_axi_medidas_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_medidas_awvalid	: in std_logic;
		s00_axi_medidas_awready	: out std_logic;
		s00_axi_medidas_wdata	: in std_logic_vector(C_S00_AXI_Medidas_DATA_WIDTH-1 downto 0);
		s00_axi_medidas_wstrb	: in std_logic_vector((C_S00_AXI_Medidas_DATA_WIDTH/8)-1 downto 0);
		s00_axi_medidas_wvalid	: in std_logic;
		s00_axi_medidas_wready	: out std_logic;
		s00_axi_medidas_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_medidas_bvalid	: out std_logic;
		s00_axi_medidas_bready	: in std_logic;
		s00_axi_medidas_araddr	: in std_logic_vector(C_S00_AXI_Medidas_ADDR_WIDTH-1 downto 0);
		s00_axi_medidas_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_medidas_arvalid	: in std_logic;
		s00_axi_medidas_arready	: out std_logic;
		s00_axi_medidas_rdata	: out std_logic_vector(C_S00_AXI_Medidas_DATA_WIDTH-1 downto 0);
		s00_axi_medidas_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_medidas_rvalid	: out std_logic;
		s00_axi_medidas_rready	: in std_logic
	);
end Medidas_v1_0;

architecture arch_imp of Medidas_v1_0 is

	-- component declaration
	component Medidas_v1_0_S00_AXI_Medidas is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		val_reg0 : in std_logic_vector(31 downto 0);
		val_reg1 : in std_logic_vector(31 downto 0);
		val_reg2 : in std_logic_vector(31 downto 0);
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
	end component Medidas_v1_0_S00_AXI_Medidas;
	
	signal reg0 : std_logic_vector(31 downto 0);
    signal reg1 : std_logic_vector(31 downto 0);
    signal reg2 : std_logic_vector(31 downto 0);

begin

-- Instantiation of Axi Bus Interface S00_AXI_Medidas
Medidas_v1_0_S00_AXI_Medidas_inst : Medidas_v1_0_S00_AXI_Medidas
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_Medidas_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_Medidas_ADDR_WIDTH
	)
	port map (
	    val_reg0 => period_counts,
	    val_reg1 => sum_out,
	    val_reg2 => count_out,
		S_AXI_ACLK	=> s00_axi_medidas_aclk,
		S_AXI_ARESETN	=> s00_axi_medidas_aresetn,
		S_AXI_AWADDR	=> s00_axi_medidas_awaddr,
		S_AXI_AWPROT	=> s00_axi_medidas_awprot,
		S_AXI_AWVALID	=> s00_axi_medidas_awvalid,
		S_AXI_AWREADY	=> s00_axi_medidas_awready,
		S_AXI_WDATA	=> s00_axi_medidas_wdata,
		S_AXI_WSTRB	=> s00_axi_medidas_wstrb,
		S_AXI_WVALID	=> s00_axi_medidas_wvalid,
		S_AXI_WREADY	=> s00_axi_medidas_wready,
		S_AXI_BRESP	=> s00_axi_medidas_bresp,
		S_AXI_BVALID	=> s00_axi_medidas_bvalid,
		S_AXI_BREADY	=> s00_axi_medidas_bready,
		S_AXI_ARADDR	=> s00_axi_medidas_araddr,
		S_AXI_ARPROT	=> s00_axi_medidas_arprot,
		S_AXI_ARVALID	=> s00_axi_medidas_arvalid,
		S_AXI_ARREADY	=> s00_axi_medidas_arready,
		S_AXI_RDATA	=> s00_axi_medidas_rdata,
		S_AXI_RRESP	=> s00_axi_medidas_rresp,
		S_AXI_RVALID	=> s00_axi_medidas_rvalid,
		S_AXI_RREADY	=> s00_axi_medidas_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
