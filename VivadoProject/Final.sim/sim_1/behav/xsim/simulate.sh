#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Thu Jan 09 09:37:07 +03 2020
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim TOP_tb_behav -key {Behavioral:sim_1:Functional:TOP_tb} -tclbatch TOP_tb.tcl -view /home/akif/Projects/EHB326E/Final/VivadoProject/Final.srcs/sim_1/imports/Final/TOP_tb_behav.wcfg -log simulate.log"
xsim TOP_tb_behav -key {Behavioral:sim_1:Functional:TOP_tb} -tclbatch TOP_tb.tcl -view /home/akif/Projects/EHB326E/Final/VivadoProject/Final.srcs/sim_1/imports/Final/TOP_tb_behav.wcfg -log simulate.log

