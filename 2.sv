`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating field automation
// macros for printing object data.
//////////////////////////////////////////////////
class obj extends uvm_object;

  // `uvm_object_utils(obj)

  function new(string path = "obj");
    super.new(path);
  endfunction

  rand bit [3:0] a;
  rand bit [7:0] b;

  // Register fields with the UVM factory and printer
  `uvm_object_utils_begin(obj)
    `uvm_field_int(a, UVM_NOPRINT | UVM_BIN)
    `uvm_field_int(b, UVM_DEFAULT | UVM_DEC)
  `uvm_object_utils_end

endclass

//////////////////////////////////////////////////
// Top-level testbench
// Randomizes the object and prints its fields
// using the default UVM table printer.
//////////////////////////////////////////////////
module tb;

  obj o;
  
  initial begin
    o = new("obj");

    // Randomize object fields
    o.randomize();

    // Print registered fields in table format
    o.print(uvm_default_table_printer);
  end
  
endmodule
