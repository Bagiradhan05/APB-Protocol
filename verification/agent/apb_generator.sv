//***************************************//
//
// Author     :BAGIRADHAN S
// e-mail     :bagiradhansrinivasan@gmail.com
// Project    :APB protocol
// Description:This file is implements the apb generator
// Date       :04/03/2026
//
//***************************************//

`ifndef _APB_GENERATOR
`define _APB_GENERATOR

class apb_generator;

   apb_transaction packet;
   mailbox gen_drv;

   int count;
   bit write;
   bit error;
   bit mode;
   int i;

   function new(mailbox gen_drv);
      this.gen_drv=gen_drv;
   endfunction:new

   task run();
      repeat(count)begin
         packet=new();
        if(write&&!error)begin
           packet.randomize()with{pwrite==1;};
           gen_drv.put(packet);
        end
        else if(!write&&!error)begin
           packet.randomize()with{pwrite==0;};
           gen_drv.put(packet);
        end
        else if(mode&&error)begin
           packet.randomize()with{paddr==32'hffff_ffff;};
           gen_drv.put(packet);
        end
        else begin
         packet.randomize()with{pwrite==(i%2);};
         gen_drv.put(packet);
        end
            packet.display("gen");
        i++;
      end
   endtask:run

endclass:apb_generator

`endif
