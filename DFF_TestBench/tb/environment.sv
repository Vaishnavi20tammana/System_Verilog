class environment;
  virtual dff_if vif;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sb;
  mailbox #(transaction) gen2driv = new();
  mailbox #(transaction) mon2sb = new();

  function new(virtual dff_if vif);
    this.vif = vif;
    gen = new(gen2driv);
    drv = new(vif, gen2driv);
    mon = new(vif, mon2sb);
    sb = new(vif, mon2sb);
  endfunction

  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
      sb.run();
    join_any
  endtask
endclass
