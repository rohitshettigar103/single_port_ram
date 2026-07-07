`define DATA_WIDTH 8
`define DATA_DEPTH 32

`define num_transaction 40

function integer log2(int n);
	begin
	log2=0;
	while (n>0)
	begin
		n=n>>1;
		log2++;
	end
	end
endfunction
parameter ADDR_WIDTH=log2(`DATA_DEPTH);







	
