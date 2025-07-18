`include "uvm_macros.svh"
import uvm_pkg::*;

package pkg;

    `include "./registers/reg_test_reg.sv"
    `include "./registers/reg_test_block.sv"

    `include "./agent/my_seq_item.sv"
    `include "./sequences/my_seq.sv"
    `include "./agent/my_sequencer.sv"

    `include "./agent/my_driver.sv"
    `include "./agent/my_monitor.sv"
    `include "./agent/my_adapter.sv"
    `include "./agent/my_agent.sv"
    `include "./env/my_env.sv"
    `include "./test/base_test.sv"
    `include "./test/functional_test.sv"

endpackage
