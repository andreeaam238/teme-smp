`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/29/2022 08:56:43 PM
// Design Name: 
// Module Name: tsi107
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


module tsi107(AACK, ARTRY, A, BG0, BR0, CLK, CS, DBG0, DH, DL, DP, SDCAS, SDMA, SDRAS, TA, TEA, TBST, TS, TSIZ, TT, WE, WT, CI, GBL);
inout   [0:7]DP;
input   CI;
input   GBL;
output  TEA;

wire    [0:7]DP;
wire    CI;
wire    GBL;
wire    TEA;

input   BR0;
input   CLK;
input   [0:31]DL;
input   TBST;
input   TS;
input   [0:2]TSIZ;
input   WT;
output  AACK;
output  ARTRY;
output  BG0;
output  [0:7]CS;
output  DBG0;
output  [0:31]DH;
output  SDCAS;
output  [0:11]SDMA;
output  SDRAS;
output  TA;
output  WE;
input   [0:31]A;
inout   [0:4]TT;

reg     AACK;
reg     ARTRY;
tri     [0:31]A;
reg     [0:31]ino_A;
reg     BG0;
wire    BR0;
wire    CLK;
reg     [0:7]CS;
reg     DBG0;
reg     [0:31]DH;
wire    [0:31]DL;
reg     SDCAS;
reg     [0:11]SDMA;
reg     SDRAS;
reg     TA;
wire    TBST;
wire    TS;
wire    [0:2]TSIZ;
tri     [0:4]TT;
reg     [0:4]ino_TT;
reg     WE;
wire    WT;

// BINARY ENCODED state machine: Sreg0
// State codes definitions:
`define Arb 4'b0000
`define Arbi 4'b0001
`define Arbit 4'b0010
`define Arbitrare 4'b0011
`define Asteapta_date 4'b0100
`define Astpt_dat 4'b0101
`define Scr_dat 4'b0110
`define Scr_mem 4'b0111
`define Scriere_date 4'b1000
`define Scriu_mem 4'b1001

reg [3:0]CurrState_Sreg0, NextState_Sreg0;

// Diagram actions (continuous assignments allowed only: assign ...)
// diagram ACTIONS
//--------------------------------------------------------------------
// Machine: Sreg0
//--------------------------------------------------------------------
// machine variables declarations
reg  [0:2]Siz, next_Siz;
integer X;
reg  [0:31]adr, next_adr;
reg  [0:7]chip, next_chip;
reg  [0:31]date, next_date;
//----------------------------------
// NextState logic (combinatorial)
//----------------------------------

always @ (TT or A or DL or BR0 or adr or chip or CurrState_Sreg0)
begin: Sreg0_NextState
	NextState_Sreg0 <= CurrState_Sreg0;
	// Set default values for outputs and signals
	next_adr = adr;
	next_chip = chip;
	case (CurrState_Sreg0)	// synopsys parallel_case full_case
		`Arb:
		begin
			AACK <= 1;
			ARTRY <= 1;
			TA <= 1;
			CS <= "11111111";
			SDRAS <= 1;
			SDCAS <= 0;
			WE <= 1;
			BG0 <= 1;
			DBG0 <= "Z";
			ino_TT <= TT;
			if (BR0 == 0)
				NextState_Sreg0 <= `Arbi;
			else if (BR0 != 0)
				NextState_Sreg0 <= `Arb;
		end
		`Arbi:
		begin
			BG0 <= 0;
			DBG0 <= "Z";
			if (BR0 == 1)
				NextState_Sreg0 <= `Arbi;
			else if (BR0 != 1)
				NextState_Sreg0 <= `Astpt_dat;
		end
		`Arbit:
		begin
			BG0 <= 0;
			DBG0 <= "Z";
			if (BR0 != 1)
				NextState_Sreg0 <= `Arbit;
			else if (BR0 == 1)
				NextState_Sreg0 <= `Asteapta_date;
		end
		`Arbitrare:
		begin
			AACK <= 1;
			ARTRY <= 1;
			TA <= 1;
			CS <= "11111111";
			WE <= 1;
			BG0 <= 1;
			DBG0 <= "Z";
			ino_TT <= TT;
			ino_A <= A;
			SDRAS <= 1;
			SDCAS <= 1;
			if (BR0 == 0)
				NextState_Sreg0 <= `Arbit;
			else if (BR0 != 0)
				NextState_Sreg0 <= `Arbitrare;
		end
		`Asteapta_date:
		begin
			BG0 <= "Z";
			DBG0 <= 0;
			DH <= DL;
			adr = A;
			SDMA[0] <= A[9];
			SDMA[1] <= A[10];
			SDMA[2] <= A[11];
			SDMA[3] <= A[12];
			SDMA[4] <= A[13];
			SDMA[5] <= A[14];
			SDMA[6] <= A[15];
			SDMA[7] <= A[16];
			SDMA[8] <= A[17];
			SDMA[9] <= A[18];
			SDMA[10] <= A[19];
			SDMA[11] <= A[20];
			ARTRY <= 1;
			NextState_Sreg0 <= `Scriere_date;
		end
		`Astpt_dat:
		begin
			BG0 <= "Z";
			DBG0 <= 0;
			DH <= DL;
			adr = A;
			SDMA[0] <= A[6];
			SDMA[1] <= A[9];
			SDMA[2] <= A[7];
			SDMA[3] <= A[8];
			SDMA[4] <= A[21];
			SDMA[5] <= A[22];
			SDMA[6] <= A[23];
			SDMA[7] <= A[24];
			SDMA[8] <= A[25];
			SDMA[9] <= A[26];
			SDMA[10] <= A[27];
			SDMA[11] <= A[28];
			//SDMA[0:2] <= A[7:9];
            //SDMA[3:11] <=A[21:28];
            ARTRY <= 1;
			NextState_Sreg0 <= `Scr_dat;
		end
		`Scr_dat:
		begin
			BG0 <= "Z";
			DBG0 <= "Z";
			AACK <= 0;
			SDRAS <= 1;
			chip = "11111110";
			CS <= "11111110";
			SDCAS <= 0;
			NextState_Sreg0 <= `Scr_mem;
		end

        `Scr_mem:
		begin
			TA <= 0;
			AACK <= 1;
			SDRAS <= 1;
			//DL <= "10101011000000000000000000000000";
            BG0 <= "Z";
			SDCAS <= 1;
			WE <= 0;
			TA <= 1;
			NextState_Sreg0 <= `Arbitrare;
		end

		`Scriere_date:
		begin
			BG0 <= "Z";
			DBG0 <= "Z";
			AACK <= 0;
			SDRAS <= 0;
			chip = "11111110";
			CS <= "11111110";
			SDCAS <= 1;
			NextState_Sreg0 <= `Scriu_mem;
		end

        `Scriu_mem:
		begin
			TA <= 0;
			AACK <= 1;
			SDRAS <= 1;
			//DL <= "10101011000000000000000000000000";
            BG0 <= "Z";
			SDRAS <= 1;
			SDCAS <= 1;
			WE <= 0;
			TA <= 1;
			NextState_Sreg0 <= `Arb;
		end
	endcase
end

//----------------------------------
// Current State Logic (sequential)
//----------------------------------
always @ (posedge CLK)
begin: Sreg0_CurrentState
	CurrState_Sreg0 <= NextState_Sreg0;
end

initial CurrState_Sreg0 = `Arb;

//----------------------------------
// Registered outputs logic
//----------------------------------
always @ (posedge CLK)
begin: Sreg0_RegOutput
	adr <= next_adr;
	chip <= next_chip;
end

// Copy temporary registers to target inout ports
assign TT = ino_TT;
//assign A = ino_A;

endmodule