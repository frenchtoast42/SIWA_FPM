`timescale 1ns / 1ps

module test_top();
  
  reg [22:0]X, Y;
  
  reg [47:0]Z, aZ;
  
  reg clk, check;
  
  top top(.clk(clk), .frc_X(X), .frc_Y(Y), .frc_Z_full(Z));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, test_top);
    clk = 1'b0;
  
    X = 23'b01100100101100111011010;
    Y = 23'b11101110111000000111100;
    aZ = {1'b1, X} * {1'b1, Y};
    
    
    repeat(10000) begin
      #50;
      
      check = {Z == aZ};
      
      $display("       res = %b | %d \nactual res = %b | %d, check = %b",
               Z, Z,
               aZ, aZ,
               check);
      
      X = $random($random());
      Y = $random($random());
      aZ = {1'b1, X} * {1'b1, Y};
      
    end
    $finish;
  end
  
  always #25 clk=!clk;
  
endmodule
