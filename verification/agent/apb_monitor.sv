//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb monitor
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_MONITOR
`define _APB_MONITOR

class apb_monitor;

   virtual apb_interface vif;
   mailbox mon_sb;
   apb_transaction transaction_h;

   int waitcount;

   function new(virtual apb_interface vif,mailbox mon_sb);
      this.vif=vif;
      this.mon_sb=mon_sb;

      apb_cg=new();
   endfunction:new

   task run();
      forever begin
         @(vif.monitor_cb);
//            apb_cg.sample();//coverage sample

         if(vif.monitor_cb.psel&&vif.monitor_cb.penable)begin
      transaction_h=new();
         while(!vif.monitor_cb.pready)begin
            waitcount++;
            @(vif.monitor_cb);
         end
         if(waitcount>5)
            $fatal("timeout for pready");
         waitcount=0;
            
            transaction_h.paddr=vif.monitor_cb.paddr;
            transaction_h.pwdata=vif.monitor_cb.pwdata;
            transaction_h.pwrite=vif.monitor_cb.pwrite;
            transaction_h.prdata=vif.monitor_cb.prdata;
            transaction_h.pslverr=vif.monitor_cb.pslverr;

            apb_cg.sample();//coverage sample

            mon_sb.put(transaction_h);
            transaction_h.display("Mon");
            @(vif.monitor_cb);
         end
         else
//            apb_cg.sample();//coverage sample
            @(vif.monitor_cb);
      end
   endtask:run

   covergroup apb_cg;
      PADDR:coverpoint transaction_h.paddr{bins using[]={[13:30]};
                                           ignore_bins ig_s={[31:255]};
 //                                          illegal_bins il_s={0,4,8,12};
                                           bins error_occur={32'hffff_ffff};}
      PWDATA:coverpoint transaction_h.pwdata{bins data[]={[1:10]};}
      PWRITE:coverpoint transaction_h.pwrite { bins read={0};
                                           bins write={1};}
      PSEL:coverpoint transaction_h.psel { bins psel_on={1};
                                         bins psel_off={0};}
      PENABLE:coverpoint transaction_h.penable{ bins en_on={1};
                                           bins en_off={0};}
      PREADY:coverpoint transaction_h.pready{ bins wait_state={1};
                                          bins no_wait_state={0};}
                                            
      cross_1:cross PADDR,PWRITE;
      cross_2:cross PADDR,PWDATA;
   endgroup

endclass:apb_monitor

`endif
