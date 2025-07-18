interface dummy_if #(
    parameter int ADDR_WIDTH = 4, 
    parameter int DATA_WIDTH = 32
) (
    input logic clk,
    input logic rst_n
);

    logic req;              
    logic write;            
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] wdata;
    logic [DATA_WIDTH-1:0] rdata;
    logic ready;            

    modport DUT (
        input  clk, rst_n, req, write, addr, wdata,
        output rdata, ready
    );

    modport TB (
        input  clk, rst_n,
        output req, write, addr, wdata,
        input  rdata, ready
    );

endinterface
