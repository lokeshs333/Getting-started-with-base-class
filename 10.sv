`include "uvm_macros.svh"
import uvm_pkg::*;

//////////////////////////////////////////////////
// Base UVM object.
//////////////////////////////////////////////////
class first extends uvm_object; 
  
  rand bit [3:0] data;
  
  function new(string path = "first");
    super.new(path);
  endfunction 
  
  // Register base object with the UVM factory
  `uvm_object_utils_begin(first)
    `uvm_field_int(data, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Derived object with an additional field.
//////////////////////////////////////////////////
class first_mod extends first;

  rand bit ack;
  
  function new(string path = "first_mod");
    super.new(path);
  endfunction 
  
  // Register derived object with the UVM factory
  `uvm_object_utils_begin(first_mod)
    `uvm_field_int(ack, UVM_DEFAULT)
  `uvm_object_utils_end
  
endclass

//////////////////////////////////////////////////
// Component that creates an object through the
// UVM factory.
//////////////////////////////////////////////////
class comp extends uvm_component;
  `uvm_component_utils(comp)
  
  first f;
  
  function new(string path = "second", uvm_component parent = null);
    super.new(path, parent);

    // Create object using the factory
    f = first::type_id::create("f");

    f.randomize();
    f.print();
  endfunction 
  
endclass

//////////////////////////////////////////////////
// Top-level testbench
// Overrides the base object with the derived
// object before factory creation.
//////////////////////////////////////////////////
module tb;
 
  comp c;
  
  initial begin
    // Override 'first' with 'first_mod'
    c.set_type_override_by_type(first::get_type, first_mod::get_type);

    // Create component through the factory
    c = comp::type_id::create("comp", null);
  end
  
endmodule
