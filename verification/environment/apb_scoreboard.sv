//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb scoreboard
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_SCOREBOARD
`define _APB_SCOREBOARD

class apb_scoreboard;

   apb_transaction transaction_h;
   mailbox mon_sb;

//   int mem[int];
   bit [31:0]mem[bit[31:0]];

   function new(mailbox mon_sb);
      this.mon_sb=mon_sb;
   endfunction

   task run();
      forever begin
         transaction_h=new();
         mon_sb.get(transaction_h);
         $display("transactionn recieved");

         if(transaction_h.pslverr)begin
            $fatal("slave error -> error%0d",transaction_h.paddr);
            continue;
         end
         if(transaction_h.pwrite)begin
            mem[transaction_h.paddr]=transaction_h.pwdata;
         end
         else begin
          if(mem.exists(transaction_h.paddr))begin
               $warning("read from uninitialised");
               continue;
            end
            if(mem[transaction_h.paddr]===transaction_h.prdata)begin
    
               $display("pass");
            end
            else begin
               $display("fail");
            end
      end
   end
   endtask:run

endclass:apb_scoreboard

`endif
