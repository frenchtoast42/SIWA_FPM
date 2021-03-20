module CPA(
  input [47:0]red6_0,
  input [46:0]red6_1,
  
  output [47:0]Z);
  
  assign Z[0] = red6_0[0];
  
  assign Z[47:1] = red6_0[47:1] + red6_1;
  
endmodule
