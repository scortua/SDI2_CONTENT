vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vcom -work xil_defaultlib  -93 \
"../../../../IPRAM.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_sim_netlist.vhdl" \


