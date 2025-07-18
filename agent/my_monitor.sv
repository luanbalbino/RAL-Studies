class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)

    virtual dummy_if vif;
    uvm_analysis_port #(my_seq_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual dummy_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface 'vif' not set for monitor!");
        end
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            @(posedge vif.clk);

            wait (vif.req == 1);

            if (vif.req && vif.ready) begin
                my_seq_item tx;
                tx = new();
                tx.write = vif.write;
                tx.addr  = vif.addr;
                
                tx.data = vif.write ? vif.wdata : vif.rdata;
                
                ap.write(tx);
            end

            @(posedge vif.clk);
            wait (vif.req == 0);
        end
    endtask
endclass
