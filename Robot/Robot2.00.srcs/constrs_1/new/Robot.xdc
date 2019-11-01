## This file is a general .xdc for the CmodA7 rev. B
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

# Clock signal 100 MHz
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports CLK]
#create_clock -add -name sys_clk_pin -period 83.33 -waveform {0 41.66} [get_ports {CLK}];


# LEDs
set_property -dict {PACKAGE_PIN A17 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN C16 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]

#set_property -dict { PACKAGE_PIN B17   IOSTANDARD LVCMOS33 } [get_ports { RGB0_Red }]; #IO_L14N_T2_SRCC_16 Sch=led0_b
#set_property -dict { PACKAGE_PIN B16   IOSTANDARD LVCMOS33 } [get_ports { RGB0_Green }]; #IO_L13N_T2_MRCC_16 Sch=led0_g
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { RGB0_Blue }]; #IO_L14P_T2_SRCC_16 Sch=led0_r



# Buttons
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports SW1]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports SW2]

## Pmod Header JA
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {ja[0]}]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports {ja[1]}]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports {ja[2]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {ja[3]}]
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {ja[4]}]
set_property -dict {PACKAGE_PIN H19 IOSTANDARD LVCMOS33} [get_ports {ja[5]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {ja[6]}]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD LVCMOS33} [get_ports {ja[7]}]


## Analog XADC Pins
## Only declare these if you want to use pins 15 and 16 as single ended analog inputs. pin 15 -> vaux4, pin16 -> vaux12
#set_property -dict { PACKAGE_PIN G2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[0] }]; #IO_L1N_T0_AD4N_35 Sch=ain_n[15]
#set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { xa_p[0] }]; #IO_L1P_T0_AD4P_35 Sch=ain_p[15]
#set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { xa_n[1] }]; #IO_L2N_T0_AD12N_35 Sch=ain_n[16]
#set_property -dict { PACKAGE_PIN H2    IOSTANDARD LVCMOS33 } [get_ports { xa_p[1] }]; #IO_L2P_T0_AD12P_35 Sch=ain_p[16]


## GPIO Pins
## Pins 15 and 16 should remain commented if using them as analog inputs
set_property -dict {PACKAGE_PIN M3 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[16]}]
set_property -dict {PACKAGE_PIN L3 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[15]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[14]}]
set_property -dict {PACKAGE_PIN K3 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[13]}]
#set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[4] }]; #IO_L11P_T1_SRCC_16 Sch=pio[05]
#set_property -dict { PACKAGE_PIN H1    IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[5] }]; #IO_L3P_T0_DQS_AD5P_35 Sch=pio[06]
#set_property -dict { PACKAGE_PIN A15   IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[6] }]; #IO_L6N_T0_VREF_16 Sch=pio[07]
#set_property -dict { PACKAGE_PIN B15   IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[7] }]; #IO_L11N_T1_SRCC_16 Sch=pio[08]
#set_property -dict { PACKAGE_PIN A14   IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[8] }]; #IO_L6P_T0_16 Sch=pio[09]
#set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[9] }]; #IO_L7P_T1_AD6P_35 Sch=pio[10]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports CMOD_EYE]
#set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { CTRL_OUT[11] }]; #IO_L5P_T0_AD13P_35 Sch=pio[12]
set_property -dict {PACKAGE_PIN L1 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[9]}]
set_property -dict {PACKAGE_PIN L2 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[10]}]
set_property -dict {PACKAGE_PIN M1 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[11]}]
set_property -dict {PACKAGE_PIN N3 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[12]}]
set_property -dict {PACKAGE_PIN P3 IOSTANDARD LVCMOS33} [get_ports {B_DIR[1]}]
set_property -dict {PACKAGE_PIN M2 IOSTANDARD LVCMOS33} [get_ports {B_DIR[2]}]
#set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { pio[21] }]; #IO_L10N_T1_AD15N_35 Sch=pio[21]
#set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { pio[22] }]; #IO_L10P_T1_AD15P_35 Sch=pio[22]
#set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { pio[23] }]; #IO_L19N_T3_VREF_35 Sch=pio[23]
set_property -dict {PACKAGE_PIN R3 IOSTANDARD LVCMOS33} [get_ports {A_DIR[2]}]
set_property -dict {PACKAGE_PIN T3 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[1]}]
set_property -dict {PACKAGE_PIN R2 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[2]}]
set_property -dict {PACKAGE_PIN T1 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[3]}]
set_property -dict {PACKAGE_PIN T2 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[4]}]
#set_property -dict { PACKAGE_PIN U1    IOSTANDARD LVCMOS33 } [get_ports { pio[31] }]; #IO_L3N_T0_DQS_34 Sch=pio[31]
#set_property -dict { PACKAGE_PIN W2    IOSTANDARD LVCMOS33 } [get_ports { pio[32] }]; #IO_L5N_T0_34 Sch=pio[32]
#set_property -dict { PACKAGE_PIN V2    IOSTANDARD LVCMOS33 } [get_ports { pio[33] }]; #IO_L5P_T0_34 Sch=pio[33]
#set_property -dict { PACKAGE_PIN W3    IOSTANDARD LVCMOS33 } [get_ports { pio[34] }]; #IO_L6N_T0_VREF_34 Sch=pio[34]
#set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports { pio[35] }]; #IO_L6P_T0_34 Sch=pio[35]
#set_property -dict { PACKAGE_PIN W5    IOSTANDARD LVCMOS33 } [get_ports { pio[36] }]; #IO_L12P_T1_MRCC_34 Sch=pio[36]
#set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports { pio[37] }]; #IO_L11N_T1_SRCC_34 Sch=pio[37]
#set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports { pio[38] }]; #IO_L11P_T1_SRCC_34 Sch=pio[38]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[8]}]
set_property -dict {PACKAGE_PIN W4 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[7]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[6]}]
set_property -dict {PACKAGE_PIN U2 IOSTANDARD LVCMOS33} [get_ports {CMOD_ATR[5]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {A_DIR[1]}]
#set_property -dict { PACKAGE_PIN U3    IOSTANDARD LVCMOS33 } [get_ports { pio[44] }]; #IO_L9P_T1_DQS_34 Sch=pio[44]
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { pio[45] }]; #IO_L19P_T3_34 Sch=pio[45]
#set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports { pio[46] }]; #IO_L13P_T2_MRCC_34 Sch=pio[46]
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { pio[47] }]; #IO_L14P_T2_SRCC_34 Sch=pio[47]
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { pio[48] }]; #IO_L14N_T2_SRCC_34 Sch=pio[48]


## UART
#set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { UART_TXD }]; #IO_L7N_T1_D10_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { uart_txd_in  }]; #IO_L7P_T1_D09_14 Sch=uart_txd_in


## Crypto 1 Wire Interface
#set_property -dict { PACKAGE_PIN D17   IOSTANDARD LVCMOS33 } [get_ports { crypto_sda }]; #IO_0_14 Sch=crypto_sda


## QSPI
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { qspi_cs    }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_cs
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN D19   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN G18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN F18   IOSTANDARD LVCMOS33 } [get_ports { qspi_dq[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]


## Cellular RAM
#set_property -dict { PACKAGE_PIN M18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[0]  }]; #IO_L11P_T1_SRCC_14 Sch=sram- a[0]
#set_property -dict { PACKAGE_PIN M19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[1]  }]; #IO_L11N_T1_SRCC_14 Sch=sram- a[1]
#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[2]  }]; #IO_L12N_T1_MRCC_14 Sch=sram- a[2]
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[3]  }]; #IO_L13P_T2_MRCC_14 Sch=sram- a[3]
#set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[4]  }]; #IO_L13N_T2_MRCC_14 Sch=sram- a[4]
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[5]  }]; #IO_L14P_T2_SRCC_14 Sch=sram- a[5]
#set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[6]  }]; #IO_L14N_T2_SRCC_14 Sch=sram- a[6]
#set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[7]  }]; #IO_L16N_T2_A15_D31_14 Sch=sram- a[7]
#set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[8]  }]; #IO_L15P_T2_DQS_RDWR_B_14 Sch=sram- a[8]
#set_property -dict { PACKAGE_PIN V19   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[9]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=sram- a[9]
#set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[10] }]; #IO_L16P_T2_CSI_B_14 Sch=sram- a[10]
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[11] }]; #IO_L17P_T2_A14_D30_14 Sch=sram- a[11]
#set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[12] }]; #IO_L17N_T2_A13_D29_14 Sch=sram- a[12]
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[13] }]; #IO_L18P_T2_A12_D28_14 Sch=sram- a[13]
#set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[14] }]; #IO_L18N_T2_A11_D27_14 Sch=sram- a[14]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[15] }]; #IO_L19P_T3_A10_D26_14 Sch=sram- a[15]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[16] }]; #IO_L20P_T3_A08_D24_14 Sch=sram- a[16]
#set_property -dict { PACKAGE_PIN W17   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[17] }]; #IO_L20N_T3_A07_D23_14 Sch=sram- a[17]
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { MemAdr[18] }]; #IO_L21P_T3_DQS_14 Sch=sram- a[18]
#set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[0]   }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=sram-dq[0]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[1]   }]; #IO_L22P_T3_A05_D21_14 Sch=sram-dq[1]
#set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[2]   }]; #IO_L22N_T3_A04_D20_14 Sch=sram-dq[2]
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { MemDB[3]   }]; #IO_L23P_T3_A03_D19_14 Sch=sram-dq[3]
#set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { MemDB[4]   }]; #IO_L23N_T3_A02_D18_14 Sch=sram-dq[4]
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { MemDB[5]   }]; #IO_L24P_T3_A01_D17_14 Sch=sram-dq[5]
#set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[6]   }]; #IO_L24N_T3_A00_D16_14 Sch=sram-dq[6]
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { MemDB[7]   }]; #IO_25_14 Sch=sram-dq[7]
#set_property -dict { PACKAGE_PIN P19   IOSTANDARD LVCMOS33 } [get_ports { RamOEn     }]; #IO_L10P_T1_D14_14 Sch=sram-oe
#set_property -dict { PACKAGE_PIN R19   IOSTANDARD LVCMOS33 } [get_ports { RamWEn     }]; #IO_L10N_T1_D15_14 Sch=sram-we
#set_property -dict { PACKAGE_PIN N19   IOSTANDARD LVCMOS33 } [get_ports { RamCEn     }]; #IO_L9N_T1_DQS_D13_14 Sch=sram-ce

## RST
set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { RST }]; 

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_10M_1/inst/clk_out2]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {Count_CTRL[0]} {Count_CTRL[1]} {Count_CTRL[2]} {Count_CTRL[3]} {Count_CTRL[4]} {Count_CTRL[5]} {Count_CTRL[6]} {Count_CTRL[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {DJ_ID1[0]} {DJ_ID1[1]} {DJ_ID1[2]} {DJ_ID1[3]} {DJ_ID1[4]} {DJ_ID1[5]} {DJ_ID1[6]} {DJ_ID1[7]} {DJ_ID1[8]} {DJ_ID1[9]} {DJ_ID1[10]} {DJ_ID1[11]} {DJ_ID1[12]} {DJ_ID1[13]} {DJ_ID1[14]} {DJ_ID1[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 16 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {DJ_ID11[0]} {DJ_ID11[1]} {DJ_ID11[2]} {DJ_ID11[3]} {DJ_ID11[4]} {DJ_ID11[5]} {DJ_ID11[6]} {DJ_ID11[7]} {DJ_ID11[8]} {DJ_ID11[9]} {DJ_ID11[10]} {DJ_ID11[11]} {DJ_ID11[12]} {DJ_ID11[13]} {DJ_ID11[14]} {DJ_ID11[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 16 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {DJ_ID13[0]} {DJ_ID13[1]} {DJ_ID13[2]} {DJ_ID13[3]} {DJ_ID13[4]} {DJ_ID13[5]} {DJ_ID13[6]} {DJ_ID13[7]} {DJ_ID13[8]} {DJ_ID13[9]} {DJ_ID13[10]} {DJ_ID13[11]} {DJ_ID13[12]} {DJ_ID13[13]} {DJ_ID13[14]} {DJ_ID13[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 16 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {DJ_ID16[0]} {DJ_ID16[1]} {DJ_ID16[2]} {DJ_ID16[3]} {DJ_ID16[4]} {DJ_ID16[5]} {DJ_ID16[6]} {DJ_ID16[7]} {DJ_ID16[8]} {DJ_ID16[9]} {DJ_ID16[10]} {DJ_ID16[11]} {DJ_ID16[12]} {DJ_ID16[13]} {DJ_ID16[14]} {DJ_ID16[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {DJ_ID17[0]} {DJ_ID17[1]} {DJ_ID17[2]} {DJ_ID17[3]} {DJ_ID17[4]} {DJ_ID17[5]} {DJ_ID17[6]} {DJ_ID17[7]} {DJ_ID17[8]} {DJ_ID17[9]} {DJ_ID17[10]} {DJ_ID17[11]} {DJ_ID17[12]} {DJ_ID17[13]} {DJ_ID17[14]} {DJ_ID17[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 16 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {DJ_ID2[0]} {DJ_ID2[1]} {DJ_ID2[2]} {DJ_ID2[3]} {DJ_ID2[4]} {DJ_ID2[5]} {DJ_ID2[6]} {DJ_ID2[7]} {DJ_ID2[8]} {DJ_ID2[9]} {DJ_ID2[10]} {DJ_ID2[11]} {DJ_ID2[12]} {DJ_ID2[13]} {DJ_ID2[14]} {DJ_ID2[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {DJ_ID14[0]} {DJ_ID14[1]} {DJ_ID14[2]} {DJ_ID14[3]} {DJ_ID14[4]} {DJ_ID14[5]} {DJ_ID14[6]} {DJ_ID14[7]} {DJ_ID14[8]} {DJ_ID14[9]} {DJ_ID14[10]} {DJ_ID14[11]} {DJ_ID14[12]} {DJ_ID14[13]} {DJ_ID14[14]} {DJ_ID14[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 16 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {DJ_ID3[0]} {DJ_ID3[1]} {DJ_ID3[2]} {DJ_ID3[3]} {DJ_ID3[4]} {DJ_ID3[5]} {DJ_ID3[6]} {DJ_ID3[7]} {DJ_ID3[8]} {DJ_ID3[9]} {DJ_ID3[10]} {DJ_ID3[11]} {DJ_ID3[12]} {DJ_ID3[13]} {DJ_ID3[14]} {DJ_ID3[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 16 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {DJ_ID10[0]} {DJ_ID10[1]} {DJ_ID10[2]} {DJ_ID10[3]} {DJ_ID10[4]} {DJ_ID10[5]} {DJ_ID10[6]} {DJ_ID10[7]} {DJ_ID10[8]} {DJ_ID10[9]} {DJ_ID10[10]} {DJ_ID10[11]} {DJ_ID10[12]} {DJ_ID10[13]} {DJ_ID10[14]} {DJ_ID10[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 16 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {DJ_ID12[0]} {DJ_ID12[1]} {DJ_ID12[2]} {DJ_ID12[3]} {DJ_ID12[4]} {DJ_ID12[5]} {DJ_ID12[6]} {DJ_ID12[7]} {DJ_ID12[8]} {DJ_ID12[9]} {DJ_ID12[10]} {DJ_ID12[11]} {DJ_ID12[12]} {DJ_ID12[13]} {DJ_ID12[14]} {DJ_ID12[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 16 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {DJ_ID15[0]} {DJ_ID15[1]} {DJ_ID15[2]} {DJ_ID15[3]} {DJ_ID15[4]} {DJ_ID15[5]} {DJ_ID15[6]} {DJ_ID15[7]} {DJ_ID15[8]} {DJ_ID15[9]} {DJ_ID15[10]} {DJ_ID15[11]} {DJ_ID15[12]} {DJ_ID15[13]} {DJ_ID15[14]} {DJ_ID15[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 16 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {DJ_ID8[0]} {DJ_ID8[1]} {DJ_ID8[2]} {DJ_ID8[3]} {DJ_ID8[4]} {DJ_ID8[5]} {DJ_ID8[6]} {DJ_ID8[7]} {DJ_ID8[8]} {DJ_ID8[9]} {DJ_ID8[10]} {DJ_ID8[11]} {DJ_ID8[12]} {DJ_ID8[13]} {DJ_ID8[14]} {DJ_ID8[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 16 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {DJ_ID5[0]} {DJ_ID5[1]} {DJ_ID5[2]} {DJ_ID5[3]} {DJ_ID5[4]} {DJ_ID5[5]} {DJ_ID5[6]} {DJ_ID5[7]} {DJ_ID5[8]} {DJ_ID5[9]} {DJ_ID5[10]} {DJ_ID5[11]} {DJ_ID5[12]} {DJ_ID5[13]} {DJ_ID5[14]} {DJ_ID5[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 16 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {DJ_ID4[0]} {DJ_ID4[1]} {DJ_ID4[2]} {DJ_ID4[3]} {DJ_ID4[4]} {DJ_ID4[5]} {DJ_ID4[6]} {DJ_ID4[7]} {DJ_ID4[8]} {DJ_ID4[9]} {DJ_ID4[10]} {DJ_ID4[11]} {DJ_ID4[12]} {DJ_ID4[13]} {DJ_ID4[14]} {DJ_ID4[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 16 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {DJ_ID6[0]} {DJ_ID6[1]} {DJ_ID6[2]} {DJ_ID6[3]} {DJ_ID6[4]} {DJ_ID6[5]} {DJ_ID6[6]} {DJ_ID6[7]} {DJ_ID6[8]} {DJ_ID6[9]} {DJ_ID6[10]} {DJ_ID6[11]} {DJ_ID6[12]} {DJ_ID6[13]} {DJ_ID6[14]} {DJ_ID6[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 16 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {DJ_ID7[0]} {DJ_ID7[1]} {DJ_ID7[2]} {DJ_ID7[3]} {DJ_ID7[4]} {DJ_ID7[5]} {DJ_ID7[6]} {DJ_ID7[7]} {DJ_ID7[8]} {DJ_ID7[9]} {DJ_ID7[10]} {DJ_ID7[11]} {DJ_ID7[12]} {DJ_ID7[13]} {DJ_ID7[14]} {DJ_ID7[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 16 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {DJ_ID9[0]} {DJ_ID9[1]} {DJ_ID9[2]} {DJ_ID9[3]} {DJ_ID9[4]} {DJ_ID9[5]} {DJ_ID9[6]} {DJ_ID9[7]} {DJ_ID9[8]} {DJ_ID9[9]} {DJ_ID9[10]} {DJ_ID9[11]} {DJ_ID9[12]} {DJ_ID9[13]} {DJ_ID9[14]} {DJ_ID9[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 5 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {DJ_ROM_ADDR[0]} {DJ_ROM_ADDR[1]} {DJ_ROM_ADDR[2]} {DJ_ROM_ADDR[3]} {DJ_ROM_ADDR[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 16 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {DJ_ROM_DATA[0]} {DJ_ROM_DATA[1]} {DJ_ROM_DATA[2]} {DJ_ROM_DATA[3]} {DJ_ROM_DATA[4]} {DJ_ROM_DATA[5]} {DJ_ROM_DATA[6]} {DJ_ROM_DATA[7]} {DJ_ROM_DATA[8]} {DJ_ROM_DATA[9]} {DJ_ROM_DATA[10]} {DJ_ROM_DATA[11]} {DJ_ROM_DATA[12]} {DJ_ROM_DATA[13]} {DJ_ROM_DATA[14]} {DJ_ROM_DATA[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list SW1_TMP]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list SW1_TMP1_1]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_out2]
