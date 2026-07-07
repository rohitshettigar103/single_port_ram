//`include "defines.sv"
class ram_scoreboard;
 
        transaction ref_scr_tr;

        transaction mon_scr_tr;
 
        mailbox #(transaction) mbx_ref_scr;

        mailbox #(transaction) mbx_mon_scr;
 
        logic [`DATA_WIDTH-1:0] ref_mem [`DATA_DEPTH-1:0];

        logic [`DATA_WIDTH-1:0] mon_mem [`DATA_DEPTH-1:0];
 
        int match = 0;

        int mismatch = 0;
 
        function new(

                mailbox #(transaction) mbx_mon_scr,

                mailbox #(transaction) mbx_ref_scr

        );

                this.mbx_ref_scr = mbx_ref_scr;

                this.mbx_mon_scr = mbx_mon_scr;

        endfunction
 
        task start();

		for(int i=0;i<`num_transaction;i++)begin

                        fork

                                begin

                                        mbx_ref_scr.get(ref_scr_tr);

                                        ref_mem[ref_scr_tr.addr] = ref_scr_tr.data_out;

                                        $display("###############################[REFERENCE -SCOREBOARD],time:%0t,data_out=%0h | address=%0h #####################",$time,ref_mem[ref_scr_tr.addr],ref_scr_tr.addr

                                        );

                                end

                                begin

                                        mbx_mon_scr.get(mon_scr_tr);

                                        mon_mem[mon_scr_tr.addr] = mon_scr_tr.data_out;

					$display("##################################[MONITOR TO SCOREBOARD],w=%d,r=%d,time:%0t,data_out=%0h | address=%0h####################",mon_scr_tr.w_en,mon_scr_tr.r_en,$time,mon_mem[mon_scr_tr.addr],mon_scr_tr.addr

                                        );

                                end

                        join
			if(i!=(`num_transaction-1))
 
                        compare_report();

                end

        endtask
 
        task compare_report();

                if(ref_mem[ref_scr_tr.addr] === mon_mem[mon_scr_tr.addr]) begin

                        $display("PASS:  [SCOREBOARD]",$time,"REF data_out=%0h | MON_data_out=%0h",

                             ref_mem[ref_scr_tr.addr],

                              mon_mem[mon_scr_tr.addr]

			);

                        ++match;

                        $display("[MATCH] count = %0d",match);

                end

                else begin

                        $display("FAIL:  [SCOREBOARD]",$time,"REF data_out=%0h | MON_data_out=%0h",

                             ref_mem[ref_scr_tr.addr],

                              mon_mem[mon_scr_tr.addr]

                        );

                        ++mismatch;

                        $display("[MISMATCH] count = %0d",mismatch);

                end

        endtask
 
endclass
 
