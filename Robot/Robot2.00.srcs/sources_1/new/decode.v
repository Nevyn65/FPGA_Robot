`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Module Name: decode

//////////////////////////////////////////////////////////////////////////////////



module decode(
         input clk,
         input srst,
         input rx_done,
         input [7:0]data_8bit,
         output reg [7:0]control,ADV_flag,BAK_flag
       );

always@(posedge clk)
begin
    if(srst)
    begin
    control <= 0;
    ADV_flag <= 0;
    BAK_flag <= 0;    
    end
    else
    begin
    if(rx_done)
    begin
        case(data_8bit)
        8'd1:
        begin
        ADV_flag <= 1;
        control <= data_8bit;
        end
        8'd2:
        begin
        BAK_flag <= 1;
        control <= data_8bit;
        end   
        default:
        begin
        control <= data_8bit;
        ADV_flag <= 0;
        BAK_flag <= 0;
        end    
        endcase
    end
    else
    begin
        control <= control;
        ADV_flag <= ADV_flag;
        BAK_flag <= BAK_flag;
    end
    end
end        
             

endmodule
