module CPA(
  input [47:0]red5_0,
  input [45:0]red5_1,
  
  output [47:0]Z);
  
  assign Z[1:0] = red5_0[1:0];
  
  assign Z[47:2] = red5_0[47:2] + red5_1;
  
endmodule
