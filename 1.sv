`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object with a randomizable 4-bit variable.
//////////////////////////////////////////////////
class obj extends uvm_object;
  `uvm_object_utils(obj)

  function new(string path = "obj");
    super.new(path);
  endfunction

  rand bit [3:0] a;   // Random variable

endclass

//////////////////////////////////////////////////
// Top-level testbench
// Creates the object, randomizes it, and prints
// the generated value.
//////////////////////////////////////////////////
module tb;

  obj o;
  
  initial begin
    o = new("obj");

    // Generate a random value for 'a'
    o.randomize();

    // Display randomized value
    `uvm_info("TB_TOP", $sformatf("Value of a : %0d", o.a), UVM_NONE);
  end
  
endmodule
