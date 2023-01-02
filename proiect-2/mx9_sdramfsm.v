
// File        : C:\MicroSys\Lab3_SM\PowerPCInterf\lab3M\compile\2mx9_sdramfsm.v
// Generated   : 03/16/05 14:06:55
// From        : C:\MicroSys\Lab3_SM\PowerPCInterf\lab3M\src\2mx9_sdramfsm.asf
// By          : FSM2VHDL ver. 3.0.4.1

`timescale 1ns / 1ps

module mx9_sdramfsm (A, CAS, CLK, CS, DQ, RAS, WE);
input   CAS;
input   CLK;
input   CS;
input   RAS;
input   WE;
input   [0:11]A;
input   [0:7]DQ;

tri     [0:11]A;
reg     [0:11]ino_A;
wire    CAS;
wire    CLK;
wire    CS;
tri     [0:7]DQ;
reg     [0:7]ino_DQ;
wire    RAS;
wire    WE;

// BINARY ENCODED state machine: Sreg0
// State codes definitions:
`define S1 3'b000
`define S2 3'b001
`define S3 3'b010
`define S4 3'b011
`define S5 3'b100
`define S6 3'b101

reg [2:0]CurrState_Sreg0, NextState_Sreg0;

// Diagram actions (continuous assignments allowed only: assign ...)
//diagram ACTIONS


//--------------------------------------------------------------------
// Machine: Sreg0
//--------------------------------------------------------------------
// machine variables declarations
reg  [0:7]Memorie, next_Memorie;
//----------------------------------
// NextState logic (combinatorial)
//----------------------------------
always @ (DQ or CS or RAS or CAS or WE or Memorie or CurrState_Sreg0)
begin : Sreg0_NextState
	NextState_Sreg0 <= CurrState_Sreg0;
	// Set default values for outputs and signals
	next_Memorie = Memorie;
	case (CurrState_Sreg0)	// synopsys parallel_case full_case
		`S1:
			if (CS!=1)
				NextState_Sreg0 <= `S1;
			else if (CS==1)
				NextState_Sreg0 <= `S2;
		`S2:
			if (RAS!=1 || CAS!=1)
				NextState_Sreg0 <= `S1;
			else if (RAS==1 && CAS==1)
				NextState_Sreg0 <= `S3;
		`S3:
		begin
			Memorie <= DQ;
			if (WE!=1)
				NextState_Sreg0 <= `S6;
			else if (WE==1)
				NextState_Sreg0 <= `S4;
		end
		`S4:
			NextState_Sreg0 <= `S5;
		`S5:
			NextState_Sreg0 <= `S1;
		`S6:
			NextState_Sreg0 <= `S5;
	endcase
end

//----------------------------------
// Current State Logic (sequential)
//----------------------------------
always @ (posedge CLK)
begin : Sreg0_CurrentState
	CurrState_Sreg0 <= NextState_Sreg0;
end

initial CurrState_Sreg0 <= `S1;
//----------------------------------
// Registered outputs logic
//----------------------------------
always @ (posedge CLK)
begin : Sreg0_RegOutput
	Memorie <= next_Memorie;
end

endmodule