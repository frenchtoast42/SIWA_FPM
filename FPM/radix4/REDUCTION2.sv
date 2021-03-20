module REDUCTION2(
  input [47:0]red1_0,
  input [44:0]red1_1,
  input [41:0]red1_2,
  input [37:0]red1_3,
  input [33:0]red1_4,
  input [29:0]red1_5,
  input [25:0]red1_6,
  input [21:0]red1_7,
  input [17:0]red1_8,
  input [13:0]red1_9,
  input [9:0]red1_10,
  input [5:0]red1_11,
  input [1:0]red1_12,
  
  output [46:0]red2_0,
  output [45:0]red2_1,
  output [41:0]red2_2,
  output [37:0]red2_3,
  output [33:0]red2_4,
  output [29:0]red2_5,
  output [25:0]red2_6,
  output [22:0]red2_7,
  output [19:0]red2_8);
  
  
  assign {red2_1[34], red2_0[34]} = {red1_1[32], !red1_1[32]};
  
  half half2_0[1:0](
    .A({red1_1[15], red1_0[1]}),
    .B({red1_2[14], red1_0[0]}),
    .S({red2_0[17], red2_0[0]}),
    .Cout({red2_1[17], red2_0[1]}));
  
  full full2_0[15:0](
    .A({!red1_4[1], red1_1[30], !red1_3[1], red1_1[28], !red1_2[1], red1_1[26:16]}),
    .B(red1_2[30:15]),
    .Cin(red1_3[28:13]),
    .S(red2_0[33:18]),
    .Cout(red2_1[33:18]));
  
  
  assign {red2_3[28], red2_2[29]} = {red1_4[25], !red1_4[25]};
  
  half half2_1(
    .A(red1_4[12]),
    .B(red1_5[10]),
    .S(red2_2[16]),
    .Cout(red2_3[15]));
  
  full full2_1[11:0](
    .A(red1_4[24:13]),
    .B(red1_5[22:11]),
    .Cin(red1_6[20:9]),
    .S(red2_2[28:17]),
    .Cout(red2_3[27:16]));
  
  assign {red2_5[22], red2_4[23]} = {red1_7[17], !red1_7[17]};
  
  half half2_2(
    .A(red1_7[8]),
    .B(red1_8[6]),
    .S(red2_4[14]),
    .Cout(red2_5[13]));
  
  full full2_2[7:0](
    .A(red1_7[16:9]),
    .B(red1_8[14:7]),
    .Cin(red1_9[12:5]),
    .S(red2_4[22:15]),
    .Cout(red2_5[21:14]));
  
  
  assign {red2_7[16], red2_6[17]} = {red1_10[9], !red1_10[9]};
  
  half half2_3(
    .A(red1_10[4]),
    .B(red1_11[2]),
    .S(red2_6[12]),
    .Cout(red2_7[11]));
  
  full full2_3[3:0](
    .A(red1_10[8:5]),
    .B({!red1_1[0], red1_11[5:3]}),
    .Cin({!red1_0[0], red1_0[0], red1_0[0], red1_12[1]}),
    .S(red2_6[16:13]),
    .Cout(red2_7[15:12]));
  
  
  assign red2_0[46:35] = red1_0[47:36];
  assign red2_0[16:2] = red1_0[17:3];
  
  assign red2_1[45:35] = red1_1[44:34];
  assign red2_1[16:0] = {red1_0[18], red1_1[14:0], red1_0[2]};
  
  assign red2_2[41:30] = {
    red1_2[41:33],
    red1_1[33],
    red1_0[35:34]};
  assign red2_2[15:0] = {
    red1_0[19],
    red1_3[12],
    red1_2[13:0]};
  
  assign red2_3[37:29] = {
    red1_3[37:31],
    red1_2[32:31]};
  assign red2_3[14:0] = {
    red1_0[20],
    red1_4[11:10],
    red1_3[11:0]};
  
  assign red2_4[33:24] = {
    red1_4[33:29],
    red1_3[30:29],
    red1_1[31],
    red1_0[33:32]};
  assign red2_4[13:0] = {
    red1_0[21],
    red1_6[8],
    red1_5[9:8],
    red1_4[9:0]};
  
  assign red2_5[29:23] = {
    red1_5[29:27],
    red1_4[28:26],
    red1_5[23]};
  assign red2_5[12:0] = {
    red1_0[22],
    red1_7[7:6],
    red1_6[7:6],
    red1_5[7:0]};
  
  assign red2_6[25:18] = {
    red1_6[25],
    red1_5[26:24],
    red1_6[21],
    red1_1[29],
    red1_0[31:30]};
  assign red2_6[11:0] = {
    red1_0[23],
    red1_9[4],
    red1_8[5:4],
    red1_7[5:4],
    red1_6[5:0]};
  
  assign red2_7[22:17] = {
    red1_6[24:22],
    red1_7[19:18],
    red1_8[15]};
  assign red2_7[10:0] = {
    red1_0[24],
    red1_10[3:2],
    red1_9[3:2],
    red1_8[3:2],
    red1_7[3:0]};
  
  assign red2_8[19:0] = {
    red1_7[21:20],
    red1_8[17:16],
    red1_9[13],
    red1_1[27],
    red1_0[29:25],
    red1_12[0],
    red1_11[1:0],
    red1_10[1:0],
    red1_9[1:0],
    red1_8[1:0]};
  
endmodule
