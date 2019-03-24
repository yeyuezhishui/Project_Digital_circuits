`timescale 1ns / 1ps
module vendor(reset, clk_N, coin_type, coin_in, cancel_flag, drink_type, op_start,
open, hold_ind, coin_val, drinktk_ind, charge_ind, no_money, charge_val, charge_float, coin_float,
can_take,moore_state,over_flow,go,num1,num2,no_num
    );
    input [1:0] coin_type;//货币类型 
    input [1:0] drink_type;
    input go;
    input reset,clk_N,coin_in,cancel_flag,op_start;
    output reg [4:0] coin_val;
    output reg [4:0] charge_val;
    output reg charge_float;
    output reg coin_float;
    
    output reg [4:0] num1;
    output reg [4:0] num2;
    output reg no_num;
    
    output reg hold_ind;
    output reg open;//电源提示灯
    output reg [1:0] drinktk_ind;
    output reg charge_ind;
    output reg no_money;
    output reg can_take;
    output reg over_flow;
//    wire clk_N_2;
//    divider #(5000) my_diviver_2(clk_N,clk_N_2);
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5;
    output reg [3:0] moore_state;
    initial begin
        coin_val<=0;
        charge_val<=0;
        charge_float<=0;
        coin_float<=0;
        hold_ind<=0;
        open<=0;
        drinktk_ind<=0;
        charge_ind<=0;
        no_money<=0;
        can_take<=0;
        over_flow<=0;
        moore_state<=S0;
        num1<=5;
        num2<=5;
        no_num<=0;
    end
//    always @(posedge reset or posedge coin_in or posedge op_start or posedge cancel_flag) begin
    always @(posedge go) begin
            case(moore_state)
            S0:begin
                open<=1;
                hold_ind<=0;
                coin_val<=5'b00000;
                coin_float<=0;
                drinktk_ind<=2'b00;
                no_money<=0;
                can_take<=0;
                charge_val<=5'b00000;
                charge_float<=0;
                charge_ind<=0;
                over_flow<=0;
                no_num<=0;
                if(reset==0) begin
                    moore_state<=S0;
                    open<=0;
                    coin_val<=0;
                    charge_val<=0;
                    coin_float<=0;
                    charge_float<=0;
                    can_take<=0;
                    charge_ind<=0;
                    drinktk_ind<=0;
                    hold_ind<=0;
                end
                else if(coin_type==2'b01&&coin_in==1) begin
                    coin_val<=5'b00001;
                    hold_ind<=1;
                    charge_ind<=1;
                    moore_state<=S1;
                end
                else if(coin_type==2'b10&&coin_in==1) begin
                    coin_val<=5'b01010;
                    hold_ind<=1;
                    charge_ind<=1;
                    drinktk_ind<=2'b11;
                    moore_state<=S3;
                end
                else if(op_start==1) begin
                    if(num1==0 || num2==0) begin
                        no_num<=1;
                    end
                    no_money<=1;
                    moore_state<=S0;
                end
                else if(cancel_flag==1) begin
                    can_take<=0;
                    charge_val<=coin_val;
                    charge_float<=coin_float;
                    moore_state<=S0;
                end
                else moore_state<=S0;
            end
            S1:begin
                open<=1;
                hold_ind<=1;
                drinktk_ind<=2'b00;
                no_money<=0;
                can_take<=0;
                charge_val<=5'b00000;
                charge_float<=0;
                charge_ind<=1;
                over_flow<=0;
                no_num<=0;
                if(reset==0) begin
                    moore_state<=S1;
                    open<=0;
                    coin_val=coin_val;
                    coin_float=coin_float;
                    charge_val<=0;
                    charge_float<=0;
                    can_take<=0;
                    charge_ind<=0;
                    drinktk_ind<=0;
                    hold_ind<=0;
                end
                else if(coin_type==2'b01 && coin_in==1) begin
                    coin_val=coin_val+1;
                    if((coin_val==5'b00010 && coin_float==1)||coin_val>5'b00010) begin
                        drinktk_ind<=2'b01;
                        moore_state<=S2;
                    end
                    else moore_state<=S1;
                end
                else if(coin_type==2'b10&&coin_in==1) begin
                    coin_val=coin_val+5'b01010;
                    drinktk_ind<=2'b11;
                    moore_state<=S3;
                end
                else if(op_start==1) begin
                if(num1==0 || num2==0) begin
                    no_num<=1;
                end
                    no_money<=1;
                    moore_state<=S1;
                end
                else if(cancel_flag==1) begin
                    can_take<=0;
                    charge_val<=coin_val;
                    charge_float<=coin_float;
                    drinktk_ind<=2'b00;
                    hold_ind<=1;
                    charge_ind<=0;
                    moore_state<=S0;
                end
                else moore_state<=S1;
            end
            S2:begin
                open<=1;
                hold_ind<=1;
                drinktk_ind<=2'b01;
                no_money<=0;
                can_take<=0;
                charge_val<=5'b00000;
                charge_float<=0;  
                charge_ind<=1;
                over_flow<=0;
                no_num<=0;
                if(reset==0) begin
                    moore_state<=S2;
                    open<=0;
                    coin_val=coin_val;
                    charge_val<=0;
                    coin_float=coin_float;
                    charge_float<=0;
                    can_take<=0;
                    charge_ind<=0;
                    drinktk_ind<=0;
                    hold_ind<=0;
                end          
                else if(coin_type==2'b01&&coin_in==1) begin
                    coin_val=coin_val+5'b00001;
                    if(coin_val>=5'b00101) begin
                        drinktk_ind<=2'b11;
                        moore_state<=S3;
                    end
                    else moore_state<=S2;
                end
                else if(coin_type==2'b10&&coin_in==1) begin
                    coin_val=coin_val+5'b01010;
                    drinktk_ind<=2'b11;
                    moore_state<=S3;
                end
                else if(drink_type==2'b01&&op_start==1) begin
                    if(num1==0) begin
                        no_num<=1;
                        moore_state<=S2;
                    end
                    else begin
                    can_take<=1;
                    num1<=num1-1;
                    if(coin_float==1) begin
                        coin_val=coin_val-5'b00010;
                        coin_float=0;
                    end
                    else begin
                        coin_val=coin_val-5'b00011;
                        coin_float=1;
                    end
                    if(coin_val==0&&coin_float==0) begin
                        hold_ind<=0;
                        drinktk_ind<=2'b00;
                        charge_ind<=0;
                        moore_state<=S0;
                    end
                    else if(coin_val==0&&coin_float==1) begin
                        hold_ind<=0;
                        drinktk_ind<=2'b00;
                        charge_ind<=0;
                        moore_state<=S4;
                    end
                    else if(coin_val==1||(coin_val==2 && coin_float==0)) begin
                        drinktk_ind<=2'b00;
                        moore_state<=S1;
                    end
                    else moore_state<=S2;
                    end
                end
                else if(drink_type==2'b10&&op_start==1) begin
                    if(num2==0) begin
                        no_num<=1;
                    end
                    no_money<=1;
                    moore_state<=S2;
                end
                else if(cancel_flag==1) begin
                    can_take<=0;
                    charge_val<=coin_val;
                    charge_float<=coin_float;
                    hold_ind<=1;
                    drinktk_ind<=2'b00;
                    charge_ind<=0;
                    moore_state<=S0;
                end
                else moore_state<=S2;
            end
            S3:begin
                open<=1;
                hold_ind<=1;
                drinktk_ind<=2'b11;
                no_money<=0;
                can_take<=0;
                charge_val<=5'b00000;
                charge_float<=0;
                charge_ind<=1;
                over_flow<=0;
                no_num<=0;
                if(reset==0) begin
                    moore_state<=S3;
                    open<=0;
                    coin_val=coin_val;
                    charge_val<=0;
                    coin_float=coin_float;
                    charge_float<=0;
                    can_take<=0;
                    charge_ind<=0;
                    drinktk_ind<=0;
                    hold_ind<=0;
                end
                else if(coin_type==2'b01&&coin_in==1) begin
                    if((coin_val+5'b00001)>16) begin
                        coin_val<=coin_val;
                        coin_float<=coin_float;
                        over_flow<=1;
                        moore_state<=S3;
                    end
                    else coin_val=coin_val+5'b00001;
                    moore_state<=S3;
                end
                else if(coin_type==2'b10&&coin_in==1) begin
                    if((coin_val+10)>16) begin
                        coin_val=coin_val;
                        coin_float=coin_float;
                        over_flow<=1;
                        moore_state<=S3;
                    end 
                    else coin_val=coin_val+5'b01010;
                    moore_state<=S3;
                end
                else if(drink_type==2'b01&&op_start==1) begin
                    if(num1==0) begin
                        no_num<=1;
                        moore_state<=S3;
                    end
                    else begin
                    num1=num1-1;
                    can_take<=1;
                    if(coin_float==1) begin
                        coin_val=coin_val-5'b00010;
                        coin_float=0;
                    end
                    else begin
                        coin_val=coin_val-5'b00011;
                        coin_float=1;
                    end
                    if(coin_val==0&&coin_float==0) begin
                        hold_ind<=0;
                        drinktk_ind<=2'b00;
                        charge_ind<=0;
                        moore_state<=S0;
                    end
                    else if(coin_val==0&&coin_float==1) begin
                        coin_float=1;
                        coin_val=0;
                        drinktk_ind<=2'b00;
                        moore_state<=S4;
                    end
                    else if(coin_val==1||(coin_val==2&&coin_float==0)) begin
                        drinktk_ind<=2'b00;
                        moore_state<=S1;
                    end
                    else if(coin_val>=5)
                    begin
                        moore_state<=S3;
                    end
                    else begin
                        drinktk_ind<=2'b01;
                        moore_state<=S2;
                    end
                    end
                 end
                 else if(drink_type==2'b10&&op_start==1) begin
                    if(num2==0) begin
                        no_num<=0;
                        moore_state<=S3;
                    end
                    else begin
                    num2=num2-1;
                    can_take<=1;
                    coin_val=coin_val-5'b00101;
                    if(coin_val==0&&coin_float==0) begin
                        hold_ind<=0;
                        drinktk_ind<=2'b00;
                        charge_ind<=0;
                        moore_state<=S0;
                    end
                    else if(coin_val==0&&coin_float==1) begin
                        drinktk_ind<=2'b00;
                        moore_state<=S4;
                    end
                    else if(coin_val==1||(coin_val==2&&coin_float==0)) begin 
                        drinktk_ind<=2'b01;
                        moore_state<=S1;
                    end
                    else if(coin_val>=5) begin
                        moore_state<=S3;
                    end
                    else begin 
                        drinktk_ind<=2'b01;
                        moore_state<=S2;
                    end
                    end
                 end
                 else if(cancel_flag==1) begin
                    charge_val<=coin_val;
                    charge_float<=coin_float;
                    drinktk_ind<=2'b00;
                    hold_ind<=1;
                    charge_ind<=0;
                    moore_state<=S0;
                    can_take<=0;
                 end
                 else begin
                    moore_state<=S3;
                 end
                end      
                S4:begin
                    open<=1;
                    hold_ind<=1;
                    drinktk_ind<=2'b00;
                    no_money<=0;
                    can_take<=0;
                    charge_val<=5'b00000;
                    charge_float<=0;
                    charge_ind<=1;
                    over_flow<=0;
                    no_num<=0;
                    if(reset==0) begin
                        moore_state<=S4;
                        open<=0;
                        coin_val=coin_val;
                        charge_val<=0;
                        coin_float=coin_float;
                        charge_float<=0;
                        can_take<=0;
                        charge_ind<=0;
                        drinktk_ind<=0;
                        hold_ind<=0;
                    end
                    else if(coin_type==2'b01&&coin_in==1) begin
                        coin_val=coin_val+5'b00001;
                        if(coin_val>2||(coin_val==2&&coin_float==1)) begin
                            drinktk_ind<=2'b01;
                            moore_state<=S2;
                        end
                        else if(coin_val==1||(coin_val==2&&coin_float==0)) moore_state<=S1;
                        else begin 
                            moore_state<=S4;
                        end
                    end
                    else if(coin_type==2'b10&&coin_in==1) begin
                        coin_val=coin_val+5'b01010;
                        drinktk_ind<=2'b11;
                        moore_state<=S3;
                    end
                    else if(op_start==1) begin
                        if(num1==0 || num2==0) begin
                            no_num<=1;
                        end
                        no_money<=1;
                        moore_state<=S4;
                    end
                    else if(cancel_flag==1) begin
                        can_take<=0;
                        charge_val<=coin_val;
                        charge_float<=coin_float;
                        hold_ind<=1;
                        charge_ind<=0;
                        moore_state<=S0;
                    end
                    else moore_state<=S4;
                end
                S5:begin
//                    coin_val<=0;
//                    coin_float<=0;
                    moore_state<=S0;
                end
             default:moore_state<=moore_state;              
        endcase
    end
endmodule
