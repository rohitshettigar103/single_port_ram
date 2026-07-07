`include "defines.svh"
class transaction;
	rand logic w_en;
//	bit rst=1;
	rand logic r_en;
	rand logic [`DATA_WIDTH-1:0]data_in;
	     logic [`DATA_WIDTH-1:0]data_out;
	rand logic [ADDR_WIDTH-1:0]addr;

	constraint c1{
		{w_en,r_en} inside {[0:2]};
		addr inside{[0:31]};
		//w_en!=r_en;
	}

	virtual function transaction copy();
		copy=new;
		copy.data_in=this.data_in;
		copy.w_en=this.w_en;
		copy.r_en=this.r_en;
		copy.addr=this.addr;
//		copy.rst=this.rst;
		return copy;
	endfunction
endclass



