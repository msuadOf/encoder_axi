`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/06 16:45:15
// Design Name: 
// Module Name: back_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module back_top(
input   wire    clk,
input   wire    rst_n,
input   wire    [1:0]mode,
//512bit weikuan
input   wire    s0_axis_tvalid,
output  wire    s0_axis_tready,
input   wire    [511:0]s0_axis_tdata,

input   wire    m0_axis_tready,
output  reg    m0_axis_tvalid,
output  reg    [63:0]m0_axis_tdata,
//256bit weikuan
input   wire    s1_axis_tvalid,
output  wire    s1_axis_tready,
input   wire    [255:0]s1_axis_tdata,


//128bit weikuan
input   wire    s2_axis_tvalid,
output  wire    s2_axis_tready,
input   wire    [127:0]s2_axis_tdata

    );
//wire    s01_axi_tvalid;
//always(*)begin
//    if(mode == 0 )begin
        
//    end
//end
wire    s0_axis_tvalid_r;
wire    m0_axis_tvalid_r;
wire    [63:0]m0_axis_tdata_r;
reg     m0_axis_tready_r;
//assign m0_axis_tvalid = (mode==0)?m0_axis_tvalid_r:(mode==1?m1_axis_tvalid_r:m2_axis_tvalid);
assign s0_axis_tvalid_r=s0_axis_tvalid&mode==0;
axi_convert_512_64 u1_axi_convert_512_64_output (
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s0_axis_tvalid_r),  // input wire s_axis_tvalid
  .s_axis_tready(s0_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s0_axis_tdata),    // input wire [511 : 0] s_axis_tdata
  .m_axis_tvalid(m0_axis_tvalid_r),  // output wire m_axis_tvalid
  .m_axis_tready(m0_axis_tready_r),  // input wire m_axis_tready
  .m_axis_tdata(m0_axis_tdata_r)    // output wire [63 : 0] m_axis_tdata
);
wire    s1_axis_tvalid_r;
wire    m1_axis_tvalid;
reg    m1_axis_tready;
wire    [63:0]m1_axis_tdata;

//assign s1_axis_tvalid_r=mode==1?s1_axis_tvalid:0;
assign s1_axis_tvalid_r=s1_axis_tvalid&mode==1;
axi_convert_256_64 u2_axi_convert_256_64_output (
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s1_axis_tvalid_r),  // input wire s_axis_tvalid
  .s_axis_tready(s1_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s1_axis_tdata),    // input wire [127 : 0] s_axis_tdata
  .m_axis_tvalid(m1_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m1_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m1_axis_tdata)    // output wire [31 : 0] m_axis_tdata
);
wire    s2_axis_tvalid_r;
wire    m2_axis_tvalid;
reg    m2_axis_tready;
wire    [63:0]m2_axis_tdata;
assign s2_axis_tvalid_r=s2_axis_tvalid&mode==2;

axi_convert128_64  u3_axi_convert_128_64_output(
  .aclk(clk),                    // input wire aclk
  .aresetn(rst_n),              // input wire aresetn
  .s_axis_tvalid(s2_axis_tvalid_r),  // input wire s_axis_tvalid
  .s_axis_tready(s2_axis_tready),  // output wire s_axis_tready
  .s_axis_tdata(s2_axis_tdata),    // input wire [127 : 0] s_axis_tdata
  .m_axis_tvalid(m2_axis_tvalid),  // output wire m_axis_tvalid
  .m_axis_tready(m2_axis_tready),  // input wire m_axis_tready
  .m_axis_tdata(m2_axis_tdata)    // output wire [63 : 0] m_axis_tdata
);

always@(*)begin
    if(mode==0)begin
        m0_axis_tvalid <= m0_axis_tvalid_r;
        m0_axis_tdata<=m0_axis_tdata_r;
        m0_axis_tready_r<=m0_axis_tready;
    end
    else if(mode==1)begin
        m0_axis_tvalid<=m1_axis_tvalid;
        m0_axis_tdata<=m1_axis_tdata;
        m1_axis_tready<=m0_axis_tready;
    end
    else if(mode==2)begin
        m0_axis_tvalid<=m2_axis_tvalid;
        m0_axis_tdata<=m2_axis_tdata;
        m2_axis_tready<=m0_axis_tready;
   end
end
endmodule
