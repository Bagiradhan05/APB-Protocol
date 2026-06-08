//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb driver
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_DRIVER
`define _APB_DRIVER

class apb_driver;

   mailbox gen_drv;
   mailbox re_data;
   virtual apb_interface vif;
   apb_transaction transaction_h;

   int wait_count;

   function new(mailbox gen_drv,virtual apb_interface vif);
      this.vif=vif;
      this.gen_drv=gen_drv;
      transaction_h=new();
      re_data = new();
   endfunction:new

   task run();
      forever begin
         @(vif.master_cb);
         if(!vif.presetn||$isunknown(vif.presetn))begin
            reset_logic();
         end
         else begin
            if(re_data.num()>0)begin
               re_data.get(transaction_h);
            end
            else begin
               gen_drv.get(transaction_h);
            end
            driver_logic(transaction_h);
         end
      end
   endtask:run

   task reset_logic();
      do begin
      $display("entering reset logic");
      vif.paddr<=0;
      vif.pwrite<=0;
      vif.psel<=0;
      vif.penable<=0;
      vif.pwdata<=0;
      $display("finishing reset logic");
      @(vif.master_cb);
   end
      while(!vif.presetn||$isunknown(vif.presetn));

   endtask:reset_logic

   task driver_logic(apb_transaction transaction_h);
         transaction_h.display("Drv");

         //@(posedge vif.pclk);//one clock pulse delay
         //@(vif.master_cb);

        // //Idle state
        // $display("entered to idle state");
        // vif.master_cb.psel<=1'b0;
        // vif.master_cb.penable<=1'b0;


         @(vif.master_cb);

         if(!vif.presetn||$isunknown(vif.presetn))begin
         $display("after idle state");
         re_data.put(transaction_h);
         return;
         end
         else begin 
         //Setup state
         $display("entered to setup state");
         vif.master_cb.psel<=1'b1;
         vif.master_cb.penable<=1'b0;
         vif.master_cb.paddr<=transaction_h.paddr;
         vif.master_cb.pwdata<=transaction_h.pwdata;
         vif.master_cb.pwrite<=transaction_h.pwrite;
      end


         @(vif.master_cb);
         
         if(!vif.presetn||$isunknown(vif.presetn))begin
         re_data.put(transaction_h);
         $display("after setup state");
            return;
         end
         else begin

         $display("entered to access state");
         vif.master_cb.penable<=1'b1;

      end

         @(vif.master_cb);
      if(!vif.presetn||$isunknown(vif.presetn))begin
         re_data.put(transaction_h);
         $display("after access state");
         return;
      end
      else begin
      //   wait(vif.master_cb.pready);
     while(!vif.master_cb.pready)begin
      if(!vif.presetn||$isunknown(vif.presetn))begin
         re_data.put(transaction_h);
         $display("while pready logic");
         return;
      end
      else begin
         wait_count++;
         if(wait_count>=5&&!vif.pready)
            $fatal("wait coutn reached maximum %0d",wait_count);
         @(vif.master_cb);
      end
   end
      $display("reset occured at =%0d clock pulse %0d",wait_count,vif.pready);
      wait_count=0;

       end

         @(vif.master_cb);
         $display("Transaction completed");
         vif.master_cb.psel<=1'b0;
         vif.master_cb.penable<=1'b0;

   endtask:driver_logic
   
endclass:apb_driver

`endif
