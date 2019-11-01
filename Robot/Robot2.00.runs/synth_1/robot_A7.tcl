# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/84646/Desktop/Robot2.15h/Robot2.00.cache/wt [current_project]
set_property parent.project_path C:/Users/84646/Desktop/Robot2.15h/Robot2.00.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/84646/Desktop/Robot2.15h/Robot2.00.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/DJ_DATA.coe
read_verilog -library xil_defaultlib {
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/BlueTooth_0.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/clk.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/control.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/decode.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/uart_rx.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/uart_top.v
  C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/new/uart_tx.v
  C:/Users/84646/Desktop/Robot_2/sours/robort.v
}
read_ip -quiet C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/DJ_DATA_ROM/DJ_DATA_ROM.xci
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/DJ_DATA_ROM/DJ_DATA_ROM_ooc.xdc]

read_ip -quiet C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/UART_DATA_FIFO/UART_DATA_FIFO.xci
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/UART_DATA_FIFO/UART_DATA_FIFO.xdc]
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/UART_DATA_FIFO/UART_DATA_FIFO_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/UART_DATA_FIFO/UART_DATA_FIFO_ooc.xdc]

read_ip -quiet C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M.xci
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M.xdc]
set_property used_in_implementation false [get_files -all c:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/sources_1/ip/clk_10M/clk_10M_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/constrs_1/new/Robot.xdc
set_property used_in_implementation false [get_files C:/Users/84646/Desktop/Robot2.15h/Robot2.00.srcs/constrs_1/new/Robot.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top robot_A7 -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef robot_A7.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file robot_A7_utilization_synth.rpt -pb robot_A7_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
