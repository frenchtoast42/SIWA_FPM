module REDUCTION2(
  input [47:0]red1_0,
  input [43:0]red1_1,
  input [38:0]red1_2,
  input [32:0]red1_3,
  input [26:0]red1_4,
  input [20:0]red1_5,
  input [14:0]red1_6,
  input [8:0]red1_7,
  input [2:0]red1_8,
  
  output [46:0]red2_0,
  output [44:0]red2_1,
  output [38:0]red2_2,
  output [32:0]red2_3,
  output [27:0]red2_4,
  output [23:0]red2_5);
  
  assign {red2_1[36], red2_0[37]} = {red1_0[38], !red1_0[38]};
  assign {red2_1[35], red2_0[36]} = {red1_0[37], !red1_0[37]};
  
  half half2_0(
    .A(red1_0[18]),
    .B(red1_1[14]),
    .S(red2_0[17]),
    .Cout(red2_1[16]));
  
  full full2_0[17:0](
    .A({!red1_3[1], red1_0[35:34], !red1_2[1], red1_0[32:19]}),
    .B(red1_1[32:15]),
    .C(red1_2[30:13]),
    .S(red2_0[35:18]),
    .Cout(red2_1[34:17]));
  
  
  assign {red2_3[27], red2_2[29]} = {red1_3[26], !red1_3[26]};
  assign {red2_3[26], red2_2[28]} = {red1_3[25], !red1_3[25]};
  
  half half2_1(
    .A(red1_3[12]),
    .B(red1_4[9]),
    .S(red2_2[15]),
    .Cout(red2_3[13]));
  
  full full2_1[11:0](
    .A(red1_3[24:13]),
    .B(red1_4[21:10]),
    .C(red1_5[18:7]),
    .S(red2_2[27:16]),
    .Cout(red2_3[25:14]));
  
  
  assign {red2_5[18], red2_4[20]} = {red1_6[14], !red1_6[14]};
  assign {red2_5[17], red2_4[19]} = {red1_6[13], !red1_6[13]};
  
  half half2_2(
    .A(red1_6[6]),
    .B(red1_7[3]),
    .S(red2_4[12]),
    .Cout(red2_5[10]));
  
  full full2_2[5:0](
    .A(red1_6[12:7]),
    .B({!red1_1[0], red1_7[8:4]}),
    .C({!red1_0[0], {3{red1_0[0]}}, red1_8[2:1]}),
    .S(red2_4[18:13]),
    .Cout(red2_5[16:11]));
  
  assign red2_0[2:0] = red1_0[2:1] + red1_0[0];
  
  
  assign red2_0[46:38] = red1_0[47:39];
  assign red2_0[16:3] = red1_0[17:4];
  
  assign red2_1[44:37] = red1_1[43:36];
  assign red2_1[15:0] = {red1_2[12], red1_1[13:0], red1_0[3]};
  
  assign red2_2[38:30] = {red1_2[38:34], red1_1[35:33], red1_0[36]};
  assign red2_2[14:0] = {red1_3[11:9], red1_2[11:0]};
  
  assign red2_3[32:28] = {red1_3[32:31], red1_2[33:31]};
  assign red2_3[12:0] = {red1_5[6], red1_4[8:6], red1_3[8:0]};
  
  assign red2_4[27:21] = {red1_3[30:27], red1_4[23:22], red1_0[33]};
  assign red2_4[11:0] = {red1_6[5:3], red1_5[5:3], red1_4[5:0]};
  
  assign red2_5[23:19] = {red1_4[26:24], red1_5[20:19]};
  assign red2_5[9:0] = {red1_8[0], red1_7[2:0], red1_6[2:0], red1_5[2:0]};
  
  
endmodule
