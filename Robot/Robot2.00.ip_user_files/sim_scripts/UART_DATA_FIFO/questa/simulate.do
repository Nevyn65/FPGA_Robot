onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib UART_DATA_FIFO_opt

do {wave.do}

view wave
view structure
view signals

do {UART_DATA_FIFO.udo}

run -all

quit -force
