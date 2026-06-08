//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb write test
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_WRITE_TEST
`define _APB_WRITE_TEST

class apb_write_test;
   
   apb_env env;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
      this.vif = vif;
   endfunction:new

   task run();
      env=new(vif);
      env.agent_h.gen.count=10;
      env.agent_h.gen.write=1;
      env.run();
   endtask:run

endclass:apb_write_test

`endif
