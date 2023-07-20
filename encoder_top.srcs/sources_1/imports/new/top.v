`timescale 1ns / 1ps
module top(
input       wire        clk,
input       wire        rst_n,
input       wire        [1:0]mode,
input       wire        [1:0]chicun,
input       wire        s_axis0_tvalid,
input       wire       [63:0]s_axis0_tdata,
output      wire        s_axis0_tready,
input       wire        m_axis_tready_pcie,
output      wire        m_axis_tvalid_pcie,
output      wire        [63:0]m_axis_tdata_pcie
    );
// wire   [1:0]chicun;
 //wire   [63:0]fifo1_din;
 //wire   [63:0]fifo1_din;
 wire   fifo1_wr_en;
 wire   fifo1_rd_en;
 wire   [511:0]fifo1_dout;
 wire   fifo1_empty;
 wire   fifo1_prog_full;
 wire   fifo1_full;
 wire   [63:0]fifo1_din;
 wire   s_axis0_tready_1;
 wire    s00_axis_tready;
 wire    s10_axis_tready;
 wire    s20_axis_tready;
 assign fifo1_din={s_axis0_tdata[7:0],s_axis0_tdata[15:8],s_axis0_tdata[23:16],s_axis0_tdata[31:24],s_axis0_tdata[39:32],s_axis0_tdata[47:40],s_axis0_tdata[55:48],s_axis0_tdata[63:56]};
 assign fifo1_rd_en = !fifo1_empty&mode==0&s00_axis_tready;
 assign fifo1_wr_en = !fifo1_full & (s_axis0_tvalid==1)&mode==0;
 assign s_axis0_tready_1 = !fifo1_full & mode == 0;
 assign s_axis0_tready = s_axis0_tready_1|s_axis0_tready_2|s_axis0_tready_3;
    fifo_64_512 u1_fifo_64_512 (
  .clk(clk),                            // input wire clk
  .srst(!rst_n),                          // input wire srst
  .din(fifo1_din),                            // input wire [63 : 0] din
  .wr_en(fifo1_wr_en),                        // input wire wr_en
  .rd_en(fifo1_rd_en),                        // input wire rd_en
  .prog_full_thresh('d800),  // input wire [9 : 0] prog_full_thresh
  .dout(fifo1_dout),                          // output wire [511 : 0] dout
  .full(fifo1_full),                          // output wire full
  .empty(fifo1_empty),                        // output wire empty
  .prog_full(fifo1_prog_full)                // output wire prog_full
);
wire    [63:0]fifo2_din;
wire    fifo2_wr_en;
wire    fifo2_rd_en;
wire    fifo2_prog_full;
wire    [255:0]fifo2_dout;
wire    fifo2_full;
wire    fifo2_empty;
wire    s_axis0_tready_2;
assign fifo2_wr_en = !fifo2_full&mode==1 & (s_axis0_tvalid==1);
//锟叫改讹拷
assign fifo2_rd_en = !fifo2_empty&mode==1&s10_axis_tready;
assign s_axis0_tready_2 =  !fifo2_full & mode == 1;
assign fifo2_din = {s_axis0_tdata[7:0],s_axis0_tdata[15:8],s_axis0_tdata[23:16],s_axis0_tdata[31:24],s_axis0_tdata[39:32],s_axis0_tdata[47:40],s_axis0_tdata[55:48],s_axis0_tdata[63:56]};
fifo_64_256 u2_fifo_64_256 (
  .clk(clk),      // input wire clk
  .srst(!rst_n),    // input wire srst
  .din(fifo2_din),      // input wire [63 : 0] din
  .wr_en(fifo2_wr_en),  // input wire wr_en
  .rd_en(fifo2_rd_en),  // input wire rd_en
  .dout(fifo2_dout),    // output wire [255 : 0] dout
  .full(fifo2_full),    // output wire full
  .empty(fifo2_empty)  // output wire empty
);
wire    [63:0]fifo3_din;
wire    fifo3_wr_en;
wire    fifo3_rd_en;
wire    fifo3_prog_full;
wire    [127:0]fifo3_dout;
wire    fifo3_full;
wire    fifo3_empty;
wire    s_axis0_tready_3;
assign fifo3_wr_en = !fifo3_full&mode==2& (s_axis0_tvalid==1);
assign fifo3_rd_en = !fifo3_empty &mode==2&s20_axis_tready;
assign s_axis0_tready_3 =  !fifo2_full & mode == 2;
assign fifo3_din = {s_axis0_tdata[7:0],s_axis0_tdata[15:8],s_axis0_tdata[23:16],s_axis0_tdata[31:24],s_axis0_tdata[39:32],s_axis0_tdata[47:40],s_axis0_tdata[55:48],s_axis0_tdata[63:56]};
fifo_64_128 u3_fifo_64_128 (
  .clk(clk),                            // input wire clk
  .srst(!rst_n),                          // input wire srst
  .din(fifo3_din),                            // input wire [63 : 0] din
  .wr_en(fifo3_wr_en),                        // input wire wr_en
  .rd_en(fifo3_rd_en),                        // input wire rd_en
//  .prog_full_thresh(),  // input wire [8 : 0] prog_full_thresh
  .dout(fifo3_dout),                          // output wire [127 : 0] dout
  .full(fifo3_full),                          // output wire full
  .empty(fifo3_empty),                        // output wire empty
  .prog_full()                  // output wire prog_full
);
wire    s00_axis_tvalid;
wire    [511:0]s00_axis_tdata;
wire    m00_axis_tvalid;
wire    m00_axis_tready;
wire    [511:0]m00_axis_tdata;
assign  s00_axis_tvalid=fifo1_rd_en;
assign s00_axis_tdata=fifo1_dout;
//assign  s00_axis_tdata ={fifo1_dout[31:0],fifo1_dout[63:32],fifo1_dout[95:64],fifo1_dout[127:96],fifo1_dout[159:128],fifo1_dout[191:160],fifo1_dout[223:192],fifo1_dout[255:224],fifo1_dout[287:256],fifo1_dout[319:288],fifo1_dout[351:320],fifo1_dout[383:352],fifo1_dout[415:384],fifo1_dout[447:416],fifo1_dout[479:448],fifo1_dout[511:480]};
axi_fifo_512_32 u1_axi_fifo_512_512 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(s00_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s00_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s00_axis_tdata),    // input wire [511 : 0] s_axis_tdata
  .m_axis_tvalid(m00_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m00_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m00_axis_tdata)    // output wire [511 : 0] m_axis_tdata
);

wire    s10_axis_tvalid;
wire    [255:0]s10_axis_tdata;
wire    m10_axis_tvalid;
wire    m10_axis_tready;
wire    [255:0]m10_axis_tdata;
assign s10_axis_tvalid=fifo2_rd_en;
assign  s10_axis_tdata ={fifo2_dout[31:0],fifo2_dout[63:32],fifo2_dout[95:64],fifo2_dout[127:96],fifo2_dout[159:128],fifo2_dout[191:160],fifo2_dout[223:192],fifo2_dout[255:224]};
fifo_256_256 u2_axi_fifo_256_256 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(s10_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s10_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s10_axis_tdata),    // input wire [255 : 0] s_axis_tdata
  .m_axis_tvalid(m10_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m10_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m10_axis_tdata)    // output wire [255 : 0] m_axis_tdata
);


wire    s20_axis_tvalid;
wire    [127:0]s20_axis_tdata;
wire    m20_axis_tvalid;
wire    m20_axis_tready;
wire    [127:0]m20_axis_tdata;
assign s20_axis_tvalid = fifo3_rd_en;
assign s20_axis_tdata = {fifo3_dout[31:0],fifo3_dout[63:32],fifo3_dout[95:64],fifo3_dout[127:96]};
fifo_128_128 u3_fifo_128_128 (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(clk),                // input wire s_aclk
  .s_aresetn(rst_n),          // input wire s_aresetn
  .s_axis_tvalid(s20_axis_tvalid),  // input wire s_axis_tvalid
  .s_axis_tready(s20_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s20_axis_tdata),    // input wire [127 : 0] s_axis_tdata
  .m_axis_tvalid(m20_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m20_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m20_axis_tdata)    // output wire [127 : 0] m_axis_tdata
);


wire m0_axis_tready;
wire m0_axis_tvalid;
wire [511:0]m0_axis_tdata;
wire m1_axis_tready;
wire m1_axis_tvalid;
wire [255:0]m1_axis_tdata;
wire m2_axis_tready;
wire m2_axis_tvalid;
wire [127:0]m2_axis_tdata;
wire s0_axis_tready;
wire s0_axis_tvalid;
wire [511:0]s0_axis_tdata;
assign s0_axis_tvalid =m00_axis_tvalid;
assign s0_axis_tdata = {m00_axis_tdata[31:0],m00_axis_tdata[63:32],m00_axis_tdata[95:64],m00_axis_tdata[127:96],m00_axis_tdata[159:128],m00_axis_tdata[191:160],m00_axis_tdata[223:192],m00_axis_tdata[255:224],m00_axis_tdata[287:256],m00_axis_tdata[319:288],m00_axis_tdata[351:320],m00_axis_tdata[383:352],m00_axis_tdata[415:384],m00_axis_tdata[447:416],m00_axis_tdata[479:448],m00_axis_tdata[511:480]};
encoder encoder(
.clk(clk),
.rst_n(rst_n),
.chicun(chicun),
.mode(mode),
.s0_axis_tvalid(m00_axis_tvalid),
.s0_axis_tready(m00_axis_tready),
.s0_axis_tdata(m00_axis_tdata),

.m0_axis_tready(m0_axis_tready),
.m0_axis_tvalid(m0_axis_tvalid),
.m0_axis_tdata(m0_axis_tdata),
//256bit weikuan
.s1_axis_tvalid(m10_axis_tvalid),
.s1_axis_tready(m10_axis_tready),
.s1_axis_tdata(m10_axis_tdata),

.m1_axis_tready(m1_axis_tready),
.m1_axis_tvalid(m1_axis_tvalid),
.m1_axis_tdata(m1_axis_tdata),
//128bit weikuan
.s2_axis_tvalid(m20_axis_tvalid),
.s2_axis_tready(m20_axis_tready),
.s2_axis_tdata(m20_axis_tdata),

.m2_axis_tready(m2_axis_tready),
.m2_axis_tvalid(m2_axis_tvalid),
.m2_axis_tdata(m2_axis_tdata)
    );



back_top back_top(
.clk(clk),
.rst_n(rst_n),
.mode(mode),
//512bit weikuan
.s0_axis_tvalid(m0_axis_tvalid),
.s0_axis_tready(m0_axis_tready),
.s0_axis_tdata(m0_axis_tdata),
//256bit weikuan
.s1_axis_tvalid(m1_axis_tvalid),
.s1_axis_tready(m1_axis_tready),
.s1_axis_tdata(m1_axis_tdata),
//128bit weikuan
.s2_axis_tvalid(m2_axis_tvalid),
.s2_axis_tready(m2_axis_tready),
.s2_axis_tdata(m2_axis_tdata),
//64bit
.m0_axis_tready(m_axis_tready_pcie),
.m0_axis_tvalid(m_axis_tvalid_pcie),//(m_axis_tvalid_pcie),
.m0_axis_tdata(m_axis_tdata_pcie)
    );
endmodule
