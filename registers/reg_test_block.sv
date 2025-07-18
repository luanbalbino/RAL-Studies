`include "uvm_macros.svh"
import uvm_pkg::*;
class reg_test_block extends uvm_reg_block;
	`uvm_object_utils(reg_test_block)

	reg_test_reg ctrl;
	reg_test_reg load;
	reg_test_reg status;

	uvm_reg_map default_map;

	function new(string name = "reg_test_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction

	virtual function void build();
		ctrl   = reg_test_reg::type_id::create("ctrl");
		ctrl.build();
		ctrl.configure(this);
		
		load   = reg_test_reg::type_id::create("load");
		load.build();
		load.configure(this);
		
		status = reg_test_reg::type_id::create("status");
		status.build();
		status.configure(this);

		default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN);

		default_map.add_reg(ctrl,   4'h0, "RW");
		default_map.add_reg(load,   4'h4, "RW");
		default_map.add_reg(status, 4'h8, "RW");

		lock_model();
	endfunction

endclass
	