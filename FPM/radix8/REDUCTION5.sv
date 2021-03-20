module REDUCTION5(
  input [47:0]red4_0,
  input [44:0]red4_1,
  input [41:0]red4_2,
  
  output [47:0]red5_0,
  output [45:0]red5_1);
  
  assign red5_0[47] = !red4_0[47];
  
  half half5_0(
    .A(red4_0[5]),
    .B(red4_1[3]),
    .S(red5_0[5]),
    .Cout(red5_1[4]));
  
  full full5_0[40:0](
    .A(red4_0[46:6]),
    .C(red4_1[44:4]),
    .B(red4_2[41:1]),
    .S(red5_0[46:6]),
    .Cout(red5_1[45:5]));
  
  assign red5_0[4:0] = red4_0[4:0];
  
  assign red5_1[3:0] = {red4_2[0], red4_1[2:0]};
  
endmodule
