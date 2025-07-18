module dummy_dut #(parameter WIDTH = 32)(
    input  logic              clk,
    input  logic              rst_n,
    input  logic              req,
    input  logic              write,
    input  logic [3:0]        addr,
    input  logic [WIDTH-1:0]  wdata,
    output logic [WIDTH-1:0]  rdata,
    output logic              ready
);

    localparam CTRL_ADDR   = 4'h0;
    localparam LOAD_ADDR   = 4'h4;
    localparam STATUS_ADDR = 4'h8;

    logic [WIDTH-1:0] ctrl;
    logic [WIDTH-1:0] load;
    logic [WIDTH-1:0] status;

    assign ready = req;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ctrl   <= '0;
            load   <= '0;
            status <= '0;
        end else if (req && write) begin
            case (addr)
                CTRL_ADDR:   ctrl   <= wdata;
                LOAD_ADDR:   load   <= wdata;
                STATUS_ADDR: status <= wdata;
            endcase
        end
    end

    always_comb begin
        case (addr)
            CTRL_ADDR:   rdata = ctrl;
            LOAD_ADDR:   rdata = load;
            STATUS_ADDR: rdata = status;
            default:     rdata = 'hDEADBEEF;
        endcase
    end

    always_ff @(posedge clk) begin
        if (req && write)
          $display("[DUT] write @%0t addr=%0h data=%0h", $time, addr, wdata);
      end
      
      always_ff @(posedge clk) begin
        if (req && !write)
          $display("[DUT] read @%0t addr=%0h => %0h", $time, addr, rdata);
      end

endmodule
