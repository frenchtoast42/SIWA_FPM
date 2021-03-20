module REDUCTION1(
  input [26:0]pp0, pp1, pp2, pp3, pp4, pp5, pp6,
  input [25:0]pp7,
  input [22:0]pp8,
  
  output [47:0]red1_0,
  output [43:0]red1_1,
  output [38:0]red1_2,
  output [32:0]red1_3,
  output [26:0]red1_4,
  output [20:0]red1_5,
  output [14:0]red1_6,
  output [8:0]red1_7,
  output [2:0]red1_8);
  
  half half1_0[12:0](
    .A({pp0[23], pp0[20:19], pp0[17:16], pp0[14:13], pp0[11:10], pp0[8:7], pp0[5:4]}),
    
    .B({pp1[20], pp1[17:16], pp1[14:13], pp1[11:10], pp1[8:7], pp1[5:4], pp1[2:1]}),
    
    .S({red1_0[23], red1_0[20:19], red1_0[17:16], red1_0[14:13], red1_0[11:10], red1_0[8:7], red1_0[5:4]}),
    
    .Cout({red1_0[24], red1_0[21], red1_1[16], red1_0[18], red1_1[13], red1_0[15], red1_1[10], red1_0[12], red1_1[7], red1_0[9], red1_1[4], red1_0[6], red1_1[1]}));
  
  assign red1_1[19] = pp0[22];
  assign red1_0[22] = !pp0[22];
  
  assign red1_0[47:25] = {
    pp7[25:23],
    pp6[26:24],
    pp5[26:24],
    pp4[26:24],
    pp3[26:24],
    pp2[26:24],
    pp1[26:24],
    pp0[26:25]};
  assign red1_0[3:0] = pp0[3:0];
  
  assign red1_1[43:20] = {
    pp8[22:20],
    pp7[22:20],
    pp6[23:21],
    pp5[23:21],
    pp4[23:21],
    pp3[23:21],
    pp2[23:21],
    pp1[23:22],
    pp0[24]};
  assign red1_1[18:17] = {pp1[19], pp0[21]};
  assign red1_1[15:14] = {pp2[13], pp0[18]};
  assign red1_1[12:11] = {pp2[10], pp0[15]};
  assign red1_1[9:8] = {pp2[7], pp0[12]};
  assign red1_1[6:5] = {pp2[4], pp0[9]};
  assign red1_1[3:2] = {pp2[1], pp0[6]};
  assign red1_1[0] = pp1[0];
  
  assign red1_2[38:0] = {
    pp8[19:17],
    pp7[19:17],
    pp6[20:18],
    pp5[20:18],
    pp4[20:18],
    pp3[20:18],
    pp2[20:19],
    pp1[21], pp2[17:16],
    pp1[18], pp2[14], pp3[10],
    pp1[15], pp2[11], pp3[7],
    pp1[12], pp2[8], pp3[4],
    pp1[9], pp2[5], pp3[1],
    pp1[6], pp2[2], pp2[0],
    pp1[3]};
  
  assign red1_3[32:0] = {
    pp8[16:14],
    pp7[16:14],
    pp6[17:15],
    pp5[17:15],
    pp4[17:15],
    pp3[17:16],
    pp2[18], pp3[14:13],
    pp2[15], pp3[11], pp4[7],
    pp2[12], pp3[8], pp4[4],
    pp2[9], pp3[5], pp4[1],
    pp2[6], pp3[2], pp3[0],
    pp2[3]};
  
  assign red1_4[26:0] = {
    pp8[13:11],
    pp7[13:11],
    pp6[14:12],
    pp5[14:12],
    pp4[14:13],
    pp3[15], pp4[11:10],
    pp3[12], pp4[8], pp5[4],
    pp3[9], pp4[5], pp5[1],
    pp3[6], pp4[2], pp4[0],
    pp3[3]};
  
  assign red1_5[20:0] = {
    pp8[10:8],
    pp7[10:8],
    pp6[11:9],
    pp5[11:10],
    pp4[12], pp5[8:7],
    pp4[9], pp5[5], pp6[1],
    pp4[6], pp5[2], pp5[0],
    pp4[3]};
  
  assign red1_6[14:0] = {
    pp8[7:5],
    pp7[7:5],
    pp6[8:7],
    pp5[9], pp6[5:4],
    pp5[6], pp6[2], pp6[0],
    pp5[3]};
  
  assign red1_7[8:0] = {
    pp8[4:2],
    pp7[4:3], pp6[6],
    pp7[1:0], pp6[3]};
  
  assign red1_8[2:0] = {pp8[1:0], pp7[2]};
  
endmodule
