`include "dff_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module test_top;
  logic clk;
  dff_if vif(clk);

  dff dut (
    .clk(clk),
    .reset(vif.reset),
    .d(vif.d),
    .q(vif.q)
  );

  environment env;

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, test_top);

    env = new(vif);
    env.run();
    #200 $finish;
  end
endmodule
