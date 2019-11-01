`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: WEI
// 
// Create Date: 2017/07/11 16:03:16
// Design Name: Wei LIU ，Si Kan SUN，Wei YUE
// Module Name: robot_A7
// Project Name: ROBOT
// Target Devices: A7-15T
// Tool Versions: VIVADO 2017.1
// Description: 
// 
// Dependencies: 
// 
// Revision:1.00
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module robot_A7(
    input CLK,              //12M
    input SW1,              //RESET 
    input SW2,              //Control status
    output [16:1] CMOD_ATR, //16 steering engines：20ms cycle，0.5~2.5ms duty cycle
    output [2:1] A_DIR,     //SN74LVCH16T245 direction A signal; always 1 
    output [2:1] B_DIR,     //SN74LVCH16T245 direction B signal; always 1 
   // output CMOD_EYE,        //Robot eyes control
    inout [7:0]ja,         //Bluetooth communication
    output [1:0]LED,
    input RST
     );
     
wire CLK_10M;               //produce 10M clock
wire CLK_100M;              //produce 100M clock for testing
wire CLK_11M;               //produce 11.06M clock for bluetooth
    
reg[3:0] Count_1M=0;        //Produce 1M counter to divide clock，because PLL IP cannot produce clock beblow 10M
reg CLK_1M;                 //1M Clock for steering engines' duty cycle
reg CLK_1M_tmp1;
reg CLK_1M_tmp2;

reg[14:0] Count_1K=0;        //Produce 1K counter to divide clock
reg CLK_1K;                 //1K Clock，Mainly used for SW input sampling
reg CLK_1K_tmp1;
reg CLK_1K_tmp2;

reg[9:0] Count_100ms=0;     //Produce 100ms pulse width
reg Count_100ms_TMP=0; 
reg Count_100ms_TMP1=0;
reg Count_100ms_TMP2=0;

reg[9:0] Count_20ms=0;     //Produce 20ms pulse width
reg Count_20ms_TMP=0; 
reg Count_20ms_TMP1=0;
reg Count_20ms_TMP2=0; 

reg[5:0] RUN_L_C=0;         //Standing up (100ms pw)
reg[2:0] RUN_L_1=0;         //Standing up move counter，one move in total
reg[5:0] RUN_L_2_1=0;       //Standing up (20ms pw)，the first move

reg[5:0] RUN_X_C=0;         //Squat (100ms pw)
reg[2:0] RUN_X_1=0;         //Squat move counter，one move in total
reg[5:0] RUN_X_2_1=0;       //Squat move counter (20ms)，the first move

reg[5:0] RUN_J_C=0;         //100ms counter for bowing
reg[2:0] RUN_J_1=0;         //Bowing move counter，7 counters in total
reg[5:0] RUN_J_2_1=0;       //Bowing move counter (20ms pw)，the first move
reg[5:0] RUN_J_2_2=0;       //Bowing move counter (20ms pw)，the second move
reg[5:0] RUN_J_2_3=0;       //Bowing move counter (20ms pw)，the 3th move
reg[5:0] RUN_J_2_4=0;       //Bowing move counter (20ms pw)，the 4th move
reg[5:0] RUN_J_2_5=0;       //Bowing move counter (20ms pw)，the 5th move
reg[5:0] RUN_J_2_6=0;       //Bowing move counter (20ms pw)，the 6th move
reg[5:0] RUN_J_2_7=0;       //Bowing move counter (20ms pw)，the 7th move

reg[5:0] RUN_HS_C=0;         //100ms counter for waving hand
reg[3:0] RUN_HS_1=0;         //Waving hand counter(20ms pw)，11 counters in total
reg[5:0] RUN_HS_2_1=0;       //Waving hand move counter (20ms pw)，the first move
reg[5:0] RUN_HS_2_2=0;       //Waving hand move counter (20ms pw)，the second move
reg[5:0] RUN_HS_2_3=0;       //Waving hand move counter (20ms pw)，the 3th move
reg[5:0] RUN_HS_2_4=0;       //Waving hand move counter (20ms pw)，the 4th move
reg[5:0] RUN_HS_2_5=0;       //Waving hand move counter (20ms pw)，the 5th move
reg[5:0] RUN_HS_2_6=0;       //Waving hand move counter (20ms pw)，the 6th move
reg[5:0] RUN_HS_2_7=0;       //Waving hand move counter (20ms pw)，the 7th move
reg[5:0] RUN_HS_2_8=0;       //Waving hand move counter (20ms pw)，the 8th move
reg[5:0] RUN_HS_2_9=0;       //Waving hand move counter (20ms pw)，the 9th move
reg[5:0] RUN_HS_2_10=0;       //Waving hand move counter (20ms pw)，the 10th move
reg[5:0] RUN_HS_2_11=0;       //Waving hand move counter (20ms pw)，the 11th move

reg[8:0] RUN_Q_C=0;         //100ms counter for running
reg[3:0] RUN_Q_1=0;         //Running counter(20ms pw)，12 counters in total
reg[5:0] RUN_Q_2_1=0;       //Running move counter (20ms pw)，the first move
reg[5:0] RUN_Q_2_2=0;       //Running move counter (20ms pw)，the second move
reg[5:0] RUN_Q_2_3=0;       //Running move counter (20ms pw)，the 3th move
reg[5:0] RUN_Q_2_4=0;       //Running move counter (20ms pw)，the 4th move
reg[5:0] RUN_Q_2_5=0;       //Running move counter (20ms pw)，the 5th move
reg[5:0] RUN_Q_2_6=0;       //Running move counter (20ms pw)，the 6th move
reg[5:0] RUN_Q_2_7=0;       //Running move counter (20ms pw)，the 7th move
reg[5:0] RUN_Q_2_8=0;       //Running move counter (20ms pw)，the 8th move
reg[5:0] RUN_Q_2_9=0;       //Running move counter (20ms pw)，the 9th move
reg[5:0] RUN_Q_2_10=0;       //Running move counter (20ms pw)，the 10th move
reg[5:0] RUN_Q_2_11=0;       //Running move counter (20ms pw)，the 11th move
reg[5:0] RUN_Q_2_12=0;       //Running move counter (20ms pw)，the 12th move

reg[8:0] RUN_QGF_C=0;         //100ms counter for Forward rolling
reg[5:0] RUN_QGF_1=0;         //Forward rolling counter(20ms pw)，11 counters in total
reg[5:0] RUN_QGF_2_1=0;       //Forward rolling counter (20ms pw)，the first move
reg[5:0] RUN_QGF_2_2=0;       //Forward rolling counter (20ms pw)，the second move
reg[5:0] RUN_QGF_2_3=0;       //Forward rolling counter (20ms pw)，the 3th move
reg[5:0] RUN_QGF_2_4=0;       //Forward rolling counter (20ms pw)，the 4th move
reg[5:0] RUN_QGF_2_5=0;       //Forward rolling counter (20ms pw)，the 5th move
reg[5:0] RUN_QGF_2_6=0;       //Forward rolling counter (20ms pw)，the first move
reg[5:0] RUN_QGF_2_7=0;       //Forward rolling counter (20ms pw)，the first move
reg[5:0] RUN_QGF_2_8=0;       //Forward rolling counter (20ms pw)，the first move
reg[5:0] RUN_QGF_2_9=0;       //Forward rolling counter (20ms pw)，the first move
reg[5:0] RUN_QGF_2_10=0;       //Forward rolling counter (20ms pw)，the first move

wire[7:0] Count_CTRL_TMP;      //Action counter temper
(*mark_debug = "true"*)reg[7:0] Count_CTRL=0;      //Action counter
reg[7:0] Count_CTRL_OLD=1;  //Action  

reg[7:0] BT_Count_CTRL=0;      //Bluetooth control
reg[7:0] SW_Count_CTRL=0;      //sw control

wire[15:0] CTRL_OUT_TMP;  //Steering engine output

(*mark_debug = "true"*)reg SW1_TMP=0;              //produce 1K pulse width，SW1
(*mark_debug = "true"*)reg SW1_TMP1_1=0;              //produce 1K pulse width，SW1
reg SW1_TMP1=0;
reg SW1_TMP2=0;
reg SW1_TMP_1=0;
reg SW1_TMP_2=0;
reg SW1_TMP_3=0;
reg SW1_TMP_4=0;
reg SW1_TMP_5=0;
reg SW1_TMP_6=0;
reg SW1_TMP_7=0;
reg SW1_TMP_8=0;
reg SW1_TMP_9=0;
reg SW1_TMP_10=0;
reg SW1_TMP_11=0;
reg SW1_TMP_12=0;
reg SW1_TMP_13=0;
reg SW1_TMP_14=0;
reg SW1_TMP_15=0;
reg SW1_TMP_16=0;
reg SW1_TMP_17=0;

reg SW1_TMP_UART=0;              //produce 1K pulse width for uart，SW1
reg SW1_TMP1_UART=0;
reg SW1_TMP2_UART=0;

reg SW2_TMP=0;              //produce 1K pulse width for uart，SW2
reg SW2_TMP_1=0;              //produce 1K pulse width for uart，SW2
reg SW2_TMP1=0;
reg SW2_TMP2=0;
reg SW2_TMP3=0;
reg SW2_TMP4=0;
reg SW2_TMP5=0;
reg SW2_cont=0;

reg BT_SW2_TMP=0;              //For bluetooth control command switch 2
reg BT_SW2_TMP1=0;
reg BT_SW2_TMP2=0;
reg BT_SW2_cont=0;

wire UART_RX;               
wire UART_TX;
wire UART_TX_EN;
wire[7:0] UART_RX_DATA;
wire[7:0] UART_TX_DATA;
wire UART_RX_DONE;
wire UART_TX_DONE;

wire UART_DATA_FIFO_FULL;        //UART RX FIFO
wire UART_DATA_FIFO_EMPTY;
wire[7:0] UART_DATA_FIFO_DOUT;
wire[7:0] UART_DATA_FIFO_RDEN;

reg UART_DATA_FIFO_EMPTY_TMP1;//Pulse width broadening
reg UART_DATA_FIFO_EMPTY_TMP2;
reg UART_DATA_FIFO_EMPTY_TMP3;
reg UART_DATA_FIFO_EMPTY_1;//Signal Delay
reg UART_DATA_FIFO_EMPTY_2;
reg UART_DATA_FIFO_EMPTY_3;
reg UART_DATA_FIFO_EMPTY_4;
reg UART_DATA_FIFO_EMPTY_5;

wire Robot_ADV_flag;         //A forward flag that identifies the number and position of subsequent forward steps
wire Robot_BAK_flag;         //A back flag that identifies the number and position of subsequent forward steps
/**********Reset steering gear action group*************************/
reg[14:0] RUN_Q10 = 15260;//15000+DJ_ID1;
reg[14:0] RUN_Q11 = 12410;//12000+DJ_ID2;
reg[14:0] RUN_Q12 = 15270;//15000+DJ_ID3;
reg[14:0] RUN_Q13 = 18100;//17500+DJ_ID4;
reg[14:0] RUN_Q14 = 15200;//15000+DJ_ID5;
reg[14:0] RUN_Q15 = 17220;//17000+DJ_ID6;
reg[14:0] RUN_Q16 = 21170;//23000+DJ_ID7;
reg[14:0] RUN_Q17 = 18820;//19000+DJ_ID8;
reg[14:0] RUN_Q18 = 14240;//15000+DJ_ID9;
reg[14:0] RUN_Q19 = 17940;//18000+DJ_ID10;
reg[14:0] RUN_Q110 = 14940;//15000+DJ_ID11;
reg[14:0] RUN_Q111 = 11850;//12500+DJ_ID12;
reg[14:0] RUN_Q112 = 15310;//15000+DJ_ID13;
reg[14:0] RUN_Q113 = 13460;//13000+DJ_ID14;
reg[14:0] RUN_Q114 = 7800;//7000+DJ_ID15;
reg[14:0] RUN_Q115 = 10730;//11000+DJ_ID16;
/**********Reset steering gear action group*************************/

/**********Steering gear error*************************/
(*mark_debug = "true"*)reg[4:0] DJ_ROM_ADDR=0;
(*mark_debug = "true"*)wire[15:0] DJ_ROM_DATA;
(*mark_debug = "true"*)reg[15:0] DJ_ID1;
(*mark_debug = "true"*)reg[15:0] DJ_ID2;
(*mark_debug = "true"*)reg[15:0] DJ_ID3;
(*mark_debug = "true"*)reg[15:0] DJ_ID4;
(*mark_debug = "true"*)reg[15:0] DJ_ID5;
(*mark_debug = "true"*)reg[15:0] DJ_ID6;
(*mark_debug = "true"*)reg[15:0] DJ_ID7;
(*mark_debug = "true"*)reg[15:0] DJ_ID8;
(*mark_debug = "true"*)reg[15:0] DJ_ID9;
(*mark_debug = "true"*)reg[15:0] DJ_ID10;
(*mark_debug = "true"*)reg[15:0] DJ_ID11;
(*mark_debug = "true"*)reg[15:0] DJ_ID12;
(*mark_debug = "true"*)reg[15:0] DJ_ID13;
(*mark_debug = "true"*)reg[15:0] DJ_ID14;
(*mark_debug = "true"*)reg[15:0] DJ_ID15;
(*mark_debug = "true"*)reg[15:0] DJ_ID16;
(*mark_debug = "true"*)reg[15:0] DJ_ID17;

/**********Steering gear error*************************/

/**********Program start*************************/

/**********舵机误差*************************/
DJ_DATA_ROM DJ_DATA_ROM(
    .a(DJ_ROM_ADDR),
    .spo(DJ_ROM_DATA)
    );

always@(posedge CLK_10M)
begin
    if(SW1_TMP1_1)
        DJ_ROM_ADDR <= DJ_ROM_ADDR + 1;
    else
        DJ_ROM_ADDR <= 0;
    
    if(SW1_TMP1_1)
    begin
    case(DJ_ROM_ADDR)
    5'd0:DJ_ID1 <= DJ_ROM_DATA;
    5'd1:DJ_ID2 <= DJ_ROM_DATA;
    5'd2:DJ_ID3 <= DJ_ROM_DATA;
    5'd3:DJ_ID4 <= DJ_ROM_DATA;
    5'd4:DJ_ID5 <= DJ_ROM_DATA;
    5'd5:DJ_ID6 <= DJ_ROM_DATA;
    5'd6:DJ_ID7 <= DJ_ROM_DATA;
    5'd7:DJ_ID8 <= DJ_ROM_DATA;
    5'd8:DJ_ID9 <= DJ_ROM_DATA;
    5'd9:DJ_ID10 <= DJ_ROM_DATA;
    5'd10:DJ_ID11 <= DJ_ROM_DATA;
    5'd11:DJ_ID12 <= DJ_ROM_DATA;
    5'd12:DJ_ID13 <= DJ_ROM_DATA;
    5'd13:DJ_ID14 <= DJ_ROM_DATA;
    5'd14:DJ_ID15 <= DJ_ROM_DATA;
    5'd15:DJ_ID16 <= DJ_ROM_DATA;
    default:DJ_ID17 <= DJ_ROM_DATA;
    endcase
    end
    else
    begin
    DJ_ID1 <= DJ_ID1;
    DJ_ID2 <= DJ_ID2;
    DJ_ID3 <= DJ_ID3;
    DJ_ID4 <= DJ_ID4;
    DJ_ID5 <= DJ_ID5;
    DJ_ID6 <= DJ_ID6;
    DJ_ID7 <= DJ_ID7;
    DJ_ID8 <= DJ_ID8;
    DJ_ID9 <= DJ_ID9;
    DJ_ID10 <= DJ_ID10;
    DJ_ID11 <= DJ_ID11;
    DJ_ID12 <= DJ_ID12;
    DJ_ID13 <= DJ_ID13;
    DJ_ID14 <= DJ_ID14;
    DJ_ID15 <= DJ_ID15;
    DJ_ID16 <= DJ_ID16;
    end
end              
/**********舵机误差*************************/

/*****************Clock generate*****************/
clk_10M clk_10M_1(          //Generate global clock：input 12M，output 10M
    .clk_out1(CLK_10M),     //Global clock，10M
    .clk_out2(CLK_100M),    //Test clock，100M
    .clk_out3(CLK_11M),     //UART Clock，11.06M
    .clk_in1(CLK)
    );
    
always@(posedge CLK_10M)        //Gnerate 1M clock，Perform 12 frequency division on 12 m clock input
begin
    if(Count_1M==9)
        Count_1M <= 0;
    else
        Count_1M <= Count_1M + 1;
       
    if(Count_1M < 5)
        CLK_1M_tmp1 <= 1;
    else
        CLK_1M_tmp1 <= 0;
    
    CLK_1M_tmp2 <= CLK_1M_tmp1;
    CLK_1M <= CLK_1M_tmp1 && !CLK_1M_tmp2;    
end

always@(posedge CLK_10M)     //Gnerate 1k clock，Perform 1000 frequency division on 1M clock input
begin
    if(Count_1K==9999)
        Count_1K <= 0;
    else
        Count_1K <= Count_1K + 1;
       
    if(Count_1K < 5000)
        CLK_1K_tmp1 <= 1;
    else
        CLK_1K_tmp1 <= 0;
        
    CLK_1K_tmp2 <= CLK_1K_tmp1;
    CLK_1K <= CLK_1K_tmp1 && !CLK_1K_tmp2;        
end

always@(posedge CLK_10M)     //Produce a 20ms counter
begin
    if(Count_20ms==19)
        Count_20ms <= 0;
    else
    begin
        if(CLK_1K==1)
            Count_20ms <= Count_20ms + 1;
        else
            Count_20ms <= Count_20ms;    
    end
        
    Count_20ms_TMP1 <= (Count_20ms<10);
    Count_20ms_TMP2 <= Count_20ms_TMP1;
    Count_20ms_TMP <= Count_20ms_TMP1 && !Count_20ms_TMP2;    
end

always@(posedge CLK_10M)     //Produce a 100ms counter
begin
    if(Count_100ms==99)
        Count_100ms <= 0;
    else
    begin
        if(CLK_1K==1)
            Count_100ms <= Count_100ms + 1;
        else
            Count_100ms <= Count_100ms;    
    end
        
    Count_100ms_TMP1 <= (Count_100ms<50);
    Count_100ms_TMP2 <= Count_100ms_TMP1;
    Count_100ms_TMP <= Count_100ms_TMP1 && !Count_100ms_TMP2;    
end
/*****************时钟产生*****************/

/*****************Produce pulse width*****************/
always@(posedge CLK_10M)     
begin
    if(CLK_1K==1)
        SW1_TMP1 <= SW1; 
    else
        SW1_TMP1 <= SW1_TMP1; 
    SW1_TMP2 <= SW1_TMP1;
    SW1_TMP <= SW1_TMP1 && !SW1_TMP2;
end

always@(posedge CLK_10M)     //generate sw to control pulse width
begin
    if(CLK_1K==1)
        SW1_TMP_1 <= RST; 
    else
        SW1_TMP_1 <= SW1_TMP_1; 
    SW1_TMP_2 <= SW1_TMP_1;
    SW1_TMP_3 <= SW1_TMP_2;
    SW1_TMP_4 <= SW1_TMP_3;
    SW1_TMP_5 <= SW1_TMP_4;
    SW1_TMP_6 <= SW1_TMP_5;
    SW1_TMP_7 <= SW1_TMP_6;
    SW1_TMP_8 <= SW1_TMP_7;
    SW1_TMP_9 <= SW1_TMP_8;
    SW1_TMP_10 <= SW1_TMP_9;
    SW1_TMP_11 <= SW1_TMP_10;
    SW1_TMP_12 <= SW1_TMP_11;
    SW1_TMP_13 <= SW1_TMP_12;
    SW1_TMP_14 <= SW1_TMP_13;
    SW1_TMP_15 <= SW1_TMP_14;
    SW1_TMP_16 <= SW1_TMP_15;
    SW1_TMP_17 <= SW1_TMP_16;
    SW1_TMP1_1 <= SW1_TMP_1 && !SW1_TMP_17;
end

always@(posedge CLK_11M)     //generate sw to control pulse width for UART
begin
    SW1_TMP1_UART <= SW1; 
    SW1_TMP2_UART <= SW1_TMP1_UART;
    SW1_TMP_UART <= SW1_TMP1_UART && !SW1_TMP2_UART;
end
 
always@(posedge CLK_10M)
begin
    if(CLK_1K==1)
        SW2_TMP1 <= SW2; 
    else
        SW2_TMP1 <= SW2_TMP1; 
    SW2_TMP2 <= SW2_TMP1;
    SW2_TMP <= SW2_TMP1 && !SW2_TMP2;
    SW2_TMP3 <= SW2_TMP2;
    SW2_TMP4 <= SW2_TMP3;
    SW2_TMP5 <= SW2_TMP4;
    SW2_TMP_1 <= SW2_TMP4 && !SW2_TMP5;    
end
/*****************Produce pulse width*****************/

/***********PMOD(Bluetooth)UART port*************/
assign UART_RX = ja[2];
assign ja[3] = UART_TX;
assign UART_TX_EN = SW2_TMP;

BlueTooth_0 u_uart (
              .clk(CLK_11M),            // input wire clk
              .reset(SW1_TMP_UART),     // input wire reset
              .rx(UART_RX),              // input wire rx
              .tx_btn(1'b0),      // input wire tx_btn
//              .data_in(UART_TX_DATA),    // input wire [7 : 0] data_in
              .data_in(8'b00000000),    // input wire [7 : 0] data_in
              .data_out(UART_RX_DATA),  // output wire [7 : 0] data_out
              .rx_done(UART_RX_DONE),    // output wire rx_done
              .tx_done(UART_TX_DONE),    // output wire tx_done
              .tx(1'b0)              // output wire tx
            );

UART_DATA_FIFO UART_DATA_FIFO1(
              .wr_clk(CLK_11M),
              .rd_clk(CLK_10M),
              .rst(SW1_TMP),
              .din(UART_RX_DATA),
              .wr_en(UART_RX_DONE),
              .full(UART_DATA_FIFO_FULL),
              .empty(UART_DATA_FIFO_EMPTY),
              .dout(UART_DATA_FIFO_DOUT),
              .rd_en(!UART_DATA_FIFO_EMPTY)
            );

always@(posedge CLK_10M)
begin
    UART_DATA_FIFO_EMPTY_TMP1 <= !UART_DATA_FIFO_EMPTY;
    UART_DATA_FIFO_EMPTY_TMP2 <= UART_DATA_FIFO_EMPTY_TMP1;
    UART_DATA_FIFO_EMPTY_TMP3 <= !UART_DATA_FIFO_EMPTY || UART_DATA_FIFO_EMPTY_TMP1 || UART_DATA_FIFO_EMPTY_TMP2;
end    

always@(posedge CLK_10M)
begin
    UART_DATA_FIFO_EMPTY_1 <= UART_DATA_FIFO_EMPTY_TMP3;
    UART_DATA_FIFO_EMPTY_2 <= UART_DATA_FIFO_EMPTY_1;
    UART_DATA_FIFO_EMPTY_3 <= UART_DATA_FIFO_EMPTY_2;
    UART_DATA_FIFO_EMPTY_4 <= UART_DATA_FIFO_EMPTY_3;
    UART_DATA_FIFO_EMPTY_5 <= !UART_DATA_FIFO_EMPTY_3 && UART_DATA_FIFO_EMPTY_4;
end    
   
decode u_uart_decode(
         .clk(CLK_10M),
         .srst(SW1_TMP),
         .rx_done(UART_DATA_FIFO_EMPTY_5),
         .data_8bit(UART_DATA_FIFO_DOUT),
         .control(Count_CTRL_TMP),
         .ADV_flag(Robot_ADV_flag),
         .BAK_flag(Robot_BAK_flag)
       );
/***********PMOD(Bluetooth)UART port*************/

/*****************Bluetooth sending some control commands*****************/
always@(posedge CLK_10M)
begin
    BT_Count_CTRL <= Count_CTRL_TMP;
    
    if(Count_CTRL_OLD != BT_Count_CTRL)
    begin
        BT_SW2_TMP1 <= 1;
        Count_CTRL_OLD <= BT_Count_CTRL;
    end    
    else
    begin
        BT_SW2_TMP1 <= 0;
        Count_CTRL_OLD <= Count_CTRL_OLD;
    end            
 
    BT_SW2_TMP2 <= BT_SW2_TMP1;
    BT_SW2_TMP <= BT_SW2_TMP1 && !BT_SW2_TMP2;
end
/*****************Bluetooth sending some control commands*****************/

/*****************SW gives control commands*****************/
always@(posedge CLK_10M)     //Generate control command, press SW1 for reset signal, and the robot performs attention;SW2 changes a control state with each click
begin
    if(SW1_TMP==1)
        SW_Count_CTRL <= 0;
    else
    begin
        if(SW2_TMP==1)
            SW_Count_CTRL <= SW_Count_CTRL + 1;
//            Count_CTRL <= 5;
        else
        begin
            if(SW_Count_CTRL==6)
                SW_Count_CTRL <= 1;
            else              
                SW_Count_CTRL <= SW_Count_CTRL;
        end
    end
end       
/*****************SW gives control commands*****************/

/*****************Robot control commands are generated*****************/
always@(posedge CLK_10M)
begin
    if(BT_SW2_TMP)
        Count_CTRL <= BT_Count_CTRL;
    else
        if(SW2_TMP_1)
            Count_CTRL <= SW_Count_CTRL;    
        else
            Count_CTRL <= Count_CTRL;    
end
/*****************Robot control commands are generated*****************/

/*****************Standing up is generated*****************/
always@(posedge CLK_10M)     //A control sequence that generates attention:1200ms
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_L_C <= 0;
    else
    begin
        if((Count_100ms_TMP==1)&&(Count_CTRL==0)&&(RUN_L_C<12))  
            RUN_L_C <= RUN_L_C + 1;
        else
        begin
            if(RUN_L_C==12)
                RUN_L_C <= 13;
            else    
                RUN_L_C <= RUN_L_C;
       end         
    end
end  

always@(posedge CLK_10M)     //A control sequence that generates attention:1200ms
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_L_1 <= 0;
    else
    begin
        case(RUN_L_C)
        6'd11:RUN_L_1 <= 1;
        default:RUN_L_1 <= RUN_L_1;
    endcase    
   end     
end  

always@(posedge CLK_10M)     //The 20ms action that produces the attention action breaks down, the first action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_L_2_1 <= 0;
    else
    begin
//        if((Count_20ms_TMP==1)&&((RUN_X_1==1)||(RUN_J_1==7)||(RUN_HS_1==11)||(RUN_Q_1==12)||(RUN_QGF_1 == 10))&&(RUN_L_2_1<60))
        if((Count_20ms_TMP==1)&&((RUN_L_1==1)||(RUN_X_1==1)||(RUN_J_1==7)||(RUN_HS_1==11)||(RUN_Q_1==12)||(RUN_QGF_1 == 10))&&(RUN_L_2_1<60))
            RUN_L_2_1 <= RUN_L_2_1+1;
        else
            RUN_L_2_1 <= RUN_L_2_1;    
   end     
end 
/*****************Standing up is generated*****************/

/*****************Squat action generated*****************/
always@(posedge CLK_10M)     //1 control sequence to generate squat action :1200ms, 1000ms automatic standing up
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_X_C <= 0;
    else
    begin
        if((Count_100ms_TMP==1)&&(Count_CTRL==1)&&(RUN_X_C<23))  
            RUN_X_C <= RUN_X_C + 1;
        else
        begin
            if(RUN_X_C==22)
                RUN_X_C <= 23;
            else    
                RUN_X_C <= RUN_X_C;
       end         
    end
end  

always@(posedge CLK_10M)     //Generates 1 control sequence for the squat:1200ms
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_X_1 <= 0;
    else
    begin
        case(RUN_X_C)
        6'd21:RUN_X_1 <= 1;
        default:RUN_X_1 <= RUN_X_1;
    endcase    
   end     
end  

always@(posedge CLK_10M)     //Split the 20ms movement that produces the squat, the first movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_X_2_1 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==1)&&(RUN_X_1==0)&&(RUN_X_2_1<60))
            RUN_X_2_1 <= RUN_X_2_1+1;
        else
            RUN_X_2_1 <= RUN_X_2_1;    
   end     
end 
/*****************Squat action generated*****************/

/*****************The bow movement is generated*****************/
always@(posedge CLK_10M)     //7 control sequences that generate the bow action:500，500，500，700，800，600，500，1000 then stand up automatically
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_C <= 0;
    else
    begin
        if((Count_100ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_C<52))  
            RUN_J_C <= RUN_J_C + 1;
        else
        begin
            if(RUN_J_C==51)
                RUN_J_C <= 52;
            else    
                RUN_J_C <= RUN_J_C;
       end         
    end
end  

always@(posedge CLK_10M)     //7 control sequences that generate the bow action:500，500，500，700，800，600，500，1000 then stand up automatically
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_1 <= 0;
    else
    begin
        case(RUN_J_C)
        6'd4:RUN_J_1 <= 1;
        6'd9:RUN_J_1 <= 2;
        6'd14:RUN_J_1 <= 3;
        6'd21:RUN_J_1 <= 4;
        6'd29:RUN_J_1 <= 5;
        6'd35:RUN_J_1 <= 6;
        6'd50:RUN_J_1 <= 7;
        default:RUN_J_1 <= RUN_J_1;
    endcase    
   end     
end  

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the first movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_1 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==0)&&(RUN_J_2_1<25))
            RUN_J_2_1 <= RUN_J_2_1+1;
        else
            RUN_J_2_1 <= RUN_J_2_1;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 2th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_2 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==1)&&(RUN_J_2_2<25))
            RUN_J_2_2 <= RUN_J_2_2+1;
        else
            RUN_J_2_2 <= RUN_J_2_2;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 3th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_3 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==2)&&(RUN_J_2_3<25))
            RUN_J_2_3 <= RUN_J_2_3+1;
        else
            RUN_J_2_3 <= RUN_J_2_3;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 4th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_4 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==3)&&(RUN_J_2_4<35))
            RUN_J_2_4 <= RUN_J_2_4+1;
        else
            RUN_J_2_4 <= RUN_J_2_4;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 5th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_5 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==4)&&(RUN_J_2_5<40))
            RUN_J_2_5 <= RUN_J_2_5+1;
        else
            RUN_J_2_5 <= RUN_J_2_5;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 6th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_6 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==5)&&(RUN_J_2_6<30))
            RUN_J_2_6 <= RUN_J_2_6+1;
        else
            RUN_J_2_6 <= RUN_J_2_6;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the bow is broken down, the 7th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_J_2_7 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==2)&&(RUN_J_1==6)&&(RUN_J_2_7<25))
            RUN_J_2_7 <= RUN_J_2_7+1;
        else
            RUN_J_2_7 <= RUN_J_2_7;    
   end     
end
/*****************The bow movement is generated*****************/

/*****************Waving hand*****************/
always@(posedge CLK_10M)     //Generate 11 control sequences of wave motions:500，500，200，200，200，200，200，200，200，200，500，1000 then stand up automatically
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_C <= 0;
    else
    begin
        if((Count_100ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_C<42))  
            RUN_HS_C <= RUN_HS_C + 1;
        else
        begin
            if(RUN_HS_C==41)
                RUN_HS_C <= 42;
            else    
                RUN_HS_C <= RUN_HS_C;
       end         
    end
end  

always@(posedge CLK_10M)     //Generate 11 control sequences of wave motions:500，500，200，200，200，200，200，200，200，200，500，1000 then stand up automatically
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_1 <= 0;
    else
    begin
        case(RUN_HS_C)
        6'd4:RUN_HS_1 <= 1;
        6'd9:RUN_HS_1 <= 2;
        6'd11:RUN_HS_1 <= 3;
        6'd13:RUN_HS_1 <= 4;
        6'd15:RUN_HS_1 <= 5;
        6'd17:RUN_HS_1 <= 6;
        6'd19:RUN_HS_1 <= 7;
        6'd21:RUN_HS_1 <= 8;
        6'd23:RUN_HS_1 <= 9;
        6'd25:RUN_HS_1 <= 10;
        6'd40:RUN_HS_1 <= 11;
        default:RUN_HS_1 <= RUN_HS_1;
    endcase    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the first movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_1 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==0)&&(RUN_HS_2_1<25))
            RUN_HS_2_1 <= RUN_HS_2_1+1;
        else
            RUN_HS_2_1 <= RUN_HS_2_1;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 2th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_2 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==1)&&(RUN_HS_2_2<25))
            RUN_HS_2_2 <= RUN_HS_2_2+1;
        else
            RUN_HS_2_2 <= RUN_HS_2_2;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 3th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_3 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==2)&&(RUN_HS_2_3<10))
            RUN_HS_2_3 <= RUN_HS_2_3+1;
        else
            RUN_HS_2_3 <= RUN_HS_2_3;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 4th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_4 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==3)&&(RUN_HS_2_4<10))
            RUN_HS_2_4 <= RUN_HS_2_4+1;
        else
            RUN_HS_2_4 <= RUN_HS_2_4;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 5th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_5 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==4)&&(RUN_HS_2_5<10))
            RUN_HS_2_5 <= RUN_HS_2_5+1;
        else
            RUN_HS_2_5 <= RUN_HS_2_5;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 6th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_6 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==5)&&(RUN_HS_2_6<10))
            RUN_HS_2_6 <= RUN_HS_2_6+1;
        else
            RUN_HS_2_6 <= RUN_HS_2_6;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 7th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_7 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==6)&&(RUN_HS_2_7<10))
            RUN_HS_2_7 <= RUN_HS_2_7+1;
        else
            RUN_HS_2_7 <= RUN_HS_2_7;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 8th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_8 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==7)&&(RUN_HS_2_8<10))
            RUN_HS_2_8 <= RUN_HS_2_8+1;
        else
            RUN_HS_2_8 <= RUN_HS_2_8;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 9th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_9 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==8)&&(RUN_HS_2_9<10))
            RUN_HS_2_9 <= RUN_HS_2_9+1;
        else
            RUN_HS_2_9 <= RUN_HS_2_9;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 10th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_10 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==9)&&(RUN_HS_2_10<10))
            RUN_HS_2_10 <= RUN_HS_2_10+1;
        else
            RUN_HS_2_10 <= RUN_HS_2_10;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the wave motion is broken down, the 11th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_HS_2_11 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==3)&&(RUN_HS_1==10)&&(RUN_HS_2_11<25))
            RUN_HS_2_11 <= RUN_HS_2_11+1;
        else
            RUN_HS_2_11 <= RUN_HS_2_11;    
   end     
end
/*****************Waving hand*****************/

/*****************Running*****************/
always@(posedge CLK_10M)     //4 control sequences for the forward movement :300ms, 300ms, 300ms, 300ms;Cycle 3 times and stand up automatically after 1000ms
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_C <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_C<290))  
            RUN_Q_C <= RUN_Q_C + 1;
        else
        begin
            if(RUN_Q_C==290)
                RUN_Q_C <= 291;
            else    
                RUN_Q_C <= RUN_Q_C;
       end         
    end
end

always@(posedge CLK_10M)     //4 control sequences for the forward movement :300ms, 300ms, 300ms, 300ms;Cycle 3 times and stand up automatically after 1000ms
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_1 <= 0;
    else
    begin
        case(RUN_Q_C)
        9'd14:RUN_Q_1 <= 1;
        9'd29:RUN_Q_1 <= 2;
        9'd44:RUN_Q_1 <= 3;
        9'd59:RUN_Q_1 <= 4;
        9'd74:RUN_Q_1 <= 5;
        9'd89:RUN_Q_1 <= 6;
        9'd104:RUN_Q_1 <= 7;
        9'd119:RUN_Q_1 <= 8;
        9'd134:RUN_Q_1 <= 9;
        9'd149:RUN_Q_1 <= 10;
        9'd164:RUN_Q_1 <= 11;
        9'd229:RUN_Q_1 <= 12;       
        default:RUN_Q_1 <= RUN_Q_1;
    endcase    
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the first action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_1 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==0)&&(RUN_Q_2_1<15))
            RUN_Q_2_1 <= RUN_Q_2_1+1;
        else
            RUN_Q_2_1 <= RUN_Q_2_1;               
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the second action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_2 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==1)&&(RUN_Q_2_2<15))
            RUN_Q_2_2 <= RUN_Q_2_2+1;
        else  
            RUN_Q_2_2 <= RUN_Q_2_2;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 3th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_3 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==2)&&(RUN_Q_2_3<15))
            RUN_Q_2_3 <= RUN_Q_2_3+1;
        else
            RUN_Q_2_3 <= RUN_Q_2_3;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 4th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_4 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==3)&&(RUN_Q_2_4<15))
            RUN_Q_2_4 <= RUN_Q_2_4+1;
        else   
            RUN_Q_2_4 <= RUN_Q_2_4;
   end      
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 5th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_5 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==4)&&(RUN_Q_2_5<15))
            RUN_Q_2_5 <= RUN_Q_2_5+1;
        else
            RUN_Q_2_5 <= RUN_Q_2_5;               
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 6th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_6 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==5)&&(RUN_Q_2_6<15))
            RUN_Q_2_6 <= RUN_Q_2_6+1;
        else  
            RUN_Q_2_6 <= RUN_Q_2_6;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 7th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_7 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==6)&&(RUN_Q_2_7<15))
            RUN_Q_2_7 <= RUN_Q_2_7+1;
        else
            RUN_Q_2_7 <= RUN_Q_2_7;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 8th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_8 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==7)&&(RUN_Q_2_8<15))
            RUN_Q_2_8 <= RUN_Q_2_8+1;
        else   
            RUN_Q_2_8 <= RUN_Q_2_8;
   end      
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 9th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_9 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==8)&&(RUN_Q_2_9<15))
            RUN_Q_2_9 <= RUN_Q_2_9+1;
        else
            RUN_Q_2_9 <= RUN_Q_2_9;               
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 10th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_10 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==9)&&(RUN_Q_2_10<15))
            RUN_Q_2_10 <= RUN_Q_2_10+1;
        else  
            RUN_Q_2_10 <= RUN_Q_2_10;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 11th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_11 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==10)&&(RUN_Q_2_11<15))
            RUN_Q_2_11 <= RUN_Q_2_11+1;
        else
            RUN_Q_2_11 <= RUN_Q_2_11;   
   end     
end

always@(posedge CLK_10M)     //The 20ms action that produces the forward action is decomposed, the 12th action
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_Q_2_12 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==4)&&(RUN_Q_1==11)&&(RUN_Q_2_12<15))
            RUN_Q_2_12 <= RUN_Q_2_12+1;
        else   
            RUN_Q_2_12 <= RUN_Q_2_12;
   end      
end
/*****************Running*****************/

/*****************Roll forward action generated*****************/
always@(posedge CLK_10M)     //10 control sequences that generate the forward roll: 400,700,500,300,600,600,600,400,400,900,1000 automatic attention
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_C <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_C<312))  
            RUN_QGF_C <= RUN_QGF_C + 1;
        else
        begin
            if(RUN_QGF_C==311)
                RUN_QGF_C <= 312;
            else    
                RUN_QGF_C <= RUN_QGF_C;
       end         
    end
end  

always@(posedge CLK_10M)     //10 control sequences that generate the forward roll: 400,700,500,300,600,600,600,400,400,900,1000 automatic attention
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_1 <= 0;
    else
    begin
        case(RUN_QGF_C)
        9'd20:RUN_QGF_1 <= 1;
        9'd55:RUN_QGF_1 <= 2;
        9'd80:RUN_QGF_1 <= 3;
        9'd95:RUN_QGF_1 <= 4;
        9'd125:RUN_QGF_1 <= 5;
        9'd155:RUN_QGF_1 <= 6;
        9'd185:RUN_QGF_1 <= 7;
        9'd205:RUN_QGF_1 <= 8;
        9'd225:RUN_QGF_1 <= 9;
        9'd310:RUN_QGF_1 <= 10;
       default:RUN_QGF_1 <= RUN_QGF_1;
    endcase    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the first movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_1 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==0)&&(RUN_QGF_2_1<20))
            RUN_QGF_2_1 <= RUN_QGF_2_1+1;
        else
            RUN_QGF_2_1 <= RUN_QGF_2_1;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the second movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_2 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==1)&&(RUN_QGF_2_2<35))
            RUN_QGF_2_2 <= RUN_QGF_2_2+1;
        else
            RUN_QGF_2_2 <= RUN_QGF_2_2;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 3th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_3 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==2)&&(RUN_QGF_2_3<25))
            RUN_QGF_2_3 <= RUN_QGF_2_3+1;
        else
            RUN_QGF_2_3 <= RUN_QGF_2_3;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 4th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_4 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==3)&&(RUN_QGF_2_4<15))
            RUN_QGF_2_4 <= RUN_QGF_2_4+1;
        else
            RUN_QGF_2_4 <= RUN_QGF_2_4;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 5th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_5 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==4)&&(RUN_QGF_2_5<30))
            RUN_QGF_2_5 <= RUN_QGF_2_5+1;
        else
            RUN_QGF_2_5 <= RUN_QGF_2_5;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 6th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_6 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==5)&&(RUN_QGF_2_6<30))
            RUN_QGF_2_6 <= RUN_QGF_2_6+1;
        else
            RUN_QGF_2_6 <= RUN_QGF_2_6;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 7th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_7 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==6)&&(RUN_QGF_2_7<30))
            RUN_QGF_2_7 <= RUN_QGF_2_7+1;
        else
            RUN_QGF_2_7 <= RUN_QGF_2_7;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 8th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_8 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==7)&&(RUN_QGF_2_8<20))
            RUN_QGF_2_8 <= RUN_QGF_2_8+1;
        else
            RUN_QGF_2_8 <= RUN_QGF_2_8;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 9th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_9 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==8)&&(RUN_QGF_2_9<20))
            RUN_QGF_2_9 <= RUN_QGF_2_9+1;
        else
            RUN_QGF_2_9 <= RUN_QGF_2_9;    
   end     
end

always@(posedge CLK_10M)     //The 20ms movement that produces the forward roll is broken down, the 10th movement
begin
    if((SW1_TMP==1)||(BT_SW2_TMP==1)||(SW2_TMP==1))
        RUN_QGF_2_10 <= 0;
    else
    begin
        if((Count_20ms_TMP==1)&&(Count_CTRL==5)&&(RUN_QGF_1==9)&&(RUN_QGF_2_10<45))
            RUN_QGF_2_10 <= RUN_QGF_2_10+1;
        else
            RUN_QGF_2_10 <= RUN_QGF_2_10;    
   end     
end
/*****************Roll forward action generated*****************/

/*****************Action assignment*****************/
always@(posedge CLK_10M)
begin
    case(Count_CTRL)      //reset后要立正
    8'd0:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12000+DJ_ID2;
        RUN_Q12 <= 15000+DJ_ID3;
        RUN_Q13 <= 17500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 17000+DJ_ID6;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 18000+DJ_ID10;
        RUN_Q110 <= 15000+DJ_ID11;
        RUN_Q111 <= 12500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 11000+DJ_ID16;
//           case(RUN_L_2_1)
//6'd60:begin
//RUN_Q10 <= 15000+DJ_ID1;
//RUN_Q11 <= 12000+DJ_ID2;
//RUN_Q12 <= 15000+DJ_ID3;
//RUN_Q13 <= 17500+DJ_ID4;
//RUN_Q14 <= 15000+DJ_ID5;
//RUN_Q15 <= 17000+DJ_ID6;
//RUN_Q16 <= 23000+DJ_ID7;
//RUN_Q17 <= 19000+DJ_ID8;
//RUN_Q18 <= 15000+DJ_ID9;
//RUN_Q19 <= 18000+DJ_ID10;
//RUN_Q110 <= 15000+DJ_ID11;
//RUN_Q111 <= 12500+DJ_ID12;
//RUN_Q112 <= 15000+DJ_ID13;
//RUN_Q113 <= 13000+DJ_ID14;
//RUN_Q114 <= 7000+DJ_ID15;
//RUN_Q115 <= 11000+DJ_ID16;
//end
//default:begin
//RUN_Q10 <= 15000+DJ_ID1;
//RUN_Q11 <= 7100+DJ_ID2+82*RUN_L_2_1;
//RUN_Q12 <= 22400+DJ_ID3-123*RUN_L_2_1;
//RUN_Q13 <= 23500+DJ_ID4-100*RUN_L_2_1;
//RUN_Q14 <= 15000+DJ_ID5;
//RUN_Q15 <= 16000+DJ_ID6+17*RUN_L_2_1;
//RUN_Q16 <= 23000+DJ_ID7;
//RUN_Q17 <= 19000+DJ_ID8;
//RUN_Q18 <= 15000+DJ_ID9;
//RUN_Q19 <= 22900+DJ_ID10-82*RUN_L_2_1;
//RUN_Q110 <= 7600+DJ_ID11+123*RUN_L_2_1;
//RUN_Q111 <= 6500+DJ_ID12+100*RUN_L_2_1;
//RUN_Q112 <= 15000+DJ_ID13;
//RUN_Q113 <= 14000+DJ_ID14-17*RUN_L_2_1;
//RUN_Q114 <= 7000+DJ_ID15;
//RUN_Q115 <= 11000+DJ_ID16;
//end
//endcase
    end
    
    8'd1:begin            //squat
        case(RUN_X_1)
        3'd0:begin        
            case(RUN_X_2_1)
            6'd60:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 7100+DJ_ID2;
            RUN_Q12 <= 22400+DJ_ID3;
            RUN_Q13 <= 23500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 16000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 22900+DJ_ID10;
            RUN_Q110 <= 7600+DJ_ID11;
            RUN_Q111 <= 6500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 14000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
            default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12000+DJ_ID2-82*RUN_X_2_1;
            RUN_Q12 <= 15000+DJ_ID3+123*RUN_X_2_1;
            RUN_Q13 <= 17500+DJ_ID4+100*RUN_X_2_1;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6-17*RUN_X_2_1;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 18000+DJ_ID10+82*RUN_X_2_1;
            RUN_Q110 <= 15000+DJ_ID11-123*RUN_X_2_1;
            RUN_Q111 <= 12500+DJ_ID12-100*RUN_X_2_1;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14+17*RUN_X_2_1;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
            endcase
       end
       3'd1:begin        
           case(RUN_L_2_1)
           6'd60:begin
           RUN_Q10 <= 15000+DJ_ID1;
           RUN_Q11 <= 12000+DJ_ID2;
           RUN_Q12 <= 15000+DJ_ID3;
           RUN_Q13 <= 17500+DJ_ID4;
           RUN_Q14 <= 15000+DJ_ID5;
           RUN_Q15 <= 17000+DJ_ID6;
           RUN_Q16 <= 23000+DJ_ID7;
           RUN_Q17 <= 19000+DJ_ID8;
           RUN_Q18 <= 15000+DJ_ID9;
           RUN_Q19 <= 18000+DJ_ID10;
           RUN_Q110 <= 15000+DJ_ID11;
           RUN_Q111 <= 12500+DJ_ID12;
           RUN_Q112 <= 15000+DJ_ID13;
           RUN_Q113 <= 13000+DJ_ID14;
           RUN_Q114 <= 7000+DJ_ID15;
           RUN_Q115 <= 11000+DJ_ID16;
           end
           default:begin
           RUN_Q10 <= 15000+DJ_ID1;
           RUN_Q11 <= 7100+DJ_ID2+82*RUN_L_2_1;
           RUN_Q12 <= 22400+DJ_ID3-123*RUN_L_2_1;
           RUN_Q13 <= 23500+DJ_ID4-100*RUN_L_2_1;
           RUN_Q14 <= 15000+DJ_ID5;
           RUN_Q15 <= 16000+DJ_ID6+17*RUN_L_2_1;
           RUN_Q16 <= 23000+DJ_ID7;
           RUN_Q17 <= 19000+DJ_ID8;
           RUN_Q18 <= 15000+DJ_ID9;
           RUN_Q19 <= 22900+DJ_ID10-82*RUN_L_2_1;
           RUN_Q110 <= 7600+DJ_ID11+123*RUN_L_2_1;
           RUN_Q111 <= 6500+DJ_ID12+100*RUN_L_2_1;
           RUN_Q112 <= 15000+DJ_ID13;
           RUN_Q113 <= 14000+DJ_ID14-17*RUN_L_2_1;
           RUN_Q114 <= 7000+DJ_ID15;
           RUN_Q115 <= 11000+DJ_ID16;
           end
           endcase
      end 
      endcase    
    end
    
    8'd2:begin              //bowing
        case(RUN_J_1)
        3'd0:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12000+DJ_ID2+120*RUN_J_2_1;
        RUN_Q12 <= 15000+DJ_ID3-140*RUN_J_2_1;
        RUN_Q13 <= 17500+DJ_ID4-100*RUN_J_2_1;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 17000+DJ_ID6-80*RUN_J_2_1;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 18000+DJ_ID10-120*RUN_J_2_1;
        RUN_Q110 <= 15000+DJ_ID11+140*RUN_J_2_1;
        RUN_Q111 <= 12500+DJ_ID12+100*RUN_J_2_1;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14+80*RUN_J_2_1;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 11000+DJ_ID16;
        end   
        3'd1:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 15000+DJ_ID6;
        RUN_Q16 <= 23000+DJ_ID7+42*RUN_J_2_2;
        RUN_Q17 <= 19000+DJ_ID8-284*RUN_J_2_2;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15000+DJ_ID14;
        RUN_Q114 <= 7000+DJ_ID15-42*RUN_J_2_2;
        RUN_Q115 <= 11000+DJ_ID16+248*RUN_J_2_2;
        end   
        3'd2:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 15000+DJ_ID6+250*RUN_J_2_3;
        RUN_Q16 <= 24050+DJ_ID7+38*RUN_J_2_3;
        RUN_Q17 <= 11900+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15000+DJ_ID14-250*RUN_J_2_3;
        RUN_Q114 <= 5950+DJ_ID15-38*RUN_J_2_3;
        RUN_Q115 <= 18100+DJ_ID16;
        end   
        3'd3:begin
        case(RUN_J_2_4)
        6'd35:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 13810+DJ_ID3;
            RUN_Q13 <= 21900+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 23100+DJ_ID6;
            RUN_Q16 <= 25000+DJ_ID7;
            RUN_Q17 <= 11900+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 16190+DJ_ID11;
            RUN_Q111 <= 8100+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 6900+DJ_ID14;
            RUN_Q114 <= 5000+DJ_ID15;
            RUN_Q115 <= 18100+DJ_ID16;
        end   
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 11500+DJ_ID3+66*RUN_J_2_4;
            RUN_Q13 <= 15000+DJ_ID4+197*RUN_J_2_4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 21250+DJ_ID6+53*RUN_J_2_4;
            RUN_Q16 <= 25000+DJ_ID7;
            RUN_Q17 <= 11900+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 18500+DJ_ID11-66*RUN_J_2_4;
            RUN_Q111 <= 15000+DJ_ID12-197*RUN_J_2_4;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 8750+DJ_ID14-53*RUN_J_2_4;
            RUN_Q114 <= 5000+DJ_ID15;
            RUN_Q115 <= 18100+DJ_ID16;
        end
        endcase
        end        
        3'd4:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 13810+DJ_ID3;
        RUN_Q13 <= 21900+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 23100+DJ_ID6;
        RUN_Q16 <= 25000+DJ_ID7;
        RUN_Q17 <= 11900+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 16190+DJ_ID11;
        RUN_Q111 <= 8100+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 6900+DJ_ID14;
        RUN_Q114 <= 5000+DJ_ID15;
        RUN_Q115 <= 18100+DJ_ID16;
        end   
        3'd5:begin
        case(RUN_J_2_6)
        6'd30:begin        
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 11500+DJ_ID3;
            RUN_Q13 <= 15000+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 21250+DJ_ID6;
            RUN_Q16 <= 23130+DJ_ID7;
            RUN_Q17 <= 11900+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 18500+DJ_ID11;
            RUN_Q111 <= 15000+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 8750+DJ_ID14;
            RUN_Q114 <= 6870+DJ_ID15;
            RUN_Q115 <= 18100+DJ_ID16;
        end 
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 13810+DJ_ID3-77*RUN_J_2_6;
            RUN_Q13 <= 21900+DJ_ID4-230*RUN_J_2_6;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 23100+DJ_ID6-62*RUN_J_2_6;
            RUN_Q16 <= 25000+DJ_ID7-62*RUN_J_2_6;
            RUN_Q17 <= 11900+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 16190+DJ_ID11+77*RUN_J_2_6;
            RUN_Q111 <= 8100+DJ_ID12+230*RUN_J_2_6;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 6900+DJ_ID14+62*RUN_J_2_6;
            RUN_Q114 <= 5000+DJ_ID15+62*RUN_J_2_6;
            RUN_Q115 <= 18100+DJ_ID16;
        end
        endcase
        end          
        3'd6:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2-112*RUN_J_2_7;
        RUN_Q12 <= 11500+DJ_ID3+140*RUN_J_2_7;
        RUN_Q13 <= 15000+DJ_ID4+100*RUN_J_2_7;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 21250+DJ_ID6-170*RUN_J_2_7;
        RUN_Q16 <= 23130+DJ_ID7-5*RUN_J_2_7;
        RUN_Q17 <= 11900+DJ_ID8+284*RUN_J_2_7;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10+112*RUN_J_2_7;
        RUN_Q110 <= 18500+DJ_ID11-140*RUN_J_2_7;
        RUN_Q111 <= 15000+DJ_ID12-100*RUN_J_2_7;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 8750+DJ_ID14+170*RUN_J_2_7;
        RUN_Q114 <= 6870+DJ_ID15+5*RUN_J_2_7;
        RUN_Q115 <= 18100+DJ_ID16-284*RUN_J_2_7;
        end
        3'd7:begin      //standing up
           case(RUN_L_2_1)
            6'd60:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12000+DJ_ID2;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 18000+DJ_ID10;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
            default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12200+DJ_ID2-3*RUN_L_2_1;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 17800+DJ_ID10+3*RUN_L_2_1;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        endcase
        end 
   endcase
   end     

    8'd3:begin              //waving hand
        case(RUN_HS_1)
        4'd0:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12000+DJ_ID2+120*RUN_HS_2_1;
        RUN_Q12 <= 15000+DJ_ID3-140*RUN_HS_2_1;
        RUN_Q13 <= 17500+DJ_ID4-100*RUN_HS_2_1;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 17000+DJ_ID6-80*RUN_HS_2_1;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 18000+DJ_ID10-120*RUN_HS_2_1;
        RUN_Q110 <= 15000+DJ_ID11+140*RUN_HS_2_1;
        RUN_Q111 <= 12500+DJ_ID12+100*RUN_HS_2_1;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14+80*RUN_HS_2_1;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 11000+DJ_ID16;
        end   
        4'd1:begin
        case(RUN_HS_2_2)
        6'd25:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 11500+DJ_ID3;
            RUN_Q13 <= 15000+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 16000+DJ_ID6;
            RUN_Q16 <= 22000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 18500+DJ_ID11;
            RUN_Q111 <= 15000+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 10120+DJ_ID14;
            RUN_Q114 <= 6630+DJ_ID15;
            RUN_Q115 <= 20120+DJ_ID16;
            end
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2;
            RUN_Q12 <= 11500+DJ_ID3;
            RUN_Q13 <= 15000+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 15000+DJ_ID6+40*RUN_HS_2_2;
            RUN_Q16 <= 23000+DJ_ID7-40*RUN_HS_2_2;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10;
            RUN_Q110 <= 18500+DJ_ID11;
            RUN_Q111 <= 15000+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 15000+DJ_ID14-195*RUN_HS_2_2;
            RUN_Q114 <= 7000+DJ_ID15-15*RUN_HS_2_2;
            RUN_Q115 <= 11000+DJ_ID16+365*RUN_HS_2_2;            
        end
        endcase
        end   
        4'd2:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 10120+DJ_ID14-372*RUN_HS_2_3;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end   
        4'd3:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 6400+DJ_ID14+660*RUN_HS_2_4;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end   
        4'd4:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14-660*RUN_HS_2_5;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end   
        4'd5:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 6400+DJ_ID14+660*RUN_HS_2_6;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end   
        4'd6:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14-660*RUN_HS_2_7;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end
        4'd7:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 6400+DJ_ID14+660*RUN_HS_2_8;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end
        4'd8:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14-660*RUN_HS_2_9;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end
         4'd9:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 15000+DJ_ID2;
        RUN_Q12 <= 11500+DJ_ID3;
        RUN_Q13 <= 15000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 15000+DJ_ID10;
        RUN_Q110 <= 18500+DJ_ID11;
        RUN_Q111 <= 15000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 6400+DJ_ID14+660*RUN_HS_2_10;
        RUN_Q114 <= 6630+DJ_ID15;
        RUN_Q115 <= 20120+DJ_ID16;
        end
         4'd10:begin
         case(RUN_HS_2_11)
         6'd25:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12200+DJ_ID2;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 17800+DJ_ID10;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        default:begin              
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 15000+DJ_ID2-112*RUN_HS_2_11;
            RUN_Q12 <= 11500+DJ_ID3+140*RUN_HS_2_11;
            RUN_Q13 <= 15000+DJ_ID4+100*RUN_HS_2_11;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 16000+DJ_ID6+40*RUN_HS_2_11;
            RUN_Q16 <= 22000+DJ_ID7+40*RUN_HS_2_11;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 15000+DJ_ID10+112*RUN_HS_2_11;
            RUN_Q110 <= 18500+DJ_ID11-140*RUN_HS_2_11;
            RUN_Q111 <= 15000+DJ_ID12-100*RUN_HS_2_11;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 6630+DJ_ID15+15*RUN_HS_2_11;
            RUN_Q115 <= 20120+DJ_ID16-365*RUN_HS_2_11;
            end
          endcase  
       end 
       4'd11:begin      //standing up automatically
       case(RUN_L_2_1)
       6'd60:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12000+DJ_ID2;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 18000+DJ_ID10;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12200+DJ_ID2-3*RUN_L_2_1;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 17800+DJ_ID10+3*RUN_L_2_1;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        endcase
     end          
   endcase
   end     

    8'd4:begin              //running
        case(RUN_Q_1)
        4'd0:begin
            case(RUN_Q_2_1)
            6'd15:begin
            RUN_Q10 <= 15800+DJ_ID1;
            RUN_Q11 <= 15500+DJ_ID2;
            RUN_Q12 <= 13700+DJ_ID3;
            RUN_Q13 <= 19300+DJ_ID4;
            RUN_Q14 <= 15800+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 20000+DJ_ID8;
            RUN_Q18 <= 15800+DJ_ID9;
            RUN_Q19 <= 17200+DJ_ID10;
            RUN_Q110 <= 16100+DJ_ID11;
            RUN_Q111 <= 13500+DJ_ID12;
            RUN_Q112 <= 15500+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 13500+DJ_ID16;
            end
            default:begin
            RUN_Q10 <= 15000+DJ_ID1+53*RUN_Q_2_1;
            RUN_Q11 <= 12000+DJ_ID2+233*RUN_Q_2_1;
            RUN_Q12 <= 15000+DJ_ID3-87*RUN_Q_2_1;
            RUN_Q13 <= 17500+DJ_ID4+120*RUN_Q_2_1;
            RUN_Q14 <= 15000+DJ_ID5+53*RUN_Q_2_1;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8+67*RUN_Q_2_1;
            RUN_Q18 <= 15000+DJ_ID9+53*RUN_Q_2_1;
            RUN_Q19 <= 18000+DJ_ID10-53*RUN_Q_2_1;
            RUN_Q110 <= 15000+DJ_ID11+73*RUN_Q_2_1;
            RUN_Q111 <= 12500+DJ_ID12+67*RUN_Q_2_1;
            RUN_Q112 <= 15000+DJ_ID13+33*RUN_Q_2_1;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16+167*RUN_Q_2_1;
            end
            endcase            
        end   
        4'd1:begin
            case(RUN_Q_2_2)
            6'd15:begin
                RUN_Q10 <= 14000+DJ_ID1;
                RUN_Q11 <= 13800+DJ_ID2;
                RUN_Q12 <= 14000+DJ_ID3;
                RUN_Q13 <= 18300+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 13600+DJ_ID9;
                RUN_Q19 <= 18000+DJ_ID10;
                RUN_Q110 <= 15160+DJ_ID11;
                RUN_Q111 <= 12800+DJ_ID12;
                RUN_Q112 <= 14000+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
            default:begin
                RUN_Q10 <= 15800+DJ_ID1-120*RUN_Q_2_2;
                RUN_Q11 <= 15500+DJ_ID2-113*RUN_Q_2_2;
                RUN_Q12 <= 13700+DJ_ID3+20*RUN_Q_2_2;
                RUN_Q13 <= 19300+DJ_ID4-67*RUN_Q_2_2;
                RUN_Q14 <= 15800+DJ_ID5-87*RUN_Q_2_2;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 20000+DJ_ID8-67*RUN_Q_2_2;
                RUN_Q18 <= 15800+DJ_ID9-147*RUN_Q_2_2;
                RUN_Q19 <= 17200+DJ_ID10+53*RUN_Q_2_2;
                RUN_Q110 <= 16100+DJ_ID11-63*RUN_Q_2_2;
                RUN_Q111 <= 13500+DJ_ID12-47*RUN_Q_2_2;
                RUN_Q112 <= 15500+DJ_ID13-100*RUN_Q_2_2;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 13500+DJ_ID16-167*RUN_Q_2_2;      
                end
                endcase          
            end 
        4'd2:begin
             case(RUN_Q_2_3)
             6'd15:begin
                RUN_Q10 <= 14200+DJ_ID1;
                RUN_Q11 <= 12800+DJ_ID2;
                RUN_Q12 <= 13900+DJ_ID3;
                RUN_Q13 <= 16500+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8;
                RUN_Q18 <= 14200+DJ_ID9;
                RUN_Q19 <= 14500+DJ_ID10;
                RUN_Q110 <= 16300+DJ_ID11;
                RUN_Q111 <= 10700+DJ_ID12;
                RUN_Q112 <= 14200+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16;
                end
            default:begin
                RUN_Q10 <= 14000+DJ_ID1+13*RUN_Q_2_3;
                RUN_Q11 <= 13800+DJ_ID2-67*RUN_Q_2_3;
                RUN_Q12 <= 14000+DJ_ID3-7*RUN_Q_2_3;
                RUN_Q13 <= 18300+DJ_ID4-120*RUN_Q_2_3;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8-167*RUN_Q_2_3;
                RUN_Q18 <= 13600+DJ_ID9+40*RUN_Q_2_3;
                RUN_Q19 <= 18000+DJ_ID10-233*RUN_Q_2_3;
                RUN_Q110 <= 15160+DJ_ID11+76*RUN_Q_2_3;
                RUN_Q111 <= 12800+DJ_ID12-140*RUN_Q_2_3;
                RUN_Q112 <= 14000+DJ_ID13+13*RUN_Q_2_3;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16-67*RUN_Q_2_3;
                end
                endcase                    
            end
            4'd3:begin
                case(RUN_Q_2_4)
                6'd15:begin
                RUN_Q10 <= 16400+DJ_ID1;
                RUN_Q11 <= 12000+DJ_ID2;
                RUN_Q12 <= 14850+DJ_ID3;
                RUN_Q13 <= 17200+DJ_ID4;
                RUN_Q14 <= 16000+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 16000+DJ_ID9;
                RUN_Q19 <= 16200+DJ_ID10;
                RUN_Q110 <= 16000+DJ_ID11;
                RUN_Q111 <= 11700+DJ_ID12;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 14200+DJ_ID1+147*RUN_Q_2_4;
                RUN_Q11 <= 12800+DJ_ID2-53*RUN_Q_2_4;
                RUN_Q12 <= 13900+DJ_ID3+63*RUN_Q_2_4;
                RUN_Q13 <= 16500+DJ_ID4+47*RUN_Q_2_4;
                RUN_Q14 <= 14500+DJ_ID5+100*RUN_Q_2_4;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8+167*RUN_Q_2_4;
                RUN_Q18 <= 14200+DJ_ID9+120*RUN_Q_2_4;
                RUN_Q19 <= 14500+DJ_ID10+113*RUN_Q_2_4;
                RUN_Q110 <= 16300+DJ_ID11-20*RUN_Q_2_4;
                RUN_Q111 <= 10700+DJ_ID12+67*RUN_Q_2_4;
                RUN_Q112 <= 14200+DJ_ID13+87*RUN_Q_2_4;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16+67*RUN_Q_2_4;   
                end
                endcase                    
            end
            4'd4:begin
                case(RUN_Q_2_5)
                6'd15:begin
                RUN_Q10 <= 15800+DJ_ID1;
                RUN_Q11 <= 15500+DJ_ID2;
                RUN_Q12 <= 13700+DJ_ID3;
                RUN_Q13 <= 19300+DJ_ID4;
                RUN_Q14 <= 15800+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 20000+DJ_ID8;
                RUN_Q18 <= 15800+DJ_ID9;
                RUN_Q19 <= 17200+DJ_ID10;
                RUN_Q110 <= 16100+DJ_ID11;
                RUN_Q111 <= 13500+DJ_ID12;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 13500+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 16400+DJ_ID1-40*RUN_Q_2_5;
                RUN_Q11 <= 12000+DJ_ID2+233*RUN_Q_2_5;
                RUN_Q12 <= 14850+DJ_ID3-77*RUN_Q_2_5;
                RUN_Q13 <= 17200+DJ_ID4+140*RUN_Q_2_5;
                RUN_Q14 <= 16000+DJ_ID5-13*RUN_Q_2_5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8+67*RUN_Q_2_5;
                RUN_Q18 <= 16000+DJ_ID9-13*RUN_Q_2_5;
                RUN_Q19 <= 16200+DJ_ID10+67*RUN_Q_2_5;
                RUN_Q110 <= 16000+DJ_ID11+7*RUN_Q_2_5;
                RUN_Q111 <= 11700+DJ_ID12+120*RUN_Q_2_5;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16+167*RUN_Q_2_5;
                end
                endcase            
            end   
            4'd5:begin
                case(RUN_Q_2_6)
                6'd15:begin
                RUN_Q10 <= 14000+DJ_ID1;
                RUN_Q11 <= 13800+DJ_ID2;
                RUN_Q12 <= 14000+DJ_ID3;
                RUN_Q13 <= 18300+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 13600+DJ_ID9;
                RUN_Q19 <= 18000+DJ_ID10;
                RUN_Q110 <= 15160+DJ_ID11;
                RUN_Q111 <= 12800+DJ_ID12;
                RUN_Q112 <= 14000+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 15800+DJ_ID1-120*RUN_Q_2_6;
                RUN_Q11 <= 15500+DJ_ID2-113*RUN_Q_2_6;
                RUN_Q12 <= 13700+DJ_ID3+20*RUN_Q_2_6;
                RUN_Q13 <= 19300+DJ_ID4-67*RUN_Q_2_6;
                RUN_Q14 <= 15800+DJ_ID5-87*RUN_Q_2_6;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 20000+DJ_ID8-67*RUN_Q_2_6;
                RUN_Q18 <= 15800+DJ_ID9-147*RUN_Q_2_6;
                RUN_Q19 <= 17200+DJ_ID10+53*RUN_Q_2_6;
                RUN_Q110 <= 16100+DJ_ID11-63*RUN_Q_2_6;
                RUN_Q111 <= 13500+DJ_ID12-47*RUN_Q_2_6;
                RUN_Q112 <= 15500+DJ_ID13-100*RUN_Q_2_6;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 13500+DJ_ID16-167*RUN_Q_2_6;      
                end
                endcase          
            end 
            4'd6:begin
                case(RUN_Q_2_7)
                6'd15:begin
                RUN_Q10 <= 14200+DJ_ID1;
                RUN_Q11 <= 12800+DJ_ID2;
                RUN_Q12 <= 13900+DJ_ID3;
                RUN_Q13 <= 16500+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8;
                RUN_Q18 <= 14200+DJ_ID9;
                RUN_Q19 <= 14500+DJ_ID10;
                RUN_Q110 <= 16300+DJ_ID11;
                RUN_Q111 <= 10700+DJ_ID12;
                RUN_Q112 <= 14200+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 14000+DJ_ID1+13*RUN_Q_2_7;
                RUN_Q11 <= 13800+DJ_ID2-67*RUN_Q_2_7;
                RUN_Q12 <= 14000+DJ_ID3-7*RUN_Q_2_7;
                RUN_Q13 <= 18300+DJ_ID4-120*RUN_Q_2_7;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8-167*RUN_Q_2_7;
                RUN_Q18 <= 13600+DJ_ID9+40*RUN_Q_2_7;
                RUN_Q19 <= 18000+DJ_ID10-233*RUN_Q_2_7;
                RUN_Q110 <= 15160+DJ_ID11+76*RUN_Q_2_7;
                RUN_Q111 <= 12800+DJ_ID12-140*RUN_Q_2_7;
                RUN_Q112 <= 14000+DJ_ID13+13*RUN_Q_2_7;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16-67*RUN_Q_2_7;
                end
                endcase                    
            end
            4'd7:begin
                case(RUN_Q_2_8)
                6'd15:begin
                RUN_Q10 <= 16400+DJ_ID1;
                RUN_Q11 <= 12000+DJ_ID2;
                RUN_Q12 <= 14850+DJ_ID3;
                RUN_Q13 <= 17200+DJ_ID4;
                RUN_Q14 <= 16000+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 16000+DJ_ID9;
                RUN_Q19 <= 16200+DJ_ID10;
                RUN_Q110 <= 16000+DJ_ID11;
                RUN_Q111 <= 11700+DJ_ID12;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 14200+DJ_ID1+147*RUN_Q_2_8;
                RUN_Q11 <= 12800+DJ_ID2-53*RUN_Q_2_8;
                RUN_Q12 <= 13900+DJ_ID3+63*RUN_Q_2_8;
                RUN_Q13 <= 16500+DJ_ID4+47*RUN_Q_2_8;
                RUN_Q14 <= 14500+DJ_ID5+100*RUN_Q_2_8;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8+167*RUN_Q_2_8;
                RUN_Q18 <= 14200+DJ_ID9+120*RUN_Q_2_8;
                RUN_Q19 <= 14500+DJ_ID10+113*RUN_Q_2_8;
                RUN_Q110 <= 16300+DJ_ID11-20*RUN_Q_2_8;
                RUN_Q111 <= 10700+DJ_ID12+67*RUN_Q_2_8;
                RUN_Q112 <= 14200+DJ_ID13+87*RUN_Q_2_8;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16+67*RUN_Q_2_8;   
                end
                endcase                    
            end
            4'd8:begin
                case(RUN_Q_2_9)
                6'd15:begin
                RUN_Q10 <= 15800+DJ_ID1;
                RUN_Q11 <= 15500+DJ_ID2;
                RUN_Q12 <= 13700+DJ_ID3;
                RUN_Q13 <= 19300+DJ_ID4;
                RUN_Q14 <= 15800+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 20000+DJ_ID8;
                RUN_Q18 <= 15800+DJ_ID9;
                RUN_Q19 <= 17200+DJ_ID10;
                RUN_Q110 <= 16100+DJ_ID11;
                RUN_Q111 <= 13500+DJ_ID12;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 13500+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 16400+DJ_ID1-40*RUN_Q_2_9;
                RUN_Q11 <= 12000+DJ_ID2+233*RUN_Q_2_9;
                RUN_Q12 <= 14850+DJ_ID3-77*RUN_Q_2_9;
                RUN_Q13 <= 17200+DJ_ID4+140*RUN_Q_2_9;
                RUN_Q14 <= 16000+DJ_ID5-13*RUN_Q_2_9;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8+67*RUN_Q_2_9;
                RUN_Q18 <= 16000+DJ_ID9-13*RUN_Q_2_9;
                RUN_Q19 <= 16200+DJ_ID10+67*RUN_Q_2_9;
                RUN_Q110 <= 16000+DJ_ID11+7*RUN_Q_2_9;
                RUN_Q111 <= 11700+DJ_ID12+120*RUN_Q_2_9;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16+167*RUN_Q_2_9;
                end
                endcase            
            end   
            4'd9:begin
                case(RUN_Q_2_10)
                6'd15:begin
                RUN_Q10 <= 14000+DJ_ID1;
                RUN_Q11 <= 13800+DJ_ID2;
                RUN_Q12 <= 14000+DJ_ID3;
                RUN_Q13 <= 18300+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 13600+DJ_ID9;
                RUN_Q19 <= 18000+DJ_ID10;
                RUN_Q110 <= 15160+DJ_ID11;
                RUN_Q111 <= 12800+DJ_ID12;
                RUN_Q112 <= 14000+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 15800+DJ_ID1-120*RUN_Q_2_10;
                RUN_Q11 <= 15500+DJ_ID2-113*RUN_Q_2_10;
                RUN_Q12 <= 13700+DJ_ID3+20*RUN_Q_2_10;
                RUN_Q13 <= 19300+DJ_ID4-67*RUN_Q_2_10;
                RUN_Q14 <= 15800+DJ_ID5-87*RUN_Q_2_10;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 20000+DJ_ID8-67*RUN_Q_2_10;
                RUN_Q18 <= 15800+DJ_ID9-147*RUN_Q_2_10;
                RUN_Q19 <= 17200+DJ_ID10+53*RUN_Q_2_10;
                RUN_Q110 <= 16100+DJ_ID11-63*RUN_Q_2_10;
                RUN_Q111 <= 13500+DJ_ID12-47*RUN_Q_2_10;
                RUN_Q112 <= 15500+DJ_ID13-100*RUN_Q_2_10;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 13500+DJ_ID16-167*RUN_Q_2_10;      
                end
                endcase          
            end 
            4'd10:begin
                case(RUN_Q_2_11)
                6'd15:begin
                RUN_Q10 <= 14200+DJ_ID1;
                RUN_Q11 <= 12800+DJ_ID2;
                RUN_Q12 <= 13900+DJ_ID3;
                RUN_Q13 <= 16500+DJ_ID4;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8;
                RUN_Q18 <= 14200+DJ_ID9;
                RUN_Q19 <= 14500+DJ_ID10;
                RUN_Q110 <= 16300+DJ_ID11;
                RUN_Q111 <= 10700+DJ_ID12;
                RUN_Q112 <= 14200+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 14000+DJ_ID1+13*RUN_Q_2_11;
                RUN_Q11 <= 13800+DJ_ID2-67*RUN_Q_2_11;
                RUN_Q12 <= 14000+DJ_ID3-7*RUN_Q_2_11;
                RUN_Q13 <= 18300+DJ_ID4-120*RUN_Q_2_11;
                RUN_Q14 <= 14500+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8-167*RUN_Q_2_11;
                RUN_Q18 <= 13600+DJ_ID9+40*RUN_Q_2_11;
                RUN_Q19 <= 18000+DJ_ID10-233*RUN_Q_2_11;
                RUN_Q110 <= 15160+DJ_ID11+76*RUN_Q_2_11;
                RUN_Q111 <= 12800+DJ_ID12-140*RUN_Q_2_11;
                RUN_Q112 <= 14000+DJ_ID13+13*RUN_Q_2_11;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16-67*RUN_Q_2_11;
                end
                endcase                    
            end
            4'd11:begin
                case(RUN_Q_2_12)
                6'd15:begin
                RUN_Q10 <= 16400+DJ_ID1;
                RUN_Q11 <= 12000+DJ_ID2;
                RUN_Q12 <= 14850+DJ_ID3;
                RUN_Q13 <= 17200+DJ_ID4;
                RUN_Q14 <= 16000+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 16000+DJ_ID9;
                RUN_Q19 <= 16200+DJ_ID10;
                RUN_Q110 <= 16000+DJ_ID11;
                RUN_Q111 <= 11700+DJ_ID12;
                RUN_Q112 <= 15500+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 14200+DJ_ID1+147*RUN_Q_2_12;
                RUN_Q11 <= 12800+DJ_ID2-53*RUN_Q_2_12;
                RUN_Q12 <= 13900+DJ_ID3+63*RUN_Q_2_12;
                RUN_Q13 <= 16500+DJ_ID4+47*RUN_Q_2_12;
                RUN_Q14 <= 14500+DJ_ID5+100*RUN_Q_2_12;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 16500+DJ_ID8+167*RUN_Q_2_12;
                RUN_Q18 <= 14200+DJ_ID9+120*RUN_Q_2_12;
                RUN_Q19 <= 14500+DJ_ID10+113*RUN_Q_2_12;
                RUN_Q110 <= 16300+DJ_ID11-20*RUN_Q_2_12;
                RUN_Q111 <= 10700+DJ_ID12+67*RUN_Q_2_12;
                RUN_Q112 <= 14200+DJ_ID13+87*RUN_Q_2_12;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 10000+DJ_ID16+67*RUN_Q_2_12;   
                end
                endcase                    
            end
            4'd12:begin       //standing up automatically 
                case(RUN_L_2_1)
                6'd60:begin
                RUN_Q10 <= 15000+DJ_ID1;
                RUN_Q11 <= 12000+DJ_ID2;
                RUN_Q12 <= 15000+DJ_ID3;
                RUN_Q13 <= 17500+DJ_ID4;
                RUN_Q14 <= 15000+DJ_ID5;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 15000+DJ_ID9;
                RUN_Q19 <= 18000+DJ_ID10;
                RUN_Q110 <= 15000+DJ_ID11;
                RUN_Q111 <= 12500+DJ_ID12;
                RUN_Q112 <= 15000+DJ_ID13;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                default:begin
                RUN_Q10 <= 16400+DJ_ID1-23*RUN_L_2_1;
                RUN_Q11 <= 12000+DJ_ID2;
                RUN_Q12 <= 14850+DJ_ID3+3*RUN_L_2_1;
                RUN_Q13 <= 17200+DJ_ID4+5*RUN_L_2_1;
                RUN_Q14 <= 16000+DJ_ID5-17*RUN_L_2_1;
                RUN_Q15 <= 17000+DJ_ID6;
                RUN_Q16 <= 23000+DJ_ID7;
                RUN_Q17 <= 19000+DJ_ID8;
                RUN_Q18 <= 16000+DJ_ID9-17*RUN_L_2_1;
                RUN_Q19 <= 16200+DJ_ID10+30*RUN_L_2_1;
                RUN_Q110 <= 16000+DJ_ID11-17*RUN_L_2_1;
                RUN_Q111 <= 11700+DJ_ID12+13*RUN_L_2_1;
                RUN_Q112 <= 15500+DJ_ID13-8*RUN_L_2_1;
                RUN_Q113 <= 13000+DJ_ID14;
                RUN_Q114 <= 7000+DJ_ID15;
                RUN_Q115 <= 11000+DJ_ID16;
                end
                endcase
            end 
       endcase                         
    end
 
     8'd5:begin              //forward roll
        case(RUN_QGF_1)
        6'd0:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12000+DJ_ID2+10*RUN_QGF_2_1;
        RUN_Q12 <= 15000+DJ_ID3-10*RUN_QGF_2_1;
        RUN_Q13 <= 17500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 17000+DJ_ID6;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 18000+DJ_ID10-10*RUN_QGF_2_1;
        RUN_Q110 <= 15000+DJ_ID11+10*RUN_QGF_2_1;
        RUN_Q111 <= 12500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 11000+DJ_ID16;
        end   
        6'd1:begin
        case(RUN_QGF_2_2)
        6'd35:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 19700+DJ_ID2;
            RUN_Q12 <= 7500+DJ_ID3;
            RUN_Q13 <= 22200+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 16000+DJ_ID6;
            RUN_Q16 <= 22440+DJ_ID7;
            RUN_Q17 <= 10000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 10300+DJ_ID10;
            RUN_Q110 <= 22500+DJ_ID11;
            RUN_Q111 <= 7800+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 14000+DJ_ID14;
            RUN_Q114 <= 7090+DJ_ID15;
            RUN_Q115 <= 20000+DJ_ID16;
            end
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12200+DJ_ID2+214*RUN_QGF_2_2;
            RUN_Q12 <= 14800+DJ_ID3-209*RUN_QGF_2_2;
            RUN_Q13 <= 17500+DJ_ID4+134*RUN_QGF_2_2;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6-29*RUN_QGF_2_2;
            RUN_Q16 <= 23000+DJ_ID7-16*RUN_QGF_2_2;
            RUN_Q17 <= 19000+DJ_ID8-257*RUN_QGF_2_2;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 17800+DJ_ID10-214*RUN_QGF_2_2;
            RUN_Q110 <= 15200+DJ_ID11+209*RUN_QGF_2_2;
            RUN_Q111 <= 12500+DJ_ID12-134*RUN_QGF_2_2;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14+29*RUN_QGF_2_2;
            RUN_Q114 <= 7000+DJ_ID15+3*RUN_QGF_2_2;
            RUN_Q115 <= 11000+DJ_ID16+257*RUN_QGF_2_2;            
        end
        endcase
        end   
        6'd2:begin
        case(RUN_QGF_2_3)
        6'd25:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14000+DJ_ID2;
        RUN_Q12 <= 7500+DJ_ID3;
        RUN_Q13 <= 22200+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 22000+DJ_ID6;
        RUN_Q16 <= 15000+DJ_ID7;
        RUN_Q17 <= 8950+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16000+DJ_ID10;
        RUN_Q110 <= 22500+DJ_ID11;
        RUN_Q111 <= 7800+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 8000+DJ_ID14;
        RUN_Q114 <= 15000+DJ_ID15;
        RUN_Q115 <= 20350+DJ_ID16;
        end
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 19700+DJ_ID2-228*RUN_QGF_2_3;
        RUN_Q12 <= 7500+DJ_ID3;
        RUN_Q13 <= 22200+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6+240*RUN_QGF_2_3;
        RUN_Q16 <= 22440+DJ_ID7-298*RUN_QGF_2_3;
        RUN_Q17 <= 10000+DJ_ID8-42*RUN_QGF_2_3;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 10300+DJ_ID10+228*RUN_QGF_2_3;
        RUN_Q110 <= 22500+DJ_ID11;
        RUN_Q111 <= 7800+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 14000+DJ_ID14-240*RUN_QGF_2_3;
        RUN_Q114 <= 7090+DJ_ID15+316*RUN_QGF_2_3;
        RUN_Q115 <= 20000+DJ_ID16+14*RUN_QGF_2_3;
        end
        endcase        
        end   
        6'd3:begin
        case(RUN_QGF_2_4)
        6'd15:begin        
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14000+DJ_ID2;
        RUN_Q12 <= 7500+DJ_ID3;
        RUN_Q13 <= 22200+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 22000+DJ_ID6;
        RUN_Q16 <= 15000+DJ_ID7;
        RUN_Q17 <= 12670+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16000+DJ_ID10;
        RUN_Q110 <= 22500+DJ_ID11;
        RUN_Q111 <= 7800+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 8000+DJ_ID14;
        RUN_Q114 <= 15000+DJ_ID15;
        RUN_Q115 <= 15930+DJ_ID16;
        end   
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14000+DJ_ID2;
        RUN_Q12 <= 7500+DJ_ID3;
        RUN_Q13 <= 22200+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 22000+DJ_ID6;
        RUN_Q16 <= 15000+DJ_ID7;
        RUN_Q17 <= 8950+DJ_ID8+248*RUN_QGF_2_4;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16000+DJ_ID10;
        RUN_Q110 <= 22500+DJ_ID11;
        RUN_Q111 <= 7800+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 8000+DJ_ID14;
        RUN_Q114 <= 15000+DJ_ID15;
        RUN_Q115 <= 20350+DJ_ID16-295*RUN_QGF_2_4;
        end
        endcase
        end        
        6'd4:begin
        case(RUN_QGF_2_5)
        6'd30:begin 
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14070+DJ_ID2;
        RUN_Q12 <= 13840+DJ_ID3;
        RUN_Q13 <= 5000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22440+DJ_ID7;
        RUN_Q17 <= 14070+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16160+DJ_ID10;
        RUN_Q110 <= 22670+DJ_ID11;
        RUN_Q111 <= 7790+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 14000+DJ_ID14;
        RUN_Q114 <= 7090+DJ_ID15;
        RUN_Q115 <= 16160+DJ_ID16;
        end   
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14000+DJ_ID2+2*RUN_QGF_2_5;
        RUN_Q12 <= 7500+DJ_ID3+211*RUN_QGF_2_5;
        RUN_Q13 <= 22200+DJ_ID4-573*RUN_QGF_2_5;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 22000+DJ_ID6-200*RUN_QGF_2_5;
        RUN_Q16 <= 15000+DJ_ID7+248*RUN_QGF_2_5;
        RUN_Q17 <= 12670+DJ_ID8+47*RUN_QGF_2_5;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16000+DJ_ID10+5*RUN_QGF_2_5;
        RUN_Q110 <= 22500+DJ_ID11+6*RUN_QGF_2_5;
        RUN_Q111 <= 7800+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 8000+DJ_ID14+200*RUN_QGF_2_5;
        RUN_Q114 <= 15000+DJ_ID15-264*RUN_QGF_2_5;
        RUN_Q115 <= 15930+DJ_ID16+8*RUN_QGF_2_5;
        end
        endcase
        end        
        6'd5:begin
        case(RUN_QGF_2_6)
        6'd30:begin        
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14070+DJ_ID2;
        RUN_Q12 <= 13840+DJ_ID3;
        RUN_Q13 <= 5000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22440+DJ_ID7;
        RUN_Q17 <= 8490+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16630+DJ_ID10;
        RUN_Q110 <= 15470+DJ_ID11;
        RUN_Q111 <= 25000+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 14000+DJ_ID14;
        RUN_Q114 <= 7090+DJ_ID15;
        RUN_Q115 <= 21510+DJ_ID16;
        end  
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14070+DJ_ID2;
        RUN_Q12 <= 13840+DJ_ID3;
        RUN_Q13 <= 5000+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6;
        RUN_Q16 <= 22440+DJ_ID7;
        RUN_Q17 <= 14070+DJ_ID8-186*RUN_QGF_2_6;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16160+DJ_ID10+16*RUN_QGF_2_6;
        RUN_Q110 <= 22670+DJ_ID11-240*RUN_QGF_2_6;
        RUN_Q111 <= 7790+DJ_ID12+574*RUN_QGF_2_6;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 14000+DJ_ID14;
        RUN_Q114 <= 7090+DJ_ID15;
        RUN_Q115 <= 16160+DJ_ID16+178*RUN_QGF_2_6;
        end
        endcase
        end         
        6'd6:begin
        case(RUN_QGF_2_7)
        6'd30:begin  
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12500+DJ_ID2;
        RUN_Q12 <= 14500+DJ_ID3;
        RUN_Q13 <= 5500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 14500+DJ_ID6;
        RUN_Q16 <= 5000+DJ_ID7;
        RUN_Q17 <= 15000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 17500+DJ_ID10;
        RUN_Q110 <= 15500+DJ_ID11;
        RUN_Q111 <= 24500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15500+DJ_ID14;
        RUN_Q114 <= 25000+DJ_ID15;
        RUN_Q115 <= 15000+DJ_ID16;
        end
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 14070+DJ_ID2-52*RUN_QGF_2_7;
        RUN_Q12 <= 13840+DJ_ID3+22*RUN_QGF_2_7;
        RUN_Q13 <= 5000+DJ_ID4+17*RUN_QGF_2_7;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 16000+DJ_ID6-50*RUN_QGF_2_7;
        RUN_Q16 <= 22440+DJ_ID7-581*RUN_QGF_2_7;
        RUN_Q17 <= 8490+DJ_ID8+217*RUN_QGF_2_7;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 16630+DJ_ID10+29*RUN_QGF_2_7;
        RUN_Q110 <= 15470+DJ_ID11+RUN_QGF_2_7;
        RUN_Q111 <= 25000+DJ_ID12-17*RUN_QGF_2_7;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 14000+DJ_ID14+50*RUN_QGF_2_7;
        RUN_Q114 <= 7090+DJ_ID15+597*RUN_QGF_2_7;
        RUN_Q115 <= 21510+DJ_ID16-217*RUN_QGF_2_7;
        end
        endcase
        end        
        6'd7:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12500+DJ_ID2-200*RUN_QGF_2_8;
        RUN_Q12 <= 14500+DJ_ID3+75*RUN_QGF_2_8;
        RUN_Q13 <= 5500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 14500+DJ_ID6;
        RUN_Q16 <= 5000+DJ_ID7;
        RUN_Q17 <= 15000+DJ_ID8-100*RUN_QGF_2_8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 17500+DJ_ID10+200*RUN_QGF_2_8;
        RUN_Q110 <= 15500+DJ_ID11-75*RUN_QGF_2_8;
        RUN_Q111 <= 24500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15500+DJ_ID14;
        RUN_Q114 <= 25000+DJ_ID15;
        RUN_Q115 <= 15000+DJ_ID16+100*RUN_QGF_2_8;
        end
        6'd8:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 8500+DJ_ID2+25*RUN_QGF_2_9;
        RUN_Q12 <= 16000+DJ_ID3-75*RUN_QGF_2_9;
        RUN_Q13 <= 5500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 14500+DJ_ID6;
        RUN_Q16 <= 5000+DJ_ID7+900*RUN_QGF_2_9;
        RUN_Q17 <= 13000+DJ_ID8+100*RUN_QGF_2_9;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 21500+DJ_ID10-25*RUN_QGF_2_9;
        RUN_Q110 <= 14000+DJ_ID11+75*RUN_QGF_2_9;
        RUN_Q111 <= 24500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15500+DJ_ID14;
        RUN_Q114 <= 25000+DJ_ID15-900*RUN_QGF_2_9;
        RUN_Q115 <= 17000+DJ_ID16-100*RUN_QGF_2_9;
        end
         6'd9:begin
        case(RUN_QGF_2_10)
         6'd45:begin         
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 12200+DJ_ID2;
        RUN_Q12 <= 14800+DJ_ID3;
        RUN_Q13 <= 17500+DJ_ID4;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 17000+DJ_ID6;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 19000+DJ_ID8;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 17800+DJ_ID10;
        RUN_Q110 <= 15200+DJ_ID11;
        RUN_Q111 <= 12500+DJ_ID12;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 13000+DJ_ID14;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 11000+DJ_ID16;
        end
        default:begin
        RUN_Q10 <= 15000+DJ_ID1;
        RUN_Q11 <= 9000+DJ_ID2+71*RUN_QGF_2_10;
        RUN_Q12 <= 14500+DJ_ID3+7*RUN_QGF_2_10;
        RUN_Q13 <= 5500+DJ_ID4+267*RUN_QGF_2_10;
        RUN_Q14 <= 15000+DJ_ID5;
        RUN_Q15 <= 14500+DJ_ID6+56*RUN_QGF_2_10;
        RUN_Q16 <= 23000+DJ_ID7;
        RUN_Q17 <= 15000+DJ_ID8+89*RUN_QGF_2_10;
        RUN_Q18 <= 15000+DJ_ID9;
        RUN_Q19 <= 21000+DJ_ID10-71*RUN_QGF_2_10;
        RUN_Q110 <= 15500+DJ_ID11-7*RUN_QGF_2_10;
        RUN_Q111 <= 24500+DJ_ID12-267*RUN_QGF_2_10;
        RUN_Q112 <= 15000+DJ_ID13;
        RUN_Q113 <= 15500+DJ_ID14-56*RUN_QGF_2_10;
        RUN_Q114 <= 7000+DJ_ID15;
        RUN_Q115 <= 15000+DJ_ID16-89*RUN_QGF_2_10;
        end
        endcase
        end        
       6'd10:begin      //standing up automatically
       case(RUN_L_2_1)
       6'd60:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12000+DJ_ID2;
            RUN_Q12 <= 15000+DJ_ID3;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 18000+DJ_ID10;
            RUN_Q110 <= 15000+DJ_ID11;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        default:begin
            RUN_Q10 <= 15000+DJ_ID1;
            RUN_Q11 <= 12200+DJ_ID2-3*RUN_L_2_1;
            RUN_Q12 <= 14800+DJ_ID3+3*RUN_L_2_1;
            RUN_Q13 <= 17500+DJ_ID4;
            RUN_Q14 <= 15000+DJ_ID5;
            RUN_Q15 <= 17000+DJ_ID6;
            RUN_Q16 <= 23000+DJ_ID7;
            RUN_Q17 <= 19000+DJ_ID8;
            RUN_Q18 <= 15000+DJ_ID9;
            RUN_Q19 <= 17800+DJ_ID10+3*RUN_L_2_1;
            RUN_Q110 <= 15200+DJ_ID11-3*RUN_L_2_1;
            RUN_Q111 <= 12500+DJ_ID12;
            RUN_Q112 <= 15000+DJ_ID13;
            RUN_Q113 <= 13000+DJ_ID14;
            RUN_Q114 <= 7000+DJ_ID15;
            RUN_Q115 <= 11000+DJ_ID16;
            end
        endcase
     end          
   endcase
   end  
         
   default:begin
        RUN_Q10 <= RUN_Q10;
        RUN_Q11 <= RUN_Q11;
        RUN_Q12 <= RUN_Q12;
        RUN_Q13 <= RUN_Q13;
        RUN_Q14 <= RUN_Q14;
        RUN_Q15 <= RUN_Q15;
        RUN_Q16 <= RUN_Q16;//2317;//2300;
        RUN_Q17 <= RUN_Q17;//1900;
        RUN_Q18 <= RUN_Q18;//1500;
        RUN_Q19 <= RUN_Q19;//1800;
        RUN_Q110 <= RUN_Q110;//1500;    
        RUN_Q111 <= RUN_Q111;//1250;
        RUN_Q112 <= RUN_Q112;//1500;
        RUN_Q113 <= RUN_Q113;//1300;
        RUN_Q114 <= RUN_Q114;//700;
        RUN_Q115 <= RUN_Q115;//1100;  
    end         
    endcase     
end
    
control control1(           //Generates a subfunction of the steering gear control
            .CLK(CLK_10M),
            .RUN_PARM0(RUN_Q10),
            .RUN_PARM1(RUN_Q11),
            .RUN_PARM2(RUN_Q12),
            .RUN_PARM3(RUN_Q13),
            .RUN_PARM4(RUN_Q14),
            .RUN_PARM5(RUN_Q15),
            .RUN_PARM6(RUN_Q16),
            .RUN_PARM7(RUN_Q17),
            .RUN_PARM8(RUN_Q18),
            .RUN_PARM9(RUN_Q19),
            .RUN_PARM10(RUN_Q110),
            .RUN_PARM11(RUN_Q111),
            .RUN_PARM12(RUN_Q112),
            .RUN_PARM13(RUN_Q113),
            .RUN_PARM14(RUN_Q114),
            .RUN_PARM15(RUN_Q115),           
            .RUN_CONTL(CTRL_OUT_TMP)  
            );

assign CMOD_ATR[16:1] = CTRL_OUT_TMP[15:0];
/*****************Action assignment*****************/

/*****************The temporary test*****************/
//assign CMOD_ATR[14:1] = CTRL_OUT_TMP[15:0];
//assign CMOD_ATR[16] = CLK_1K_tmp1;
//assign CMOD_ATR[15] = RUN_Q_1;
/*****************The temporary test*****************/

/*****************Discrete control*****************/
assign A_DIR[1] = 1;
assign A_DIR[2] = 1;
assign B_DIR[1] = 1;
assign B_DIR[2] = 1;

always @(posedge CLK_10M)
begin
    if(SW1_TMP==1)
        SW2_cont <= 0;
    else
    begin    
        if(SW2_TMP==1)
            SW2_cont <= SW2_cont + 1;
        else
            SW2_cont <= SW2_cont;
    end           
end
    
assign LED[0] = !(Count_CTRL==0);
assign LED[1] = SW2_cont;
/*****************Discrete control*****************/
/***********End***************/                                                                                                                        
endmodule
