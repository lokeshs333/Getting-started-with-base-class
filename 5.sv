`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating copy and clone
// operations using field automation.
//////////////////////////////////////////////////
class first extends uvm_object; 
  
  rand bit [3:0] data;
  
  function new(string path = "first");
    super.new(path);
  endfunction 
  
  // Register field for copy, clone, compare and print
  `uvm_object_utils_begin(first)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Demonstrates object cloning.
// (Copy example is provided as commented code.)
//////////////////////////////////////////////////
module tb;

  first f;
  first s;

  /*
  // Copy example
  initial begin
    f = new("first");
    s = new("second");

    f.randomize();
    s.copy(f);

    f.print();
    s.print();
  end
  */

  initial begin
    f = new("first");

    // Randomize source object
    f.randomize();

    // Clone source object into destination
    $cast(s, f.clone());

    // Print both objects
    f.print();
    s.print();
  end

endmodule
