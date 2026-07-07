//`include "defines.svh"
class ram_reference;

        transaction trans_ref;

        mailbox#(transaction)mbx_drv;
        mailbox#(transaction)mbx_scr;

        virtual inf.REF vif;

        reg [`DATA_WIDTH-1:0]mem_ref[`DATA_DEPTH-1:0];

        function new(mailbox#(transaction) mbx_ref,mailbox#(transaction) mbx_scr,virtual inf.REF vif);
		                this.mbx_drv=mbx_drv;
		                this.mbx_scr=mbx_scr;
		                this.vif=vif;
		        endfunction


			        task start();
					repeat(`num_transaction)
					begin
						trans_ref=new();
						mbx_drv.get(trans_ref);

						repeat(1)@(vif.ref_cb)
						begin
							if(trans_ref.w_en)
							begin
								mem_ref[trans_ref.addr]=trans_ref.data_in;
							$display("data into memory mem[%h]=%h",trans_ref.addr,trans_ref.data_in);
							end
							if(trans_ref.r_en)
							begin
								trans_ref.data_out=mem_ref[trans_ref.addr];
								$display("data out at addr:%h,data_out:%h",trans_ref.addr,trans_ref.data_out);
							end

							mbx_scr.put(trans_ref);
						end
					end
				endtask
endclass


