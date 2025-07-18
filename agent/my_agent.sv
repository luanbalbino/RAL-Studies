// my_agent.sv
class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)

    typedef uvm_sequencer#(my_seq_item) my_sequencer;

    my_driver driver;
    my_monitor monitor;
    my_sequencer sequencer;
    my_adapter adapter;

    uvm_analysis_port#(my_seq_item) timer_ap;

    virtual dummy_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        timer_ap = new(.name("timer_ap"), .parent(this));

        if (!uvm_config_db#(virtual dummy_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for my_agent");

        if(get_is_active() == UVM_ACTIVE) begin 
            sequencer = my_sequencer::type_id::create("sequencer", this);
            driver = my_driver::type_id::create("driver", this);
        end
        monitor = my_monitor::type_id::create("monitor", this);

        adapter = my_adapter::type_id::create("adapter", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if(get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
        monitor.ap.connect(timer_ap);
    endfunction
endclass