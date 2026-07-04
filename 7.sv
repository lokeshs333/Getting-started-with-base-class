`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object containing a randomizable data field.
//////////////////////////////////////////////////
class first extends uvm_object; 
  
  rand bit [3:0] data;
  
  function new(string path = "first");
    super.new(path);
  endfunction 
  
  // Register data field for UVM automation
  `uvm_object_utils_begin(first)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// UVM object containing a nested object.
//////////////////////////////////////////////////
class second extends uvm_object;
  
  first f;
  
  function new(string path = "second");
    super.new(path);
    f = new("first");
  endfunction 
  
  // Register nested object for deep copy support
  `uvm_object_utils_begin(second)
    `uvm_field_object(f, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Demonstrates deep copy using clone().
// (copy() can also be used for deep copy.)
//////////////////////////////////////////////////
module tb;
 
  second s1, s2;
  
  initial begin
    s1 = new("s1");

    // Randomize nested object
    s1.f.randomize();

    // Deep copy using copy()
    // s2.copy(s1);

    // Deep copy using clone()
    $cast(s2, s1.clone());

    // Print both objects
    s1.print();
    s2.print();

    // Modify cloned object
    s2.f.data = 12;

    // Original object remains unchanged
    s1.print();
    s2.print();
  end
  
endmodule
