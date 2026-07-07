//`include "defines.svh"
class ram_driver;
	transaction trans1;

	//mailbox for driver
	mailbox#(transaction) mbx_drv;

	//mailbox for reference model
	mailbox#(transaction) mbx_ref;

	//declaring of interface
	virtual inf.DRV vif;

	covergroup cg ;
		w_en1:coverpoint trans1.w_en{
			bins b_w={[0:1]};
		}
		r_en1:coverpoint trans1.r_en{
			bins b_r={[0:1]};
		}
		addr1:coverpoint trans1.addr{
			bins b_addr[3]={[0:31]};
		}
		data_in1:coverpoint trans1.data_in{
			bins b_data_in[3]={[0:255]};
		}
	endgroup


	function new(mailbox#(transaction)mbx_drv,mailbox#(transaction)mbx_ref,virtual inf.DRV vif);
		this.mbx_drv=mbx_drv;
		this.mbx_ref=mbx_ref;
		this.vif=vif;		cg=new();
	endfunction

	task start();
		repeat(3) @(vif.drv_cb);//just creating a delay

		for(int i=0;i<`num_transaction;i++)
		begin
			trans1 = new();
			mbx_drv.get(trans1);
if(vif.drv_cb.rst==0)
begin
	@(vif.drv_cb);
	vif.drv_cb.w_en<=0;
	vif.drv_cb.r_en<=0;
	vif.drv_cb.addr<=8'b0;
	vif.drv_cb.data_in<=8'bz;
	trans1.w_en=0;
	trans1.r_en=0;
	trans1.addr=0;
	trans1.data_in='z;
	mbx_ref.put(trans1);
			$display("Driving to interface");
			$display("data_in:%h,w_en:%b,r_en:%b,addr:%h",trans1.data_in,trans1.w_en,trans1.r_en,trans1.addr);
end
	else
	begin


			repeat(1)@(vif.drv_cb); //creates one delay
			vif.drv_cb.data_in<=trans1.data_in;
			vif.drv_cb.w_en<=trans1.w_en;
			vif.drv_cb.r_en<=trans1.r_en;
			vif.drv_cb.addr<=trans1.addr;
			//repeat(1)@(vif.drv_cb);
			$display("Driving to interface");
			$display("data_in:%h,w_en:%b,r_en:%b,addr:%h",trans1.data_in,trans1.w_en,trans1.r_en,trans1.addr);

			//now mailbox for reference model
			mbx_ref.put(trans1.copy());		cg.sample();

		end
end
	endtask
endclass





