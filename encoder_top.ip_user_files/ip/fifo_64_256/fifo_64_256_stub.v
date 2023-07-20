// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Wed Jul 19 19:18:19 2023
// Host        : Lsuad running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/2022jcs/area_competition/encoder_top/encoder_top.gen/sources_1/ip/fifo_64_256/fifo_64_256_stub.v
// Design      : fifo_64_256
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu5ev-sfvc784-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_7,Vivado 2022.1" *)
module fifo_64_256(clk, srst, din, wr_en, rd_en, prog_full_thresh, dout, 
  full, empty, prog_full, wr_rst_busy, rd_rst_busy)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[63:0],wr_en,rd_en,prog_full_thresh[9:0],dout[255:0],full,empty,prog_full,wr_rst_busy,rd_rst_busy" */;
  input clk;
  input srst;
  input [63:0]din;
  input wr_en;
  input rd_en;
  input [9:0]prog_full_thresh;
  output [255:0]dout;
  output full;
  output empty;
  output prog_full;
  output wr_rst_busy;
  output rd_rst_busy;
endmodule
