module sorting_tb;

  // Inputs
  reg clk;
  reg reset;
  reg sortType;
  reg [7:0] data_in;
  reg load_enable;


  // Outputs
  wire [7:0] data_out;

  // Instantiate the sorting module
  sorting uut (
    .clk(clk),
    .reset(reset),
    .sortType(sortType),
    .data_in(data_in),
    .load_enable(load_enable),
    .data_out(data_out)
  );

  // Clock generation
  always #10 clk = ~clk;  // Generate a 10ns clock period

  // Initialize inputs
  initial begin
    clk = 0;
    reset = 1;
    sortType = 0;
    data_in = 8'd0;
    load_enable = 0;
    #20 reset = 0;  // Release reset after 10ns
  end

  // Stimulus
  initial begin
    load_enable = 1;
    #20;
    data_in = 121; //121
    #20;
    data_in = 37; //37
    #20;
    data_in = 11;//11
    #20;
    data_in = 45;
    #20;
    data_in = 246;
    #20;
    data_in = 83;
    #20;
    data_in = 180;
    #20;
    data_in = 233;
    #20;
    data_in = 96;
    #20;
    data_in = 242;
    #20;
    data_in = 104;
    #20;
    data_in = 63;
    #20;
    data_in = 3;
    #20;
    data_in = 157;
    #20;
    data_in = 28;
    #20;

    load_enable = 0;


    // End simulation
    #800 $finish;
  end


endmodule
