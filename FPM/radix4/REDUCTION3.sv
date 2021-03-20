module REDUCTION3(
  input [46:0]red2_0,
  input [45:0]red2_1,
  input [41:0]red2_2,
  input [37:0]red2_3,
  input [33:0]red2_4,
  input [29:0]red2_5,
  input [25:0]red2_6,
  input [22:0]red2_7,
  input [19:0]red2_8,
  
  output [46:0]red3_0,
  output [45:0]red3_1,
  output [41:0]red3_2,
  output [37:0]red3_3,
  output [34:0]red3_4,
  output [31:0]red3_5,
  
  output [2:0]g3);
  
  assign {red3_1[40], red3_0[40]} = {red2_0[40], !red2_0[40]};
  
  half half3_0(
    .A(red2_0[11]),
    .B(red2_1[10]),
    .S(red3_0[11]),
    .Cout(red3_1[11]));
  
  full full3_0[27:0](
    .A({!red2_7[1], red2_0[38], !red2_6[1], red2_0[36:12]}),
    .Cin(red2_1[38:11]),
    .B(red2_2[36:9]),
    .S(red3_0[39:12]),
    .Cout(red3_1[39:12]));
  
  
  assign {red3_3[34], red3_2[35]} = {red2_3[33], !red2_3[33]};
  
  half half3_1(
    .A(red2_3[8]),
    .B(red2_4[6]),
    .S(red3_2[10]),
    .Cout(red3_3[9]));
  
  full full3_1[23:0](
    .Cin(red2_3[32:9]),
    .B(red2_4[30:7]),
    .A(red2_5[28:5]),
    .S(red3_2[34:11]),
    .Cout(red3_3[33:10]));
  
  
  assign {red3_5[28], red3_4[29]} = {red2_6[25], !red2_6[25]};
  
  half half3_2(
    .A(red2_6[4]),
    .B(red2_7[2]),
    .S(red3_4[8]),
    .Cout(red3_5[7]));
  
  full full3_2[19:0](
    .A(red2_6[24:5]),
    .Cin(red2_7[22:3]),
    .B({!red2_5[1], red2_8[19:1]}),
    .S(red3_4[28:9]),
    .Cout(red3_5[27:8]));
  
  
  assign red3_0[46:41] = red2_0[46:41];
  assign red3_0[10:0] = red2_0[10:0];
  
  assign red3_1[45:41] = red2_1[45:41];
  assign red3_1[10:0] = {red2_2[8], red2_1[9:0]};
  
  assign red3_2[41:36] = {
    red2_2[41:39],
    red2_1[40:39],
    red2_0[39]};
  assign red3_2[9:0] = {
    red2_3[7:6],
    red2_2[7:0]};
  
  assign red3_3[37:35] = {
    red2_3[37],
    red2_2[38:37]};
  assign red3_3[8:0] = {
    red2_5[4],
    red2_4[5:4],
    red2_3[5:0]};
  
  assign red3_4[34:30] = {
    red2_3[36:34],
    red2_4[31],
    red2_0[37]};
  assign red3_4[7:0] = {
    red2_6[3:2],
    red2_5[3:2],
    red2_4[3:0]};
  
  assign red3_5[31:29] = {
    red2_4[33:32],
    red2_5[29]};
  assign red3_5[6:0] = {
    red2_8[0],
    red2_7[1:0],
    red2_6[1:0],
    red2_5[1:0]};
  
  assign g3[2:0] = {red2_8[5], red2_8[3], red2_8[1]};
  
endmodule
