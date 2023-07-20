onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib axi_fifo_512_32_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {axi_fifo_512_32.udo}

run -all

quit -force
