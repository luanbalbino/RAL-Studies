class base_test extends uvm_test;
    `uvm_component_utils(base_test)

    my_env env;
    reg_test_block reg_block;

    function new(string name = "base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        reg_block = reg_test_block::type_id::create("reg_block", this);
        reg_block.build();

        env = my_env::type_id::create("env", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    
        env.timer_pred.map = reg_block.default_map;
        reg_block.default_map.set_sequencer(.sequencer(env.agent.sequencer), .adapter(env.agent.adapter) );
        reg_block.default_map.set_base_addr('0);      
    endfunction : connect_phase

    function void report_phase(uvm_phase phase);
        int fatals, errors, warnings, infos; 
        string status;

        uvm_report_server svr;
        super.report_phase(phase);
        svr = uvm_report_server::get_server();
        
        fatals = svr.get_severity_count(UVM_FATAL);
        errors = svr.get_severity_count(UVM_ERROR);
        warnings = svr.get_severity_count(UVM_WARNING);
        infos = svr.get_severity_count(UVM_INFO);
    
        status = (fatals + errors > 0) ? "FAILED" : "PASSED";
    
        `uvm_info(get_type_name(), "\n==================== TEST SUMMARY ====================", UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("STATUS     : %s", status), UVM_NONE)
        `uvm_info(get_type_name(), "------------------------------------------------------", UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("UVM_FATAL  : %0d", fatals), UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("UVM_ERROR  : %0d", errors), UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("UVM_WARNING: %0d", warnings), UVM_NONE)
        `uvm_info(get_type_name(), $sformatf("UVM_INFO   : %0d", infos), UVM_NONE)
        `uvm_info(get_type_name(), "======================================================\n", UVM_NONE)
        
    endfunction
    
endclass
