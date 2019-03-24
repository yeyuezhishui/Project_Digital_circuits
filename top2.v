`timescale 1ns / 1ps
module top2(reset, coin_type, coin_in, cancel_flag, drink_type, op_start,
open, hold_ind, drinktk_ind, charge_ind, no_money,can_take,clk,over_flow,AN,SEG,go,no_num);
    input [1:0] coin_type;//货币类型 
    input [1:0] drink_type;
    input clk;
    input reset,coin_in,cancel_flag,op_start;
    input go;
    wire clk_N;
    wire [4:0] coin_val;
    wire [4:0] charge_val;
    wire charge_float;
    wire coin_float;
    output hold_ind;
    output open;//电源提示灯
    output [1:0] drinktk_ind;
    output charge_ind;
    output no_money;
    output can_take;
    output over_flow;
    wire [4:0] num1;
    wire [4:0] num2;
    output no_num;
    wire [3:0] moore_state;
    wire [7:0] LED0,LED1,LED2,LED3,LED4,LED5,LED6;
    output [7:0] AN;
    output [7:0] SEG;
    top my_top(reset, clk_N, coin_type, coin_in, cancel_flag, drink_type, op_start,
    open, hold_ind, coin_val, drinktk_ind, charge_ind, no_money, charge_val, charge_float, coin_float,can_take,clk,LED0,LED1,LED2,LED3,LED4
   ,LED5,LED6,moore_state ,over_flow,AN,SEG,go,num1,num2,no_num);
endmodule
