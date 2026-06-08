//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb agent
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_AGENT
`define _APB_AGENT

class apb_agent;

   apb_generator gen;
   apb_driver drv;
   apb_monitor mon;
   mailbox gen_drv;
   mailbox mon_sb;
   virtual apb_interface vif;

   function new(virtual apb_interface vif,mailbox mon_sb);
      this.vif=vif;
      this.mon_sb=mon_sb;
      gen_drv=new();
      gen=new(gen_drv);
      drv=new(gen_drv,vif);
      mon=new(vif,mon_sb);
   endfunction:new

   task run();
      fork
         gen.run();
         drv.run();
         mon.run();
      join
   endtask:run

endclass:apb_agent

`endif
