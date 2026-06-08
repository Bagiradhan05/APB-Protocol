//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb read followed by write test
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_TEST
`define _APB_TEST

class apb_test;
   
   apb_env env;
   virtual apb_interface vif;

   function new(virtual apb_interface vif);
      this.vif=vif;
   endfunction:new
   
   task run();
      env=new(vif);
      env.agent_h.gen.count=10;
      env.run();
   endtask:run

endclass:apb_test

`endif
