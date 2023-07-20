module middleware_tb ();

`define period 950

  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 32;
  parameter MAIN_FRE = 100;  //unit MHz
  reg                  clk = 0;
  reg                  rstn = 0;
  reg [DATA_WIDTH-1:0] data = 0;
  reg [ADDR_WIDTH-1:0] addr = 0;

  always begin
    #5 clk = ~clk;
  end

  initial begin
#`period
    #30 rstn = 1;
  end


  //AXI-Stream Master Port
  wire [63 : 0] M_AXIS_TDATA;
  wire          M_AXIS_TVALID;
  wire           M_AXIS_TREADY;
  wire          M_AXIS_TLAST;

  //AXI-Stream Slave Port
  wire  [63 : 0] S_AXIS_TDATA;
  wire           S_AXIS_TVALID;
  wire          S_AXIS_TREADY;
  wire           S_AXIS_TLAST;

reg TX_Start=0;
  middleware #(
      .C_S_AXI_DATA_WIDTH(32),
      .C_S_AXI_ADDR_WIDTH(9)
  ) u_middleware (
      //ports
      //ports
      .clk          (clk),
      .rstn         (rstn),
      .M_AXIS_TDATA (M_AXIS_TDATA),
      .M_AXIS_TVALID(M_AXIS_TVALID),
      .M_AXIS_TREADY(M_AXIS_TREADY),
      .M_AXIS_TLAST (M_AXIS_TLAST),
      .S_AXIS_TDATA (S_AXIS_TDATA),
      .S_AXIS_TVALID(S_AXIS_TVALID),
      .S_AXIS_TREADY(S_AXIS_TREADY),
      .S_AXIS_TLAST (S_AXIS_TLAST),

	  .i_TX_Start(TX_Start),

      .S_AXI_AWADDR (),
      .S_AXI_AWPROT (),
      .S_AXI_AWVALID(),
      .S_AXI_AWREADY(),
      .S_AXI_WDATA  (),
      .S_AXI_WSTRB  (),
      .S_AXI_WVALID (),
      .S_AXI_WREADY (),
      .S_AXI_BRESP  (),
      .S_AXI_BVALID (),
      .S_AXI_BREADY (),
      .S_AXI_ARADDR (),
      .S_AXI_ARPROT (),
      .S_AXI_ARVALID(),
      .S_AXI_ARREADY(),
      .S_AXI_RDATA  (),
      .S_AXI_RRESP  (),
      .S_AXI_RVALID (),
      .S_AXI_RREADY ()


  );
wire [63:0] m_axis_tdata_pcie;
 top u_top(
.clk(clk),
.rst_n(rstn),
.mode(2'd1),
.chicun(2'd1),
.s_axis0_tvalid(M_AXIS_TVALID),
.s_axis0_tdata(M_AXIS_TDATA),
.s_axis0_tready(M_AXIS_TREADY),
.m_axis_tready_pcie(S_AXIS_TREADY),
.m_axis_tvalid_pcie(S_AXIS_TVALID),
.m_axis_tdata_pcie(S_AXIS_TDATA)
    );



  initial begin
	#`period
    #30 #10 
//	M_AXIS_TREADY = 0;
	TX_Start=1;
     //M_AXIS_TREADY = 1;
//#10 S_AXIS_TVALID=1;

// S_AXIS_TDATA=1;
// #10
// S_AXIS_TDATA = 2;
// #10
// S_AXIS_TDATA = 3;
// #10
// S_AXIS_TDATA = 4;

// S_AXIS_TVALID=0;

// #10
// S_AXIS_TDATA = 5;
// #10
// S_AXIS_TDATA = 6;
// #10
// S_AXIS_TDATA = 7;
// #10
// S_AXIS_TDATA = 8;

// S_AXIS_TVALID=1;
// #10
// S_AXIS_TDATA = 9;
// #10
// S_AXIS_TDATA = 10;
// #10
// S_AXIS_TDATA = 11;
// #10
// S_AXIS_TDATA = 12;
  end

endmodule  //TOP

