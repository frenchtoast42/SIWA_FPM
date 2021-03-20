`timescale 1ns / 1ps

module test_top();
  
  reg [31:0]fp_X, fp_Y, fp_Z, afp_Z;
  reg ovrf, udrf;
  
  reg clk, check;
  
  shortreal short_x, short_y, short_z, actual_z;

  //r = $bitstoshortreal({sign, exp, mantissa});
  //{sign, exp, mantissa} = $shortrealtobits(r);
  
  top top(.clk(clk), .r_mode(3'b100), .fp_X(fp_X), .fp_Y(fp_Y), .fp_Z(fp_Z), .ovrf(ovrf), .udrf(udrf));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, test_top);
    clk = 1'b0;
  
    fp_X = 32'h0a0a0a0a;
    fp_Y = 32'h0a0a0a0a;
    
    //fp_X = 32'b0_00000111_10000000000000000000000; //generates a tie
    //fp_Y = 32'b0_10111111_00000000000000000000001;
    
    //fp_X = 32'b0_11111111_00000000000000000000000; //one input inf
    //fp_Y = 32'b0_10101010_10101010101010101010101;
    
    //fp_X = 32'b0_00000000_00000000000000000000000; //one input zero
    //fp_Y = 32'b0_10101010_10101010101010101010101;
    
    //fp_X = 32'b0_11111111_10000000000000000000000; //one input nan
    //fp_Y = 32'b0_10101010_10101010101010101010101;
    
    //fp_X = 32'b0_00000000_00000000000000000000000; //zero times inf
    //fp_Y = 32'b0_11111111_00000000000000000000000;
    
    repeat(100) begin
      #1;
      
      short_x = $bitstoshortreal(fp_X);
      short_y = $bitstoshortreal(fp_Y);
      
      actual_z = short_x * short_y;
      afp_Z = $shortrealtobits(actual_z);
      
      short_z = $bitstoshortreal(fp_Z);
      
      check = {fp_Z == afp_Z};
      #49;
      
      
      
      $display(" fp_X = %h | %b %b (%d) %b | %.17e\n fp_Y = %h | %b %b (%d) %b | %.17e\n fp_Z = %h | %b %b (%d) %b | %.17e\nafp_Z = %h | %b %b (%d) %b | %.17e        check: %b",
               fp_X, fp_X[31], fp_X[30:23], fp_X[30:23], fp_X[22:0], short_x,
               fp_Y, fp_Y[31], fp_Y[30:23], fp_Y[30:23], fp_Y[22:0], short_y,
               fp_Z, fp_Z[31], fp_Z[30:23], fp_Z[30:23], fp_Z[22:0], short_z,
               afp_Z, afp_Z[31], afp_Z[30:23], afp_Z[30:23], afp_Z[22:0], actual_z,
               check);
      
      
      $display(" UNDERFLOW: %b      OVERFLOW: %b\n=======================================================================================",
               udrf, ovrf);
      
      fp_X = $random($random());
      fp_Y = $random($random());
      
      
    end
    $finish;
  end
  
  always #25 clk=!clk;
  
endmodule
