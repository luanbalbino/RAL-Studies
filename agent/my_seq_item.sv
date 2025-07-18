class my_seq_item extends uvm_sequence_item;
    `uvm_object_utils(my_seq_item)

    rand bit [31:0] data;
    rand bit [31:0] addr;
    rand bit write;

    function new(string name = "my_seq_item");
        super.new(name);
    endfunction
endclass