`include "defines.svh"
class transaction;
	rand logic w_en;
	rand logic r_en;
	rand logic [`DATA_WIDTH-1:0]data_in;
	rand logic [`DATA_WIDTH-1:0]data_out;
	rand logic [ADDR_WIDTH-1:0]addr;

	constraint c1{
		{w_en,r_en} inside {[0:2]};
	}

	virtual function transaction copy();
		copy=new;
		copy.data_in=this.data_in;
		copy.w_en=this.w_en;
		copy.r_en=this.r_en;
		copy.addr=this.addr;
		return copy;
	endfunction
endclass



