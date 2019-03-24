`timescale 1ns / 1ps
module top(reset, clk_N, coin_type, coin_in, cancel_flag, drink_type, op_start,
open, hold_ind, coin_val, drinktk_ind, charge_ind, no_money, charge_val, charge_float, coin_float,can_take,clk,LED0,LED1,LED2,LED3,LED4,LED5,LED6
   ,moore_state ,over_flow,AN,SEG,go,num1,num2,no_num);
    input [1:0] coin_type;//货币类型 
    input [1:0] drink_type;
    input clk;
    input reset,coin_in,cancel_flag,op_start;
    input go;
    output [4:0] num1;
    output [4:0] num2;
    output no_num;
    output clk_N;
    output [4:0] coin_val;
    output [4:0] charge_val;
    output charge_float;
    output coin_float;
    output hold_ind;
    output open;//电源提示灯
    output [1:0] drinktk_ind;
    output charge_ind;
    output no_money;
    output can_take;
    output over_flow;
    output [3:0] moore_state;
    output [7:0] LED0,LED1,LED2,LED3,LED4,LED5,LED6;
    output [7:0] AN;
    output [7:0] SEG;
    vendor my_vendor(reset, clk_N, coin_type, coin_in, cancel_flag, drink_type, op_start,open, hold_ind, coin_val, drinktk_ind, charge_ind, no_money, charge_val, charge_float, coin_float,can_take,moore_state,over_flow,go,num1,num2,no_num);
    divider #(100000) my_diviver(clk,clk_N);
    show my_show(open,hold_ind,cancel_flag,op_start,coin_in,coin_val,charge_val,coin_float,charge_float,LED0,LED1,LED2,LED3,LED4,LED5,LED6,clk_N,clk,AN,SEG,reset,num1,num2);
endmodule
