class functional_test extends base_test;
    `uvm_component_utils(functional_test)

    my_seq seq;

    function new(string name = "functional_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        seq = my_seq::type_id::create("seq", this);
    endfunction

    task run_phase(uvm_phase phase);
		
		phase.raise_objection(this);
		if ( !seq.randomize() ) begin 
            `uvm_error("FUNCTIONAL TEST", "Randomize failed")
        end

		seq.reg_block      = reg_block;
		seq.starting_phase = phase;

		seq.start(env.agent.sequencer); 
		
        phase.drop_objection(this);
	endtask

endclass
