`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// UVM object demonstrating custom print and
// copy operations using do_print() and do_copy().
//////////////////////////////////////////////////
class obj extends uvm_object;
  `uvm_object_utils(obj)
  
  function new(string path = "obj");
    super.new(path);
  endfunction
  
  rand bit [3:0] a;
  rand bit [4:0] b;
   
  // Customize object printing
  virtual function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("a :", a, $bits(a), UVM_DEC);
    printer.print_field_int("b :", b, $bits(b), UVM_DEC);
  endfunction
  
  // Customize object copy
  virtual function void do_copy(uvm_object rhs);
    obj temp;

    // Cast source object to the correct type
    $cast(temp, rhs);

    super.do_copy(rhs);

    // Copy field values
    this.a = temp.a;
    this.b = temp.b;
  endfunction
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Randomizes one object, copies it to another,
// and prints both objects.
//////////////////////////////////////////////////
module tb;

  obj o1, o2;
  
  initial begin
    o1 = obj::type_id::create("o1");
    o2 = obj::type_id::create("o2");
    
    // Randomize source object
    o1.randomize();
    o1.print();

    // Copy source object
    o2.copy(o1);
    o2.print();
   
  end
 
endmodule





What this example demonstrates
do_print() customizes how object fields are displayed.
do_copy() defines how data is copied from one object to another.
$cast() safely converts the generic uvm_object handle (rhs) to the obj type.
super.do_copy(rhs) copies any base-class data before copying user-defined fields.
Calling o2.copy(o1) automatically invokes the overridden do_copy() method.
