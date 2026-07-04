`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating custom string
// conversion using convert2string().
//////////////////////////////////////////////////
class obj extends uvm_object;
  `uvm_object_utils(obj)
  
  function new(string path = "OBJ");
    super.new(path);
  endfunction
  
  bit [3:0] a = 4;
  string b = "UVM";
  real c   = 12.34;
  
  // Convert object contents into a formatted string
  virtual function string convert2string();

    string s = super.convert2string();

    s = {s, $sformatf("a : %0d ", a)};
    s = {s, $sformatf("b : %0s ", b)};
    s = {s, $sformatf("c : %0f ", c)};

    return s;
  endfunction
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Creates the object and displays its contents
// using convert2string().
//////////////////////////////////////////////////
module tb;

  obj o;
  
  initial begin
    // Create object using the UVM factory
    o = obj::type_id::create("o");

    // Print object as a formatted string
    `uvm_info("TB_TOP", $sformatf("%0s", o.convert2string()), UVM_NONE);

    // Equivalent using $display
    // $display("%0s", o.convert2string());
  end
 
endmodule




What this example demonstrates
convert2string() is overridden to define a custom string representation of the object.
super.convert2string() retrieves the base class string before appending user-defined fields.
$sformatf() formats each field and concatenates it to the output string.
Calling convert2string() returns a single formatted string, which can be printed using uvm_info or $display.
Unlike do_print(), convert2string() returns a string instead of directly printing the object.
