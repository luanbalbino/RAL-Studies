class my_driver extends uvm_driver #(my_seq_item);
    `uvm_component_utils(my_driver)

    virtual dummy_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual dummy_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_type_name(), "Virtual interface 'vif' not set for driver!");
        end
    endfunction

    task run_phase(uvm_phase phase); 
    
        forever begin
            seq_item_port.get_next_item(req);
        
            vif.req   <= 1;
            vif.write <= req.write;
            vif.addr  <= req.addr;
            vif.wdata <= req.data;
        
            @(posedge vif.clk);
            wait (vif.ready == 1);
        
            if (!req.write) begin 
                req.data = vif.rdata;
            end
        
            vif.req <= 0;
        
            @(posedge vif.clk);
        
            seq_item_port.item_done();
        end
    
    endtask

    
endclass
