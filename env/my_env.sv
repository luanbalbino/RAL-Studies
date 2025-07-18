typedef uvm_reg_predictor#(my_seq_item) timer_reg_predictor;

class my_env extends uvm_env;
    `uvm_component_utils(my_env)

    my_agent agent;

    timer_reg_predictor timer_pred;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    
        agent = my_agent::type_id::create("agent", this);
        timer_pred = timer_reg_predictor::type_id::create("timer_pred", this);
    
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        agent.timer_ap.connect(timer_pred.bus_in);
        timer_pred.adapter = agent.adapter;
    
    endfunction
    

endclass
