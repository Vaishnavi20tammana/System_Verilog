class generator;
  transaction tr;
  mailbox #(transaction) gen2driv;

  function new(mailbox #(transaction) gen2driv);
    this.gen2driv = gen2driv;
  endfunction

  task run();
    repeat (20) begin
      tr = new();
      tr.randomize();
      gen2driv.put(tr);
    end
  endtask
endclass
