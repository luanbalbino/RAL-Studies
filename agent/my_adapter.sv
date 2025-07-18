// my_adapter.sv
class my_adapter extends uvm_reg_adapter;
    `uvm_object_utils(my_adapter)

    function new(string name = "my_adapter");
        super.new(name);
    endfunction

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        my_seq_item tr;
        tr = my_seq_item::type_id::create("tx");

        tr.write = (rw.kind == UVM_WRITE);
        tr.addr  = rw.addr;
        tr.data  = rw.data;

        return tr;
    endfunction : reg2bus

    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        my_seq_item tx;

        assert($cast(tx, bus_item))
            else `uvm_fatal("CAST_FAILED", "Failed to cast from generic uvm_sequence_item to bus_item in my_adapter. Check sequence and item types.")

            rw.kind = tx.write ? UVM_WRITE : UVM_READ;
        rw.addr = tx.addr;
        rw.data = tx.data;

        rw.status = UVM_IS_OK;
    endfunction : bus2reg
endclass