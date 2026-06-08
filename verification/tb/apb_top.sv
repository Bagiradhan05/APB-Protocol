//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb top module
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_TOP
`define _APB_TOP

//`include "apb_interface.sv"
//`include "apb_slave_design.sv"
//`include "apb_transcation.sv"
//`include "apb_generator.sv"
//`include "apb_driver.sv"
//`include "apb_monitor.sv"
//`include "apb_scoreboard.sv"
//`include "apb_env.sv"
//`include "apb_agent.sv"
//`include "apb_test.sv"
//`include "apb_read_test.sv"
//`include "apb_write_test.sv"

import apb_test_package::*;


module apb_top();

reg pclk,presetn;
apb_interface intf_h(pclk,presetn);
apb_slave dut(intf_h);
apb_test test_h;
apb_write_test w_test;
apb_read_test r_test;
apb_error_test e_test;



always #5 pclk=~pclk;

initial begin
   pclk=0;
   presetn=1;
   #3 presetn=0;
   #10 presetn=1;

   #200 presetn = 0;
   #50 presetn = 1;
  // #50 presetn=0;
  // #60 presetn=1;
//   #50 presetn=1'bx;
   #1000 $finish();
end

initial begin
test_h=new(intf_h);
   test_h.run();
//w_test=new(intf_h);
//   w_test.run();
//r_test=new(intf_h);
//   r_test.run();
//e_test=new(intf_h);
//   e_test.run();
end

endmodule:apb_top

`endif
