interface dff_if(input logic clk);
  logic reset;
  logic d;
  logic q;

  // Clocking block for driving
  clocking cb_drv @(posedge clk);
    output d;
    output reset;
  endclocking

  // Clocking block for sampling
  clocking cb_mon @(posedge clk);
    input d, q, reset;
  endclocking

endinterface
