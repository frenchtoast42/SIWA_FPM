module REDUCTION3(
  input [46:0]red2_0,
  input [44:0]red2_1,
  input [38:0]red2_2,
  input [32:0]red2_3,
  input [27:0]red2_4,
  input [23:0]red2_5,
  
  output [46:0]red3_0,
  output [44:0]red3_1,
  output [40:0]red3_2,
  output [35:0]red3_3);
  
  assign {red3_1[42], red3_0[43]} = {red2_0[43], !red2_0[43]};
  assign {red3_1[41], red3_0[42]} = {red2_0[42], !red2_0[42]};
  
  half half3_0[1:0](
    .A({!red2_5[4], red2_0[11]}),
    .B({red2_0[44], red2_1[9]}),
    .S({red3_0[44], red3_0[11]}),
    .Cout({red3_1[43], red3_1[10]}));
  
  full full3_0[29:0](
    .A(red2_0[41:12]),
    .C(red2_1[39:10]),
    .B({!red2_5[1], red2_2[35:7]}),
    .S(red3_0[41:12]),
    .Cout(red3_1[40:11]));
  
  
  assign {red3_3[33], red3_2[35]} = {red2_3[32], !red2_3[32]};
  assign {red3_3[32], red3_2[34]} = {red2_3[31], !red2_3[31]};
  
  half half3_1(
    .A(red2_3[6]),
    .B(red2_4[3]),
    .S(red3_2[9]),
    .Cout(red3_3[7]));
  
  full full3_1[23:0](
    .C(red2_3[30:7]),
    .B(red2_4[27:4]),
    .A({!red2_4[1], red2_5[23:1]}),
    .S(red3_2[33:10]),
    .Cout(red3_3[31:8]));
  
  
  assign red3_0[46:45] = red2_0[46:45];
  assign red3_0[10:0] = red2_0[10:0];
  
  assign red3_1[44] = red2_1[44];
  assign red3_1[9:0] = {red2_2[6], red2_1[8:0]};
  
  assign red3_2[40:36] = {red2_1[43:40], red2_2[36]};
  assign red3_2[8:0] = {red2_3[5:3], red2_2[5:0]};
  
  assign red3_3[35:34] = red2_2[38:37];
  assign red3_3[6:0] = {red2_5[0], red2_4[2:0], red2_3[2:0]};
  
endmodule
