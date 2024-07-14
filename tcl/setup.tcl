# Create project on Genesys2 board
create_project jcw . -part xc7k325tffg900-2
set_property board_part digilentinc.com:genesys2:part0:1.1 [current_project]
set_property target_language Verilog [current_project]

# Create block design
source tcl/jcw.tcl

# Create wrapper
make_wrapper -files [get_files jcw.srcs/sources_1/bd/jcw/jcw.bd] -top
add_files -norecurse jcw.gen/sources_1/bd/jcw/hdl/jcw_wrapper.v

# Generate bd target
open_bd_design {jcw.srcs/sources_1/bd/jcw/jcw.bd}
make_wrapper -files [get_files jcw.srcs/sources_1/bd/jcw/jcw.bd] -fileset [get_filesets sources_1] -inst_template
generate_target all [get_files  jcw.srcs/sources_1/bd/jcw/jcw.bd]
catch { config_ip_cache -export [get_ips -all jcw_clk_wiz_0_0] }
catch { config_ip_cache -export [get_ips -all jcw_jtag_axi_0_0] }
export_ip_user_files -of_objects [get_files jcw.srcs/sources_1/bd/jcw/jcw.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] jcw.srcs/sources_1/bd/jcw/jcw.bd]
launch_runs jcw_clk_wiz_0_0_synth_1 jcw_jtag_axi_0_0_synth_1 -jobs 6
export_simulation -of_objects [get_files jcw.srcs/sources_1/bd/jcw/jcw.bd] -directory jcw.ip_user_files/sim_scripts -ip_user_files_dir jcw.ip_user_files -ipstatic_source_dir jcw.ip_user_files/ipstatic -lib_map_path [list {modelsim=jcw.cache/compile_simlib/modelsim} {questa=jcw.cache/compile_simlib/questa} {xcelium=jcw.cache/compile_simlib/xcelium} {vcs=jcw.cache/compile_simlib/vcs} {riviera=jcw.cache/compile_simlib/riviera}] -use_ip_compiled_libs -force -quiet
