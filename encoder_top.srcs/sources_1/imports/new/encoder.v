`timescale 1ns / 1ps



module encoder(
input   wire    clk,
input   wire    rst_n,
input   wire    [1:0]chicun,
input   wire    [1:0]mode,
input   wire    s0_axis_tvalid,
output  wire     s0_axis_tready,
input   wire    [511:0]s0_axis_tdata,

input   wire    m0_axis_tready,
output  wire    m0_axis_tvalid,
output   wire    [511:0]m0_axis_tdata,
//256bit weikuan
input   wire    s1_axis_tvalid,
output  wire    s1_axis_tready,
input   wire    [255:0]s1_axis_tdata,

input   wire    m1_axis_tready,
output  wire    m1_axis_tvalid,
output   wire    [255:0]m1_axis_tdata,
//128bit weikuan
input   wire    s2_axis_tvalid,
output  wire    s2_axis_tready,
input   wire    [127:0]s2_axis_tdata,

input   wire    m2_axis_tready,
output  wire    m2_axis_tvalid,
output   wire    [127:0]m2_axis_tdata
);
// always@(*)begin
//   if(mode == 0)begin
//       s00_axis_tvalid= s0_axis_tvalid;
//       s00_axis_tready=s0_axis_tready;
//   end
// end
reg    s00_axis_tvalid;
reg    s00_axis_tready;
wire    m00_axis_tvalid;
wire    m00_axis_tready;
wire    [31:0]m00_axis_tdata;
wire    [511:0]s00_axis_tdata;
//assign s0_axis_tready = m00_axis_tready;
wire    i_rdy;//output信号定义时候写错信号名了
//写到组合逻辑控制里详细见always@（*）
//assign s00_axis_tvalid = s0_axis_tvalid & (mode == 0);
assign s00_axis_tdata = {s0_axis_tdata[31:0],s0_axis_tdata[63:32],s0_axis_tdata[95:64],s0_axis_tdata[127:96],s0_axis_tdata[159:128],s0_axis_tdata[191:160],s0_axis_tdata[223:192],s0_axis_tdata[255:224],s0_axis_tdata[287:256],s0_axis_tdata[319:288],s0_axis_tdata[351:320],s0_axis_tdata[383:352],s0_axis_tdata[415:384],s0_axis_tdata[447:416],s0_axis_tdata[479:448],s0_axis_tdata[511:480]};
//写到组合逻辑控制里详细见always@（*）
//assign m00_axis_tready=(mode==0)?i_rdy:0;
ax4_convert u1_axi_convert_512_32 (
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s0_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s0_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s00_axis_tdata),    // input wire [511 : 0] s_axis_tdata
  .m_axis_tvalid(m00_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(i_rdy&mode==0),  // input wire m_axis_tready
  .m_axis_tdata(m00_axis_tdata)    // output wire [31 : 0] m_axis_tdata
);    

//wire    s10_axis_tvalid;
//wire    s10_axis_tready;
wire    m10_axis_tvalid;
//wire    m10_axis_tready;
wire    [31:0]m10_axis_tdata;
wire    [255:0]s10_axis_tdata;

//assign s10_axis_tvalid = s1_axis_tvalid & (mode == 1);
//assign s10_axis_tdata =  {s1_axis_tdata[31:0],s1_axis_tdata[63:32],s1_axis_tdata[95:64],s1_axis_tdata[127:96],s1_axis_tdata[159:128],s1_axis_tdata[191:160],s1_axis_tdata[223:192],s1_axis_tdata[255:224]};
axi_convert_256_32 u2_axi_convert_255_32 (
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s1_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s1_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s1_axis_tdata),    // input wire [255 : 0] s_axis_tdata
  .m_axis_tvalid(m10_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(i_rdy&mode==1),  // input wire m_axis_tready
  .m_axis_tdata(m10_axis_tdata)    // output wire [31 : 0] m_axis_tdata
);    
wire    s20_axis_tvalid;
wire    s20_axis_tready;
wire    m20_axis_tvalid;
//wire    m20_axis_tready;
wire    [31:0]m20_axis_tdata;
wire    [127:0]s20_axis_tdata;
//assign s2_axis_tready = i_rdy&mode==2;
//assign s20_axis_tvalid = s2_axis_tvalid & (mode == 2);
//assign s20_axis_tdata = {s2_axis_tdata[31:0],s2_axis_tdata[63:32],s2_axis_tdata[95:64],s2_axis_tdata[127:96]};
axi_convert128_32 u3_axi_convert128_32 (
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s2_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s2_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s2_axis_tdata),    // input wire [127 : 0] s_axis_tdata
  .m_axis_tvalid(m20_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(i_rdy&mode==2),  // input wire m_axis_tready
  .m_axis_tdata(m20_axis_tdata)    // output wire [31 : 0] m_axis_tdata
);
wire    [10:0]i_w;
wire    [15:0]i_h;
wire    o_e_1;
wire    [63:0]o_data;
wire    [9:0]o_num;
wire    i_e;
wire    [31:0]i_x;
assign i_e=(mode==0)?m00_axis_tvalid:(mode==1?m10_axis_tvalid:m20_axis_tvalid);
assign i_x=(mode==0)?m00_axis_tdata:(mode==1?m10_axis_tdata:m20_axis_tdata);
//assign i_x = m00_axis_tdata;
assign i_w = (chicun==0)?0:(chicun==1?1:2);
assign i_h = (chicun==0)?15:(chicun==1?31:63);
uh_jls u4_encode(
	.clk(clk),
	.rstn(rst_n),
	.i_w(i_w),
	.i_h(i_h),
	.i_rdy(i_rdy),
	.i_e(i_e),
	.i_x(i_x),
	.o_e(),
	.o_e_1(o_e_1),
	.o_data(o_data),
	.o_last(),
	.mode(mode),
	.o_num(o_num)
);
wire    fifo4_wr_en;
wire    fifo4_rd_en;
wire    [511:0]fifo4_dout;
wire    fifo4_empty;
wire    fifo4_full;
wire    fifo5_wr_en;
wire    fifo5_rd_en;
wire    [255:0]fifo5_dout;
wire    fifo5_empty;
wire    fifo5_full;
wire    fifo6_wr_en;
wire    fifo6_rd_en;
wire    [127:0]fifo6_dout;
wire    fifo6_empty;
wire    fifo6_full;
wire    s01_axis_tvalid,s01_axis_tready;
wire    m01_axis_tvalid,m01_axis_tready;
wire    [511:0]s01_axis_tdata;
wire    [511:0]m01_axis_tdata;
wire    s02_axis_tvalid,s02_axis_tready;
wire    m02_axis_tvalid,m02_axis_tready;
wire    [511:0]s02_axis_tdata;
wire    [255:0]m02_axis_tdata;
wire    s03_axis_tvalid,s03_axis_tready;
wire    m03_axis_tvalid,m03_axis_tready;
wire    [511:0]s03_axis_tdata;
wire    [127:0]m03_axis_tdata;

assign  fifo4_rd_en = !fifo4_empty&s01_axis_tready&mode==0;
assign  fifo4_wr_en = o_e_1&mode==0;
fifo_64_512 u1_fifo_64_512_out (
  .clk(clk),                            // input wire clk
  .srst(!rst_n),                          // input wire srst
  .din(o_data),                            // input wire [63 : 0] din
  .wr_en(fifo4_wr_en),                        // input wire wr_en
  .rd_en(fifo4_rd_en),                        // input wire rd_en
  .prog_full_thresh(500),  // input wire [11 : 0] prog_full_thresh
  .dout(fifo4_dout),                          // output wire [511 : 0] dout
  .full(fifo4_full),                          // output wire full
  .empty(fifo4_empty),                        // output wire empty
  .prog_full()                // output wire prog_full
);
assign  fifo5_rd_en = !fifo5_empty&s02_axis_tready&mode==1;
assign  fifo5_wr_en = o_e_1&mode==1;
fifo_64_256 u2_fifo_64_256_out (
  .clk(clk),                            // input wire clk
  .srst(!rst_n),                          // input wire srst
  .din(o_data),                            // input wire [63 : 0] din
  .wr_en(fifo5_wr_en),                        // input wire wr_en
  .rd_en(fifo5_rd_en),                        // input wire rd_en
  .prog_full_thresh(500),  // input wire [9 : 0] prog_full_thresh
  .dout(fifo5_dout),                          // output wire [255 : 0] dout
  .full(fifo5_full),                          // output wire full
  .empty(fifo5_empty),                        // output wire empty
  .prog_full()                // output wire prog_full
);
assign  fifo6_rd_en = !fifo6_empty&s03_axis_tready&mode==2;
assign  fifo6_wr_en = o_e_1&mode==2;
fifo_64_128 u3_fifo_64_128_out (
  .clk(clk),                            // input wire clk
  .srst(!rst_n),                          // input wire srst
  .din(o_data),                            // input wire [63 : 0] din
  .wr_en(fifo6_wr_en),                        // input wire wr_en
  .rd_en(fifo6_rd_en),                        // input wire rd_en
  .prog_full_thresh(300),  // input wire [8 : 0] prog_full_thresh
  .dout(fifo6_dout),                          // output wire [127 : 0] dout
  .full(fifo6_full),                          // output wire full
  .empty(fifo6_empty),                        // output wire empty
  .prog_full()                // output wire prog_full
);
//assign s01_axis_tdata=fifo4_dout;
assign s01_axis_tvalid = fifo4_rd_en;
assign s01_axis_tdata = {fifo4_dout[63:0],fifo4_dout[127:64],fifo4_dout[191:128],fifo4_dout[255:192],fifo4_dout[319:256],fifo4_dout[383:320],fifo4_dout[447:384],fifo4_dout[511:448]};
axi_fifo_512_32 axi_fifo_512_512 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(s01_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s01_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s01_axis_tdata),    // input wire [511 : 0] s_axis_tdata
  .m_axis_tvalid(m0_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m2_axis_tready),//(m2_axis_tready),,  // input wire m_axis_tready
  .m_axis_tdata(m0_axis_tdata)    // output wire [511 : 0] m_axis_tdata
);
//assign s02_axis_tvalid = fifo5_rd_en;
assign s02_axis_tdata = {fifo5_dout[63:0],fifo5_dout[127:64],fifo5_dout[191:128],fifo5_dout[255:192]};
fifo_256_256 axi_fifo_256_256 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(fifo5_rd_en),  // input wire s_axis_tvalid
  .s_axis_tready(s02_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s02_axis_tdata),    // input wire [255 : 0] s_axis_tdata
  .m_axis_tvalid(m1_axis_tvalid),//(m1_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m1_axis_tready),//(m1_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m1_axis_tdata)    // output wire [255 : 0] m_axis_tdata
);

assign s03_axis_tvalid = fifo6_rd_en;
assign s03_axis_tdata = {fifo6_dout[63:0],fifo6_dout[127:64]};
wire [127:0]m2_axis_tdata_r;
fifo_128_128 axi_fifo_128_128 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(s03_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s03_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s03_axis_tdata),    // input wire [127 : 0] s_axis_tdata
  .m_axis_tvalid(m2_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m2_axis_tready),//(m2_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m2_axis_tdata)    // output wire [127 : 0] m_axis_tdata
); 
//assign m2_axis_tdata = {m2_axis_tdata_r[63:0],m2_axis_tdata_r[127:64]};
endmodule
