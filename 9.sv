`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating factory-based object
// creation using type_id::create().
//////////////////////////////////////////////////
class first extends uvm_object; 
  
  rand bit [3:0] data;
  
  function new(string path = "first");
    super.new(path);
  endfunction 
  
  // Register object and field with the UVM factory
  `uvm_object_utils_begin(first)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Creates objects through the UVM factory,
// randomizes them, and prints their contents.
//////////////////////////////////////////////////
module tb;
 
  first f1, f2;
  
  initial begin
    // Create objects using the UVM factory
    f1 = first::type_id::create("f1");
    f2 = first::type_id::create("f2");
     
    // Randomize object fields
    f1.randomize();
    f2.randomize();
     
    // Print object contents
    f1.print();
    f2.print();
  end
  
endmodule
