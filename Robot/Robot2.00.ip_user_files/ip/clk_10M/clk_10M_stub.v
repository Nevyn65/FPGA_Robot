// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Fri Nov  1 11:50:30 2019
// Host        : DESKTOP-89AAFLI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M_stub.v
// Design      : clk_10M
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_10M(clk_out1, clk_out2, clk_out3, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,clk_out2,clk_out3,clk_in1" */;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  input clk_in1;
endmodule
