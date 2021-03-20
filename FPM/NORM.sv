module NORM(
  input [47:0]Z_in,
  output [26:0]Z_out,
  output norm_n);
  
  wire [47:0]Z_shift;
  
  assign Z_shift = Z_in << !Z_in[47];
  
  assign Z_out[26:1] = Z_shift[47:22];
  assign Z_out[0] = |Z_shift[21:0]; //sticky
  
  assign norm_n = Z_in[47];
  
endmodule
