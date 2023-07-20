onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+axis_convert_256_32  -L xpm -L axis_infrastructure_v1_1_0 -L axis_register_slice_v1_1_27 -L axis_dwidth_converter_v1_1_26 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.axis_convert_256_32 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {axis_convert_256_32.udo}

run 1000ns

endsim

quit -force
