class my_seq extends uvm_sequence;
    `uvm_object_utils(my_seq)
  
    reg_test_block reg_block;
  
    function new(string name = "my_seq");
      super.new(name);
    endfunction
  
    virtual task body();
      uvm_status_e   status;
      uvm_reg_data_t write_data, read_data;
  
      if (starting_phase != null)
        starting_phase.raise_objection(this);

      `uvm_info(get_name(), "Reseting the model...", UVM_LOW)
      reg_block.reset();
  
      `uvm_info(get_name(), "Init operation...", UVM_LOW)
  
      // CTRL
      write_data = 32'hA5A5_0001;
      reg_block.ctrl.write(status, write_data, .path(UVM_FRONTDOOR));
      reg_block.ctrl.read(status, read_data, .path(UVM_FRONTDOOR));
      compare("CTRL", write_data, read_data);
  
      // LOAD
      write_data = 32'h5A5A_FFFF;
      reg_block.load.write(status, write_data, .path(UVM_FRONTDOOR));
      reg_block.load.read(status, read_data, .path(UVM_FRONTDOOR));
      compare("LOAD", write_data, read_data);
  
      // STATUS
      write_data = 32'hCAFEBABE;
      reg_block.status.write(status, write_data, .path(UVM_FRONTDOOR));
      reg_block.status.read(status, read_data, .path(UVM_FRONTDOOR));
      compare("STATUS", write_data, read_data);
  
      if (starting_phase != null)
        starting_phase.drop_objection(this);
    endtask

    task compare(string name, uvm_reg_data_t expected, uvm_reg_data_t received);
      if (expected !== received)
        `uvm_error({name, "_MISMATCH"}, $sformatf("Expected: 0x%08X, Read: 0x%08X", expected, received))
      else
        `uvm_info({name, "_OK"}, $sformatf("%s = 0x%08X OK", name, received), UVM_LOW)
    endtask
  
  endclass
  