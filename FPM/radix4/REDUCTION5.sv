module REDUCTION5(
  input [46:0]red4_0,
  input [45:0]red4_1,
  input [42:0]red4_2,
  input [39:0]red4_3,
  
  input g4,
  
  output [47:0]red5_0,
  output [45:0]red5_1,
  output [43:0]red5_2);
  
  
  assign {red5_0[47:46]} = {red4_1[45], !red4_1[45]};
  
  half half5_0(
    .A(red4_1[4]),
    .B(red4_2[2]),
    .S(red5_0[5]),
    .Cout(red5_1[5]));
  
  full full5_0[39:0](
    .Cin(red4_1[44:5]),
    .B(red4_2[42:3]),
    .A({!g4, red4_3[39:1]}),
    .S(red5_0[45:6]),
    .Cout(red5_1[45:6]));
  
  
  assign red5_0[4:0] = red4_0[4:0];
  
  assign red5_1[4:0] = {red4_0[5], red4_1[3:0]};
  
  assign red5_2[43:0] = {
    red4_0[46:6],
    red4_3[0],
    red4_2[1:0]};
  
endmodule
