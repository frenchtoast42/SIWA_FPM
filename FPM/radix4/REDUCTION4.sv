module REDUCTION4(
  input [46:0]red3_0,
  input [45:0]red3_1,
  input [41:0]red3_2,
  input [37:0]red3_3,
  input [34:0]red3_4,
  input [31:0]red3_5,
  
  input [2:0]g3,
  
  output [46:0]red4_0,
  output [45:0]red4_1,
  output [42:0]red4_2,
  output [39:0]red4_3,
  
  output g4);
  
  
  assign {red4_1[44], red4_0[44]} = {red3_0[44], !red3_0[44]};
  
  half half4_0(
    .A(red3_0[7]),
    .B(red3_1[6]),
    .S(red4_0[7]),
    .Cout(red4_1[7]));
  
  full full4_0[35:0](
    .A({!g3[1], red3_0[42:8]}),
    .Cin(red3_1[42:7]),
    .B(red3_2[40:5]),
    .S(red4_0[43:8]),
    .Cout(red4_1[43:8]));
  
  
  assign {red4_3[38], red4_2[39]} = {red3_3[37], !red3_3[37]};
  
  half half4_1(
    .A(red3_3[4]),
    .B(red3_4[2]),
    .S(red4_2[6]),
    .Cout(red4_3[5]));
  
  full full4_1[31:0](
    .Cin(red3_3[36:5]),
    .B(red3_4[34:3]),
    .A({!g3[0], red3_5[31:1]}),
    .S(red4_2[38:7]),
    .Cout(red4_3[37:6]));
  
  
  assign red4_0[46:45] = red3_0[46:45];
  assign red4_0[6:0] = red3_0[6:0];
  
  assign red4_1[45] = red3_1[45];
  assign red4_1[6:0] = {red3_2[4], red3_1[5:0]};
  
  assign red4_2[42:40] = {red3_1[44:43], red3_0[43]};
  assign red4_2[5:0] = {red3_3[3:2], red3_2[3:0]};
  
  assign red4_3[39] = red3_2[41];
  assign red4_3[4:0] = {red3_5[0], red3_4[1:0], red3_3[1:0]};
  
  assign g4 = g3[2];
  
endmodule
