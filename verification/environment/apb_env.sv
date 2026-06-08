//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb environment
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_ENV
`define _APB_ENV

class apb_env;
   mailbox mon_sb;
   apb_scoreboard sb;
   apb_agent agent_h;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
      this.vif=vif;
      mon_sb=new();
      agent_h=new(vif,mon_sb);
      sb=new(mon_sb);
   endfunction:new

   task run();
      fork
         agent_h.run();
         sb.run();
      join
   endtask:run

endclass:apb_env

`endif
