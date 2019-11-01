-makelib ies_lib/xil_defaultlib -sv \
  "C:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "C:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "C:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M_clk_wiz.v" \
  "../../../../Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

