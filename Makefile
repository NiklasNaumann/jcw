verilog: jcw/jcw.xpr

jcw/jcw.xpr:
	vivado -mode batch -source tcl/setup.tcl -nolog -nojournal

clean:
	rm -rf jcw*
	rm -rf .Xil