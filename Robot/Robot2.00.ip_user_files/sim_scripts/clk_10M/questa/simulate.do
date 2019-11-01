onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clk_10M_opt

do {wave.do}

view wave
view structure
view signals

do {clk_10M.udo}

run -all

quit -force
