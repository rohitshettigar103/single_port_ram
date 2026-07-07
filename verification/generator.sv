//`include "defines.svh"
class ram_generator;
	transaction trans;
	mailbox #(transaction) mbx1;

	function new(mailbox#(transaction)mbx1);
		this.mbx1=mbx1;
		trans=new();
	endfunction

	task start();
		repeat(`num_transaction)
		begin
			assert(trans.randomize());
			mbx1.put(trans.copy());//if we just pass handle trans then all mailbox is pointing to one object so to overcome this we are creatinf 							a copy and passing it inside mailbox
			$display("Generated values");
			$display("data_in:%d,w_en:%d,r_en:%d,addr:%d",trans.data_in,trans.w_en,trans.r_en,trans.addr);
		end
	endtask
endclass


