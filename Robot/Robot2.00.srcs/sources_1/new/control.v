`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/12 14:38:54
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module control(
    input CLK,//10M
    input [14:0] RUN_PARM0,
    input [14:0] RUN_PARM1,
    input [14:0] RUN_PARM2,
    input [14:0] RUN_PARM3,
    input [14:0] RUN_PARM4,
    input [14:0] RUN_PARM5,
    input [14:0] RUN_PARM6,
    input [14:0] RUN_PARM7,
    input [14:0] RUN_PARM8,
    input [14:0] RUN_PARM9,
    input [14:0] RUN_PARM10,
    input [14:0] RUN_PARM11,
    input [14:0] RUN_PARM12,
    input [14:0] RUN_PARM13,
    input [14:0] RUN_PARM14,
    input [14:0] RUN_PARM15,
    output [15:0] RUN_CONTL
    );
  
reg[15:0] RUN_CONTL_TMP;
reg[17:0] CLK_50=0;//20ms
    
always@(posedge CLK)
    begin
        if(CLK_50 == 200000)
            CLK_50 <= 0;
        else    
            CLK_50 <= CLK_50 + 1;
    
        if(CLK_50 < RUN_PARM0)
            RUN_CONTL_TMP[0] <= 1;
        else
            RUN_CONTL_TMP[0] <= 0;     
    
        if(CLK_50 < RUN_PARM1)
            RUN_CONTL_TMP[1] <= 1;
        else
            RUN_CONTL_TMP[1] <= 0;
    
        if(CLK_50 < RUN_PARM2)
            RUN_CONTL_TMP[2] <= 1;
        else
            RUN_CONTL_TMP[2] <= 0;
    
        if(CLK_50 < RUN_PARM3)
            RUN_CONTL_TMP[3] <= 1;
        else
            RUN_CONTL_TMP[3] <= 0;
    
        if(CLK_50 < RUN_PARM4)
            RUN_CONTL_TMP[4] <= 1;
        else
            RUN_CONTL_TMP[4] <= 0;
            
        if(CLK_50 < RUN_PARM5)
            RUN_CONTL_TMP[5] <= 1;
        else
            RUN_CONTL_TMP[5] <= 0;
                  
        if(CLK_50 < RUN_PARM6)
           RUN_CONTL_TMP[6] <= 1;
        else
           RUN_CONTL_TMP[6] <= 0;     
    
        if(CLK_50 < RUN_PARM7)
            RUN_CONTL_TMP[7] <= 1;
        else
            RUN_CONTL_TMP[7] <= 0;
     
        if(CLK_50 < RUN_PARM8)
            RUN_CONTL_TMP[8] <= 1;
        else
            RUN_CONTL_TMP[8] <= 0;
    
        if(CLK_50 < RUN_PARM9)
            RUN_CONTL_TMP[9] <= 1;
        else
            RUN_CONTL_TMP[9] <= 0;
    
        if(CLK_50 < RUN_PARM10)
            RUN_CONTL_TMP[10] <= 1;
        else
            RUN_CONTL_TMP[10] <= 0;        
    
        if(CLK_50 < RUN_PARM11)
            RUN_CONTL_TMP[11] <= 1;
        else
            RUN_CONTL_TMP[11] <= 0;
    
        if(CLK_50 < RUN_PARM12)
            RUN_CONTL_TMP[12] <= 1;
        else
            RUN_CONTL_TMP[12] <= 0; 
            
        if(CLK_50 < RUN_PARM13)
            RUN_CONTL_TMP[13] <= 1;
        else
            RUN_CONTL_TMP[13] <= 0; 
                
        if(CLK_50 < RUN_PARM14)
            RUN_CONTL_TMP[14] <= 1;
        else
            RUN_CONTL_TMP[14] <= 0;  
     
        if(CLK_50 < RUN_PARM15)
            RUN_CONTL_TMP[15] <= 1;
        else
            RUN_CONTL_TMP[15] <= 0;
       
        end     

assign RUN_CONTL[15:0] = RUN_CONTL_TMP[15:0];
        
endmodule
