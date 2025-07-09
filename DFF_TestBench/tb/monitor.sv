class monitor;
  virtual dff_if vif;
  mailbox #(transaction) mon2sb;

  function new(virtual dff_if vif, mailbox #(transaction) mon2sb);
    this.vif = vif;
    this.mon2sb = mon2sb;
  endfunction

  task run();
    transaction tr;
    logic d_prev = 0;

    forever begin
      @(vif.cb_mon);
      tr = new();
      tr.d = vif.cb_mon.d;
      tr.q = vif.cb_mon.q;
      d_prev = vif.cb_mon.d;
      
      tr.q_expected = (vif.cb_mon.reset == 0) ? 0 : d_prev;
      mon2sb.put(tr);
    end
  endtask
endclass
