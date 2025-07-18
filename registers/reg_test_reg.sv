`include "uvm_macros.svh"
import uvm_pkg::*;
class reg_test_reg extends uvm_reg;
	`uvm_object_utils(reg_test_reg)

	rand uvm_reg_field m_reg;
	
	function new(string name = "reg_test_reg");
		super.new(.name(name), .n_bits(32), .has_coverage(UVM_NO_COVERAGE));
	endfunction
	
	virtual function void build();
			m_reg = uvm_reg_field::type_id::create("m_reg");
			m_reg.configure(
				.parent(this),
				.size(32),
				.lsb_pos(0),
				.access("RW"),
				.volatile(0),
				.reset(16'hFFFF),
				.has_reset(1),
				.is_rand(1),
				.individually_accessible(1)
			);
	endfunction
	
endclass
	