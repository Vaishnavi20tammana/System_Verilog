class driver;
  virtual dff_if vif;
  mailbox #(transaction) gen2driv;

  function new(virtual dff_if vif, mailbox #(transaction) gen2driv);
    this.vif = vif;
    this.gen2driv = gen2driv;
  endfunction

  task run();
    transaction tr;
    vif.cb_drv.reset <= 0;
    repeat (3) @(vif.cb_drv); // hold reset low for 2 cycles
    vif.cb_drv.reset <= 1;

    forever begin
      gen2driv.get(tr);
      vif.cb_drv.d <= tr.d;
      @(vif.cb_drv);
    end
  endtask
endclass
