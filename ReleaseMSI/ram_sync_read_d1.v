module ram_sync_read_d1#(parameter AWIDTH = 3,		// Address Width Parameter, also used to calculate depth
parameter DWIDTH = 32,		// Data width parameter
localparam DEPTH  = 1 << AWIDTH)(
				input 	clock,			//Input signal for clock
				input 	[AWIDTH-1:0] addr,	//Parameterized Address bus input
				input 	[DWIDTH-1:0] din,	//Parameterized Data bus input
				input 	we,			//Write Enable (input HIGH = write, LOW = read)
				output  	[DWIDTH-1:0] dout	//Parameterized Data bus output
				);

// Configuration Parameters



reg [DWIDTH-1:0] mem_array_d1 [0:DEPTH-1];

// Memory initialization
initial
begin
	$readmemb("/home/debleena/Thales/ReleaseMSI/dram1.txt", mem_array_d1);
end

// Internal Register to latch address for synchronous read operation
reg [AWIDTH-1:0] rd_addr;

// Sequential Block to write data in memory as well as latch read address
// depending on 'we' write enable signal
always@(posedge clock)
begin
	if(we)
		mem_array_d1[addr] <= din;	

rd_addr <= addr;		
end

// Data out during read operation with latched address to keep output stable
assign dout = mem_array_d1[rd_addr];

endmodule
