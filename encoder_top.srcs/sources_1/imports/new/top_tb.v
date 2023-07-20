`timescale 1ns / 1ps

module top_tb(
    );
 reg clk;
 reg rst_n;
 reg [1:0]chicun;
 reg s_axis0_tvalid;
 reg [63:0]s_axis0_tdata;
 reg [1:0]mode;
 wire   s_axis0_tready;
 //wire   [127:0]fifo1_dout;
assign s_axis0_tready=1'b1;

 initial begin
    clk=0;
    rst_n=0;
    s_axis0_tvalid=0;
    s_axis0_tdata=0;
    chicun=1;
    mode=1;
    #990
    rst_n = 1;
    s_axis0_tvalid=1;
    #10
    s_axis0_tdata='h0706050403020100;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
    #20
    s_axis0_tdata = s_axis0_tdata;
 end
 always #10 clk = ~clk;
 //always #20 s_axis0_tdata = s_axis0_tdata+'h0808080808080808;
 top top(
.clk(clk),
.chicun(chicun),
.rst_n(rst_n),
.mode(mode),
.s_axis0_tvalid(s_axis0_tvalid),
.s_axis0_tdata(s_axis0_tdata),
.s_axis0_tready(s_axis0_tready)

 
 );
 
endmodule
