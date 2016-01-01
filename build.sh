#!/bin/bash

mkdir -p class
mkdir -p emulator
mkdir -p vhdl
mkdir -p verilog

scalac -d class -cp ./chisel-snapshot/chisel_2.11-2.3-SNAPSHOT.jar src/*.scala
scala -cp ./chisel-snapshot/chisel_2.11-2.3-SNAPSHOT.jar:./class TTA_BasicAlu.fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor_run --configInstance TTA_BasicAlu.cfg_32b_always_1 --backend Chisel.TTABackend --targetDir ./verilog
scala -cp ./chisel-snapshot/chisel_2.11-2.3-SNAPSHOT.jar:./class TTA_BasicLoadStore.ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw_run --configInstance TTA_BasicLoadStore.cfg_32b_24b --backend Chisel.TTABackend --targetDir ./verilog
scala -cp ./chisel-snapshot/chisel_2.11-2.3-SNAPSHOT.jar:./class TTA_Regfile.rf_1wr_1rd_always_1_guarded_0_run --configInstance TTA_Regfile.cfg_32b_5e --backend Chisel.TTABackend --targetDir ./verilog
scala -cp ./chisel-snapshot/chisel_2.11-2.3-SNAPSHOT.jar:./class TTA_Regfile.rf_1wr_1rd_always_1_guarded_0_run --configInstance TTA_Regfile.cfg_bool_2e --backend Chisel.TTABackend --targetDir ./verilog

