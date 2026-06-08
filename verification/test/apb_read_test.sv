//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb read test
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_READ_TEST
`define _APB_READ_TEST

class apb_read_test;
   
   apb_env env;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
      this.vif=vif;
   endfunction:new

   task run();
      env=new(vif);
      env.agent_h.gen.count=10;
      env.agent_h.gen.write=0;
      env.agent_h.gen.error=0;
      env.run();
   endtask:run

endclass:apb_read_test

`endif
