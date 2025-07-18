`include "uvm_macros.svh"
import uvm_pkg::*;
import pkg::*;

module top;

    logic clk;
    logic rst_n;

    dummy_if sb_if(.clk(clk), .rst_n(rst_n));

    dummy_dut#(
        .WIDTH(32)
    )dut(
        .clk(clk),
        .rst_n(sb_if.rst_n),
        .req(sb_if.req),
        .write(sb_if.write),
        .addr(sb_if.addr),
        .wdata(sb_if.wdata),
        .rdata(sb_if.rdata),
        .ready(sb_if.ready)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst_n = 1;
        #1
        rst_n = 0;
        #1 rst_n = 1;
    end

    initial begin
        uvm_config_db#(virtual dummy_if)::set(null, "*", "vif", sb_if);
        run_test();
    end

endmodule