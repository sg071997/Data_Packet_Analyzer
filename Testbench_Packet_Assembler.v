`timescale 1ns/1ps
module tb_packet_assembler();
reg clock;
reg resetn;
reg validIn;
reg [31:0] dataIn;
reg lastIn;
wire validOut;
wire [31:0] dataOut;
wire lastOut;

// Instantiate the packet assembler module
packet_assembler uut (
.clock(clock),
.resetn(resetn),
.validIn(validIn),
.dataIn(dataIn),
.lastIn(lastIn),
.validOut(validOut),
.dataOut(dataOut),
.lastOut(lastOut)
);
 
// Clock generation
always begin
#5 clock = ~clock; // 10ns clock period
end

// Test sequence
initial begin

// Initialize signals
$dumpfile("packet_assembler.vcd"); // Specify the VCD file name
$dumpvars(0, tb_packet_assembler); // Dump all variables in this module
clock = 0;
resetn = 0;
validIn = 0;
dataIn = 32'h00000000;
lastIn = 0;

// Release reset
#5 resetn = 1;
 
// Send a packet with a payload of length 3
//send 3 packet for example 0000000A, 0000000B, 0000000C
#10 validIn = 1;
dataIn = 32'h0000000A; 
#10 dataIn = 32'h0000000B; 
#10 dataIn = 32'h0000000C;
lastIn = 1;
#10 lastIn = 0;
validIn = 0;
// Wait some time
#100;
 
// Send another packet with a payload of length 5
//send 5 packet 000000FA, 000000FB, 00000000FC, 00000000FD, 000000FD, 000000FE
validIn = 1;
dataIn = 32'h000000FA;
#10 dataIn = 32'h000000FB;
#10 dataIn = 32'h000000FC;
#10 dataIn = 32'h000000FD;
#10 dataIn = 32'h000000FE;
lastIn = 1;
#10 lastIn = 0;
validIn = 0;
// Wait some time
#100; 

// Wait some time
#100;
 
// End simulation
#100 $finish;

end
endmodule

 
