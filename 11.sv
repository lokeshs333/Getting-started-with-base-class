`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating custom print behavior
// using the do_print() method.
//////////////////////////////////////////////////
class obj extends uvm_object;
  `uvm_object_utils(obj)
  
  function new(string path = "OBJ");
    super.new(path);
  endfunction
  
  bit [3:0] a = 4;
  string b = "UVM";
  real c   = 12.34;
  
  // Customize object printing
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    
    printer.print_field_int("a", a, $bits(a), UVM_HEX);
    printer.print_string("b", b);
    printer.print_real("c", c);
    
  endfunction
  
endclass  

//////////////////////////////////////////////////
// Top-level testbench
// Creates the object and prints its contents
// using the overridden do_print() method.
//////////////////////////////////////////////////
module tb;

  obj o;
  
  initial begin
    // Create object using the UVM factory
    o = obj::type_id::create("o");

    // Print object fields
    o.print();
  end
 
endmodule









// What this example demonstrates
// do_print() is a virtual method that allows customizing how an object is printed.
// super.do_print(printer) prints any fields handled by the base class before adding custom fields.
// print_field_int() prints a in hexadecimal (UVM_HEX).
// print_string() and print_real() print the string and real variables, respectively.
// Calling o.print() automatically invokes the overridden do_print() method.
