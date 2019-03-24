`timescale 1ns / 1ps
module show(open,hold_ind,
cancel_flag,op_start,coin_in,
coin_val,charge_val,coin_float,charge_float,
LED0,LED1,LED2,LED3,LED4,LED5,LED6,
clk_N,clk,AN,SEG,reset,num1,num2
    );
    input clk_N;
    input clk;
    input open;
    input reset;
    input hold_ind;
    input cancel_flag,op_start,coin_in;
    input [4:0] coin_val;
    input [4:0] charge_val;
    input coin_float;
    input charge_float;
    input [4:0] num1;
    input [4:0] num2;
    output reg [7:0] AN;
    output reg [7:0] SEG;
    output reg [7:0] LED0,LED1,LED2,LED3,LED4,LED5,LED6;
    reg [4:0] second_num;
    reg [15:0] cnt_scan;
    initial begin
        LED0<=8'b1111_1111;
        LED1<=8'b1111_1111;
        LED2<=8'b1111_1111;
        LED3<=8'b1111_1111;
        LED4<=8'b1111_1111;
        LED5<=8'b1111_1111;
        LED6<=8'b1111_1111;
        second_num<=5'b00000;
        cnt_scan<=0;
    end
    always @(posedge clk_N) begin
        cnt_scan<=cnt_scan+1;
    end
    always @(cnt_scan or hold_ind) begin
        if(reset==0 && open==0) begin
            AN<=8'b00000000;
        end
        else begin
            if(hold_ind==1) begin
                case(cnt_scan[2:0]) 
                    3'b000: AN<=8'b11111011;
                    3'b001: AN<=8'b11110111;
                    3'b010: AN<=8'b11101111;
                    3'b011: AN<=8'b10111111;
                    3'b100: AN<=8'b01111111;
                    default: AN<=8'b11111111;
                endcase    
            end
            else begin
                case(cnt_scan[2:0])
                    3'b011: AN<=8'b11111110;
                    3'b100: AN<=8'b11111101;
                    3'b101: AN<=8'b11111011;
                    3'b110: AN<=8'b11110111;
                    3'b111: AN<=8'b11101111;
                    default: AN<=8'b11111111;
                endcase
            end 
        end
    end
    always @(posedge clk) begin
        if(reset==0 && open==0) begin
            LED0<=8'b1111_1111;
            LED1<=8'b1111_1111;
            LED2<=8'b1111_1111;
            LED3<=8'b1111_1111;
            LED4<=8'b1111_1111;
            LED5<=8'b1111_1111;
            LED6<=8'b1111_1111;
        end
        if(open==1 && hold_ind==0) begin
            LED0<=8'b11000000;//O
            LED1<=8'b11000111;//L
            LED2<=8'b11000111;//L
            LED3<=8'b10000110;//E
            LED4<=8'b10001001;//H
            LED5<=8'b11111111;
            LED6<=8'b11111111;
        end
        else if(open==1&&hold_ind==1) begin
            LED0<=8'b11111111;
            LED1<=8'b11111111;
            if(reset==1) begin
               if(coin_float==1) begin
                 LED2<=8'b10010010;//5
                 if(coin_val>10 || coin_val==10) begin
                     LED4<=8'b11111001;//1
                     second_num<=coin_val-10;
                 end
                 else begin
                     LED4<=8'b11000000;
                     second_num<=coin_val;
                 end
                 case(second_num)
                     5'b00000:LED3<=8'b01000000;//0.
                     5'b00001:LED3<=8'b01111001;//1.
                     5'b00010:LED3<=8'b00100100;//2.
                     5'b00011:LED3<=8'b00110000;//3.
                     5'b00100:LED3<=8'b00011001;//4.
                     5'b00101:LED3<=8'b00010010;//5.
                     5'b00110:LED3<=8'b00000010;//6.
                     5'b00111:LED3<=8'b01111000;//7.
                     5'b01000:LED3<=8'b00000000;//8.
                     5'b01001:LED3<=8'b00010000;//9.
                     default: LED3<=8'b11111111;//
                 endcase
                 case(num1)
                    5'b00000:LED5<=8'b11000000;//0
                    5'b00001:LED5<=8'b11111001;//1
                    5'b00010:LED5<=8'b10100100;//2
                    5'b00011:LED5<=8'b10110000;//3
                    5'b00100:LED5<=8'b10011001;//4
                    5'b00101:LED5<=8'b10010010;//5
                    default:LED5<=8'b11111111;
                 endcase
                 case(num2)
                    5'b00000:LED6<=8'b11000000;//0
                    5'b00001:LED6<=8'b11111001;//1
                    5'b00010:LED6<=8'b10100100;//2
                    5'b00011:LED6<=8'b10110000;//3
                    5'b00100:LED6<=8'b10011001;//4
                    5'b00101:LED6<=8'b10010010;//5
                    default:LED6<=8'b11111111;
                 endcase                 
             end
             else begin 
                 LED2<=8'b11000000;//0
                 if(coin_val>10 || coin_val==10) begin
                     LED4<=8'b11111001;//1
                     second_num<=coin_val-10;
                 end
                 else begin
                     LED4<=8'b11000000;
                     second_num<=coin_val;
                 end
                 case(second_num)
                     5'b00000:LED3<=8'b01000000;//0.
                     5'b00001:LED3<=8'b01111001;//1.
                     5'b00010:LED3<=8'b00100100;//2.
                     5'b00011:LED3<=8'b00110000;//3.
                     5'b00100:LED3<=8'b00011001;//4.
                     5'b00101:LED3<=8'b00010010;//5.
                     5'b00110:LED3<=8'b00000010;//6.
                     5'b00111:LED3<=8'b01111000;//7.
                     5'b01000:LED3<=8'b00000000;//8.
                     5'b01001:LED3<=8'b00010000;//9.
                     default: LED3<=8'b11111111;//
                 endcase
                 case(num1)
                    5'b00000:LED5<=8'b11000000;//0
                    5'b00001:LED5<=8'b11111001;//1
                    5'b00010:LED5<=8'b10100100;//2
                    5'b00011:LED5<=8'b10110000;//3
                    5'b00100:LED5<=8'b10011001;//4
                    5'b00101:LED5<=8'b10010010;//5
                    default:LED5<=8'b11111111;
                 endcase
                 case(num2)
                    5'b00000:LED6<=8'b11000000;//0
                    5'b00001:LED6<=8'b11111001;//1
                    5'b00010:LED6<=8'b10100100;//2
                    5'b00011:LED6<=8'b10110000;//3
                    5'b00100:LED6<=8'b10011001;//4
                    5'b00101:LED6<=8'b10010010;//5
                    default:LED6<=8'b11111111;
                 endcase      
             end        
            end
            if(coin_in==1||op_start==1||cancel_flag==1) begin
                if(coin_float==1) begin
                    LED2<=8'b10010010;//5
                    if(coin_val>10 || coin_val==10) begin
                        LED4<=8'b11111001;//1
                        second_num<=coin_val-10;
                    end
                    else begin
                        LED4<=8'b11000000;
                        second_num<=coin_val;
                    end
                    case(second_num)
                        5'b00000:LED3<=8'b01000000;//0.
                        5'b00001:LED3<=8'b01111001;//1.
                        5'b00010:LED3<=8'b00100100;//2.
                        5'b00011:LED3<=8'b00110000;//3.
                        5'b00100:LED3<=8'b00011001;//4.
                        5'b00101:LED3<=8'b00010010;//5.
                        5'b00110:LED3<=8'b00000010;//6.
                        5'b00111:LED3<=8'b01111000;//7.
                        5'b01000:LED3<=8'b00000000;//8.
                        5'b01001:LED3<=8'b00010000;//9.
                        default: LED3<=8'b11111111;//
                    endcase
                 case(num1)
                       5'b00000:LED5<=8'b11000000;//0
                       5'b00001:LED5<=8'b11111001;//1
                       5'b00010:LED5<=8'b10100100;//2
                       5'b00011:LED5<=8'b10110000;//3
                       5'b00100:LED5<=8'b10011001;//4
                       5'b00101:LED5<=8'b10010010;//5
                       default:LED5<=8'b11111111;
                    endcase
                    case(num2)
                       5'b00000:LED6<=8'b11000000;//0
                       5'b00001:LED6<=8'b11111001;//1
                       5'b00010:LED6<=8'b10100100;//2
                       5'b00011:LED6<=8'b10110000;//3
                       5'b00100:LED6<=8'b10011001;//4
                       5'b00101:LED6<=8'b10010010;//5
                       default:LED6<=8'b11111111;
                    endcase      
                end
                else begin 
                    LED2<=8'b11000000;//0
                    if(coin_val>10 || coin_val==10) begin
                        LED4<=8'b11111001;//1
                        second_num<=coin_val-10;
                    end
                    else begin
                        LED4<=8'b11000000;
                        second_num<=coin_val;
                    end
                    case(second_num)
                        5'b00000:LED3<=8'b01000000;//0.
                        5'b00001:LED3<=8'b01111001;//1.
                        5'b00010:LED3<=8'b00100100;//2.
                        5'b00011:LED3<=8'b00110000;//3.
                        5'b00100:LED3<=8'b00011001;//4.
                        5'b00101:LED3<=8'b00010010;//5.
                        5'b00110:LED3<=8'b00000010;//6.
                        5'b00111:LED3<=8'b01111000;//7.
                        5'b01000:LED3<=8'b00000000;//8.
                        5'b01001:LED3<=8'b00010000;//9.
                        default: LED3<=8'b11111111;//
                    endcase
                 case(num1)
                       5'b00000:LED5<=8'b11000000;//0
                       5'b00001:LED5<=8'b11111001;//1
                       5'b00010:LED5<=8'b10100100;//2
                       5'b00011:LED5<=8'b10110000;//3
                       5'b00100:LED5<=8'b10011001;//4
                       5'b00101:LED5<=8'b10010010;//5
                       default:LED5<=8'b11111111;
                    endcase
                    case(num2)
                       5'b00000:LED6<=8'b11000000;//0
                       5'b00001:LED6<=8'b11111001;//1
                       5'b00010:LED6<=8'b10100100;//2
                       5'b00011:LED6<=8'b10110000;//3
                       5'b00100:LED6<=8'b10011001;//4
                       5'b00101:LED6<=8'b10010010;//5
                       default:LED6<=8'b11111111;
                    endcase      
                end            
            end
//            else if(cancel_flag==1) begin
//                if(charge_float==1) begin
//                    LED2<=8'b10010010;//5
//                end
//                else begin 
//                    LED2<=8'b11000000;//0
//                end
//                if(charge_val>=10) begin
//                    LED4<=8'b11111001;//1
//                    second_num<=charge_val-10;
//                end
//                else begin
//                    LED4<=8'b11000000;
//                    second_num<=charge_val;
//                end
//                case(second_num)
//                    5'b00000:LED3<=8'b01000000;//0.
//                    5'b00001:LED3<=8'b01111001;//1.
//                    5'b00010:LED3<=8'b00100100;//2.
//                    5'b00011:LED3<=8'b00110000;//3.
//                    5'b00100:LED3<=8'b00011001;//4.
//                    5'b00101:LED3<=8'b00010010;//5.
//                    5'b00110:LED3<=8'b00000010;//6.
//                    5'b00111:LED3<=8'b01111000;//7.
//                    5'b01000:LED3<=8'b00000000;//8.
//                    5'b01001:LED3<=8'b00010000;//9.
//                default:LED3<=8'b111111111;
//                endcase                
//            end
        end
    end
    always @(AN or hold_ind) begin
        case(AN)
            8'b11111110:SEG<=LED0;
            8'b11111101:SEG<=LED1;
            8'b11111011:SEG<=LED2;
            8'b11110111:SEG<=LED3;
            8'b11101111:SEG<=LED4;
            8'b10111111:SEG<=LED5;
            8'b01111111:SEG<=LED6;
            default:SEG<=8'b11111111;
        endcase
    end
endmodule
