`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object with a randomizable field used for
// object comparison.
//////////////////////////////////////////////////
class first extends uvm_object; 
  
  rand bit [3:0] data;
  
  function new(string path = "first");
    super.new(path);
  endfunction 
  
  // Register field for UVM automation
  `uvm_object_utils_begin(first)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Demonstrates object copy followed by compare().
//////////////////////////////////////////////////
module tb;
 
  first f1, f2;
  int status = 0;
  
  initial begin
    f1 = new("f1");
    f2 = new("f2");

    // Randomize source object
    f1.randomize();

    // Copy data to destination object
    f2.copy(f1);

    // Print both objects
    f1.print();
    f2.print();

    // Compare both objects
    status = f1.compare(f2);

    $display("Value of status : %0d", status);
  end
  
endmodule
