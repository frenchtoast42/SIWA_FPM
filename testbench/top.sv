module top(
  input clk,
  input [2:0]r_mode,
  input [31:0]fp_X, fp_Y,
  output [31:0]fp_Z,
  output ovrf, udrf);
  
  FPM FPM(.r_mode(r_mode),
          .fp_X(fp_X),
          .fp_Y(fp_Y),
          
          .fp_Z(fp_Z),
          .ovrf(ovrf),
          .udrf(udrf));
  
endmodule
