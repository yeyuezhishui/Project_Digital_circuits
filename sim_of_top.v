`timescale 1ns / 1ps
module sim_of_top;
    reg[1:0] coin_type;
    reg[1:0] drink_type;
    reg coin_in,reset,op_start,clk,cancel_flag;
    wire [4:0] coin_val,charge_val;
    wire coin_float,charge_float;
    wire clk_N;
    wire hold_ind,charge_ind,open,no_money,can_take;
    wire [1:0] drinktk_ind;
    wire [7:0] LED0,LED1,LED2,LED3,LED4,LED5,LED6;
    wire [3:0] moore_state;
    wire over_flow;
    wire [7:0] AN;
    wire [7:0] SEG;
    wire [4:0] num1;
    wire [4:0] num2;
    wire no_num;
    top mytop1(reset, clk_N, coin_type, coin_in, cancel_flag, drink_type, op_start,
    open, hold_ind, coin_val, drinktk_ind, charge_ind, no_money, charge_val, charge_float, coin_float,can_take,clk,LED0,LED1,LED2,LED3,LED4
      , LED5,LED6 ,moore_state,over_flow,AN,SEG,go,num1,num2,no_num);
    always #5 clk = ~clk;
    initial begin
        clk=0;
        reset=0;
        op_start=0;
        coin_in=0;
        cancel_flag=0;
        drink_type=2'b01;
        coin_type=2'b01;
        #5 reset=1;
        #40 coin_in=1;//连续投币3次，此时有3元
        #40 coin_in=0;
        #40 coin_in=1;
        #40 coin_in=0;
        #40 coin_in=1;
        #40 coin_in=0;
        #40 op_start=1;//买2.5元的饮料，余额0.5元。2.5元饮料剩4瓶
        #40 op_start=0;
        #40 coin_type=2'b10;
        #40 coin_in=1;//投币10元，余额10.5元
        #40 coin_in=0;
        #40 drink_type=2'b10;
        #40 op_start=1;//买5元饮料，余额5.5元。5元饮料剩4瓶
        #40 op_start=0;
        #40 drink_type=2'b01;
        #40 op_start=1;//买2.5元饮料,余额3元。2.5元剩3瓶
        #40 op_start=0;
        #40 drink_type=2'b10; 
        #40 op_start=1;//买5元饮料，余额不足
        #40 op_start=0;
        #40 reset=0;
        #40 reset=1;//重启
        #40 coin_in=1;//连续投币1次，此时有10元
        #40 coin_in=0;
        #40 coin_in=1;//连续投币，触发溢出，此时还是10元
        #40 coin_in=0;
        #40 drink_type=2'b01;
        #40 op_start=1;//买2.5元的饮料，余额7.5元。2.5元剩2瓶
        #40 op_start=0;
        #40 op_start=1;//买2.5元饮料，余额5元。2.5元剩1瓶
        #40 op_start=0;
        #40 op_start=1;//买2.5元饮料，余额2.5元。2.元剩0瓶
        #40 op_start=0;
        #40 op_start=1;//再买2.5已经售罄，不扣钱
        #40 op_start=0;
        #40 cancel_flag=1;//找零
        #40 cancel_flag=0;
    end
endmodule
