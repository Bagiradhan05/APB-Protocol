//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb transcation
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_TRANSACTION
`define _APB_TRANSACTION

class apb_transaction;

   //control signal
        bit       psel;
        bit       penable;
        bit       pready;

   //side band siganls
   rand bit [31:0]paddr;
   rand bit       pwrite;
   rand bit [31:0]pwdata;
        bit [31:0]prdata;
        bit       pslverr;

        constraint c_paddr{paddr inside{[13:30]};}
        constraint c_pwdata{pwdata inside{[1:10]};}

   //display statement
   function void display(string name);
      $display($time,"[%s]: paddr=%0d, pwdata=%0d, pwrite=%0d, prdata=%0d",name,paddr,pwdata,pwrite,prdata);
   endfunction:display

endclass:apb_transaction

`endif
