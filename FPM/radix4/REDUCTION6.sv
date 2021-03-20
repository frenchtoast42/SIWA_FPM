module REDUCTION6(
  input [47:0]red5_0,
  input [45:0]red5_1,
  input [43:0]red5_2,
  
  output [47:0]red6_0,
  output [46:0]red6_1);
  
  assign red6_0[47] = !red5_0[47];
  
  half half6_0(
    .A(red5_0[3]),
    .B(red5_1[2]),
    .S(red6_0[3]),
    .Cout(red6_1[3]));
  
  full full6_1[42:0](
    .A(red5_0[46:4]),
    .Cin(red5_1[45:3]),
    .B(red5_2[43:1]),
    .S(red6_0[46:4]),
    .Cout(red6_1[46:4]));
  
  assign red6_0[2:0] = red5_0[2:0];
  
  assign red6_1[2:0] = {red5_2[0], red5_1[1:0]};
  
endmodule
