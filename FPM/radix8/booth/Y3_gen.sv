module Y3_gen(
  input [22:0]Y,
  output [23:0]Y3);
  
  assign Y3 = {1'b1, Y[22:1]} + Y;
  
endmodule
