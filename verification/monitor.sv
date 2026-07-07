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
		repeat(4) @(vif.mon_cb);
		repeat(`num_transaction)
		begin
			trans2=new();
			@(vif.mon_cb);
		
			trans2.data_out=vif.mon_cb.data_out;
			trans2.addr=vif.mon_cb.addr;
			trans2.w_en=vif.mon_cb.w_en;
			trans2.r_en=vif.mon_cb.r_en;
			//trans2.rst=vif.mon_cb.rst;

			$display("moitor passing value");
			$display("data_out:%h",trans2.data_out);
			mbx_mon.put(trans2);

		end
	endtask
endclass
		
