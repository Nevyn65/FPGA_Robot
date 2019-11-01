// (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:xup:BlueTooth:1.0
// IP Revision: 3

(* X_CORE_INFO = "uart_top,Vivado 2014.4" *)
(* CHECK_LICENSE_TYPE = "BlueTooth_0,uart_top,{}" *)
(* CORE_GENERATION_INFO = "BlueTooth_0,uart_top,{x_ipProduct=Vivado 2014.4,x_ipVendor=xilinx.com,x_ipLibrary=xup,x_ipName=BlueTooth,x_ipVersion=1.0,x_ipCoreRevision=3,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,DVSR=651,DATA_WIDTH=8,SB_TICK=16}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module BlueTooth_0 (
  clk,
  reset,
  rx,
  tx_btn,
  data_in,
  data_out,
  rx_done,
  tx_done,
  tx
);


input wire clk;
input wire reset;
input wire rx;
input wire tx_btn;
input wire [7 : 0] data_in;
output wire [7 : 0] data_out;
output wire rx_done;
output wire tx_done;
output wire tx;

  uart_top #(
    .DVSR(5),
//    .DVSR(651),
    .DATA_WIDTH(8),
    .SB_TICK(16)
  ) inst (
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .tx_btn(tx_btn),
    .data_in(data_in),
    .data_out(data_out),
    .rx_done(rx_done),
    .tx_done(tx_done),
    .tx(tx)
  );
endmodule
