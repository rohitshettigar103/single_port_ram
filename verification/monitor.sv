//`include "defines.svh"
class ram_monitor;
	transaction trans2;

	mailbox#(transaction) mbx_mon;

	virtual inf.MON vif;

	function new(mailbox#(transaction)mbx_mon,virtual inf.MON vif);
		this.mbx_mon=mbx_mon;
		this.vif=vif;
	endfunction


	task start();
		repeat(3) @(vif.mon_cb);

		repeat(`num_transaction)
		begin
			trans2=new();
			repeat(1)@(vif.mon_cb)
			begin
			trans2.data_out=vif.mon_cb.data_out;
			end
			$display("moitor passing value");
			$display("data_out:%h",trans2.data_out);
			mbx_mon.put(trans2);
			repeat(1)@(vif.mon_cb);

		end
	endtask
endclass
		
