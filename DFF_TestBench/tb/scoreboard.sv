class scoreboard;
  virtual dff_if vif;
  mailbox #(transaction) mon2sb;

  function new(virtual dff_if vif, mailbox #(transaction) mon2sb);
    this.vif = vif;
    this.mon2sb = mon2sb;
  endfunction

  task run();
    transaction tr;
    forever begin
      mon2sb.get(tr);
      if (vif.q !== tr.q_expected)
        $display("ERROR: D=%b, Q=%b, expected=%b", tr.d, vif.q, tr.q_expected);
      else
        $display("PASS : D=%b, Q=%b", tr.d, vif.q);
    end
  endtask
endclass
