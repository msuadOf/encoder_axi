onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib ax4_convert_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {ax4_convert.udo}

run 1000ns

quit -force
