`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// Parent object containing a randomizable field.
//////////////////////////////////////////////////
class parent extends uvm_object;
  
  function new(string path = "parent");
    super.new(path);
  endfunction 
  
  rand bit [3:0] data;

  // Register the data field for UVM automation
  `uvm_object_utils_begin(parent)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Child object containing another UVM object.
//////////////////////////////////////////////////
class child extends uvm_object;
  
  parent p;
  
  function new(string path = "child");
    super.new(path);
    p = new("parent");   // Create parent object
  endfunction 

  // Register the parent object for UVM automation
  `uvm_object_utils_begin(child)
    `uvm_field_object(p, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Randomizes the parent object and prints the
// complete child object hierarchy.
//////////////////////////////////////////////////
module tb;

  child c;
  
  initial begin
    c = new("child");

    // Randomize the parent object
    c.p.randomize();

    // Print child and nested parent object
    c.print();
  end
  
endmodule
