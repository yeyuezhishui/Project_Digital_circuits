`timescale 1ns / 1ps
module divider(clk,clk_N
    );
    input clk;
    output reg clk_N;
    parameter N=1_0000_0000;
    reg[31:0]counter;
    
    initial begin
        counter<=0;
        clk_N<=0;
    end
    
    always @(posedge clk) begin
        if(counter<(N/2-1)) begin
            counter<=counter+1'b1;
        end
        else begin
            counter<=0;
            clk_N<=!clk_N;
        end
    end
endmodule
