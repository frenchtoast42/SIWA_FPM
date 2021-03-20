`timescale 1ns / 1ps

module half(A, B, S, Cout);
  
  input A, B;
  output S;
  output Cout;
  
  assign S = A ^ B;
  assign Cout = A & B;
  
endmodule

module full(A, B, Cin, S, Cout);
  
  input A, B, Cin;
  output S;
  output Cout;
  
  wire y1, y2, y3;
  
  assign y1 = A ^ B;
  assign S = y1 ^ Cin;
  assign y2 = y1 & Cin;
  assign y3 = A & B;
  assign Cout = y2 | y3;
  
endmodule

module encoder(x, sel);
  
  input [2:0]x;
  output [2:0]sel; //single, double, neg
  
  assign sel[2] = x[0] ^ x[1];
  assign sel[1] = (x[0] & x[1] & !x[2]) | (!x[0] & !x[1] & x[2]);
  assign sel[0] = x[2];
  
endmodule

module selector(x, y, pp);
  input [22:0]y;
  input [2:0]x;
  
  output [24:0]pp;
  
  wire [2:0]sel; //single, double, neg
  wire [24:0]net0, net1, net2;
  
  encoder encoder(.x(x), .sel(sel));
  
  assign net0 = {25{sel[2]}} & {2'b01, y};  //{2'b01, y} : 0;
  assign net1 = {25{sel[1]}} & {1'b1, y, 1'b0};  //{1'b1, y, 1'b0} : 0;
  assign net2 = net0 | net1;
  
  assign pp = sel[0] ? ~net2 : net2;
  
endmodule

module selector0(x, y, pp);
  input [22:0]y;
  input [1:0]x;
  
  output [24:0]pp;
  
  wire [2:0]sel; //single, double, neg
  wire [24:0]net0, net1, net2;
  
  assign sel[2] = x[0];
  assign sel[1] = !x[0] & x[1];
  assign sel[0] = x[1];
  
  assign net0 = {25{sel[2]}} & {2'b01, y};  //{2'b01, y} : 0;
  assign net1 = {25{sel[1]}} & {1'b1, y, 1'b0};  //{1'b1, y, 1'b0} : 0;
  assign net2 = net0 | net1;
  
  assign pp = sel[0] ? ~net2 : net2;
  
endmodule

module selector11(x, y, pp);
  input [22:0]y;
  input [1:0]x;
  
  output [24:0]pp;
  
  wire [1:0]sel; //single, double, neg
  wire [24:0]net0, net1, net2;
  
  assign sel[1] = x[0] ^ x[1];
  assign sel[0] = !x[0] & !x[1];
  
  assign net0 = {25{sel[1]}} & {2'b01, y};  //{2'b01, y} : 0;
  assign net1 = {25{sel[0]}} & {1'b1, y, 1'b0};  //{1'b1, y, 1'b0} : 0;
  assign net2 = net0 | net1;
  
  assign pp = ~net2;
  
endmodule

module booth(
  input [22:0]X, Y,
  output [25:0]pp[10:0],
  output [24:0]pp11,
  output [22:0]pp12);
  
  genvar i;
  for (i = 0; i < 13; i = i+1)begin
    if(i == 0) begin
      selector0 selector0(.x({X[1], X[0]}), .y(Y), .pp(pp[i][25:1]));
      assign pp[i][0] = X[1];
      
    end else if(i < 11) begin
      
      selector selector(.x({X[2*i+1], X[2*i], X[2*i-1]}), .y(Y), .pp(pp[i][25:1]));
      assign pp[i][0] = X[2*i+1];
    
    end else if(i < 12) begin
      
      selector11 selector11(.x({X[2*i], X[2*i-1]}), .y(Y), .pp(pp11[24:0]));
      
    end else begin
      
      assign pp12 = Y;
      
    end
  end
  
endmodule

module REDUCTION1(
  input [25:0]pp0, pp1, pp2, pp3, pp4, pp5, pp6, pp7, pp8, pp9, pp10,
  input [24:0]pp11,
  input [22:0]pp12,
  
  output [47:0]red1_0,
  output [44:0]red1_1,
  output [41:0]red1_2,
  output [37:0]red1_3,
  output [33:0]red1_4,
  output [29:0]red1_5,
  output [25:0]red1_6,
  output [21:0]red1_7,
  output [17:0]red1_8,
  output [13:0]red1_9,
  output [9:0]red1_10,
  output [5:0]red1_11,
  output [1:0]red1_12);
  
  half half1_0[9:0](
    .A({pp0[21], pp0[19], pp0[17], pp0[15], pp0[13], pp0[11], pp0[9], pp0[7], pp0[5], pp0[3]}),
    .B({pp1[19], pp1[17], pp1[15], pp1[13], pp1[11], pp1[9], pp1[7], pp1[5], pp1[3], pp1[1]}),
    .S({red1_0[21], red1_0[19], red1_0[17], red1_0[15], red1_0[13], red1_0[11], red1_0[9], red1_0[7], red1_0[5], red1_0[3]}),
    .Cout({red1_0[22], red1_0[20], red1_0[18], red1_0[16], red1_0[14], red1_0[12], red1_0[10], red1_0[8], red1_0[6], red1_0[4]}));
  
  assign red1_0[23] = !pp0[23];
  assign red1_0[24] = pp0[23];
  
  assign red1_0[47:25] = {
    pp11[24:23],
    pp10[25:24],
    pp9[25:24],
    pp8[25:24],
    pp7[25:24],
    pp6[25:24],
    pp5[25:24],
    pp4[25:24],
    pp3[25:24],
    pp2[25:24],
    pp1[25:24],
    pp0[25]};
  assign red1_0[2:0] = pp0[2:0];
  
  assign red1_1[44:0] = {
    pp12[22:21],
    pp11[22:21],
    pp10[23:22],
    pp9[23:22],
    pp8[23:22],
    pp7[23:22],
    pp6[23:22],
    pp5[23:22],
    pp4[23:22],
    pp3[23:22],
    pp2[23:22],
    pp1[23],
    pp0[24], pp1[21],
    pp0[22], pp2[17],
    pp0[20], pp2[15],
    pp0[18], pp2[13],
    pp0[16], pp2[11],
    pp0[14], pp2[9],
    pp0[12], pp2[7],
    pp0[10],  pp2[5],
    pp0[8],  pp2[3],
    pp0[6],  pp2[1],
    pp0[4],  pp1[0]};
  
  assign red1_2[41:0] = {
    pp12[20:19],
    pp11[20:19],
    pp10[21:20],
    pp9[21:20],
    pp8[21:20],
    pp7[21:20],
    pp6[21:20],
    pp5[21:20],
    pp4[21:20],
    pp3[21:20],
    pp2[21],
    pp1[22], pp2[19],
    pp1[20], pp3[15],
    pp1[18], pp3[13],
    pp1[16], pp3[11],
    pp1[14], pp3[9],
    pp1[12], pp3[7],
    pp1[10], pp3[5],
    pp1[8],  pp3[3],
    pp1[6],  pp3[1],
    pp1[4],  pp2[0],
    pp1[2]};
  
  assign red1_3[37:0] = {
    pp12[18:17],
    pp11[18:17],
    pp10[19:18],
    pp9[19:18],
    pp8[19:18],
    pp7[19:18],
    pp6[19:18],
    pp5[19:18],
    pp4[19:18],
    pp3[19],
    pp2[20], pp3[17],
    pp2[18], pp4[13],
    pp2[16], pp4[11],
    pp2[14], pp4[9],
    pp2[12], pp4[7],
    pp2[10], pp4[5],
    pp2[8],  pp4[3],
    pp2[6],  pp4[1],
    pp2[4],  pp3[0],
    pp2[2]};
  
  assign red1_4[33:0] = {
    pp12[16:15],
    pp11[16:15],
    pp10[17:16],
    pp9[17:16],
    pp8[17:16],
    pp7[17:16],
    pp6[17:16],
    pp5[17:16],
    pp4[17],
    pp3[18], pp4[15],
    pp3[16], pp5[11],
    pp3[14], pp5[9],
    pp3[12], pp5[7],
    pp3[10], pp5[5],
    pp3[8],  pp5[3],
    pp3[6],  pp5[1],
    pp3[4],  pp4[0],
    pp3[2]};
  
  assign red1_5[29:0] = {
    pp12[14:13],
    pp11[14:13],
    pp10[15:14],
    pp9[15:14],
    pp8[15:14],
    pp7[15:14],
    pp6[15:14],
    pp5[15],
    pp4[16], pp5[13],
    pp4[14], pp6[9],
    pp4[12], pp6[7],
    pp4[10], pp6[5],
    pp4[8],  pp6[3],
    pp4[6],  pp6[1],
    pp4[4],  pp5[0],
    pp4[2]};
  
  assign red1_6[25:0] = {
    pp12[12:11],
    pp11[12:11],
    pp10[13:12],
    pp9[13:12],
    pp8[13:12],
    pp7[13:12],
    pp6[13],
    pp5[14], pp6[11],
    pp5[12], pp7[7],
    pp5[10], pp7[5],
    pp5[8],  pp7[3],
    pp5[6],  pp7[1],
    pp5[4],  pp6[0],
    pp5[2]};
  
  assign red1_7[21:0] = {
    pp12[10:9],
    pp11[10:9],
    pp10[11:10],
    pp9[11:10],
    pp8[11:10],
    pp7[11],
    pp6[12], pp7[9],
    pp6[10], pp8[5],
    pp6[8],  pp8[3],
    pp6[6],  pp8[1],
    pp6[4],  pp7[0],
    pp6[2]};
  
  assign red1_8[17:0] = {
    pp12[8:7],
    pp11[8:7],
    pp10[9:8],
    pp9[9:8],
    pp8[9],
    pp7[10], pp8[7],
    pp7[8],  pp9[3],
    pp7[6],  pp9[1],
    pp7[4],  pp8[0],
    pp7[2]};
  
  assign red1_9[13:0] = {
    pp12[6:5],
    pp11[6:5],
    pp10[7:6],
    pp9[7],
    pp8[8], pp9[5],
    pp8[6], pp10[1],
    pp8[4], pp9[0],
    pp8[2]};
  
  assign red1_10[9:0] = {
    pp12[4:3],
    pp11[4:3],
    pp10[5],
    pp9[6], pp10[3],
    pp9[4], pp10[0],
    pp9[2]};
  
  assign red1_11[5:0] = {
    pp12[2:1],
    pp11[2],
    pp10[4], pp11[0],
    pp10[2]};
  
  assign red1_12[1:0] = {
    pp12[0],
    pp11[1]};
  
endmodule

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

module CPA(
  input [47:0]red6_0,
  input [46:0]red6_1,
  
  output [47:0]Z);
  
  assign Z[0] = red6_0[0];
  
  assign Z[47:1] = red6_0[47:1] + red6_1;
  
endmodule

module REDUCTION_TREE(
  input [25:0]pp[10:0],
  input [24:0]pp11,
  input [22:0]pp12,
  
  output [47:0]Z);
  
  //REDUCTION 1
  
  wire [47:0]red1_0;
  wire [44:0]red1_1;
  wire [41:0]red1_2;
  wire [37:0]red1_3;
  wire [33:0]red1_4;
  wire [29:0]red1_5;
  wire [25:0]red1_6;
  wire [21:0]red1_7;
  wire [17:0]red1_8;
  wire [13:0]red1_9;
  wire [9:0]red1_10;
  wire [5:0]red1_11;
  wire [1:0]red1_12;
  
  REDUCTION1 REDUCTION1(.pp0(pp[0]), .pp1(pp[1]), .pp2(pp[2]), .pp3(pp[3]),
                        .pp4(pp[4]), .pp5(pp[5]), .pp6(pp[6]), .pp7(pp[7]),
                        .pp8(pp[8]), .pp9(pp[9]), .pp10(pp[10]), .pp11(pp11),
                        .pp12(pp12),
                       
                       .red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                       .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                       .red1_8(red1_8), .red1_9(red1_9), .red1_10(red1_10), .red1_11(red1_11),
                       .red1_12(red1_12));
  
  //REDUCTION 2
  
  wire [46:0]red2_0;
  wire [45:0]red2_1;
  wire [41:0]red2_2;
  wire [37:0]red2_3;
  wire [33:0]red2_4;
  wire [29:0]red2_5;
  wire [25:0]red2_6;
  wire [22:0]red2_7;
  wire [19:0]red2_8;
  
  REDUCTION2 REDUCTION2(.red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                        .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                        .red1_8(red1_8), .red1_9(red1_9), .red1_10(red1_10), .red1_11(red1_11),
                        .red1_12(red1_12),
                      
                       .red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                       .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5),
                       .red2_6(red2_6), .red2_7(red2_7), .red2_8(red2_8));
  
  //REDUCTION 3
  
  wire [46:0]red3_0;
  wire [45:0]red3_1;
  wire [41:0]red3_2;
  wire [37:0]red3_3;
  wire [34:0]red3_4;
  wire [31:0]red3_5;
  
  wire [2:0]g3;
  
  REDUCTION3 REDUCTION3(.red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                        .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5),
                        .red2_6(red2_6), .red2_7(red2_7), .red2_8(red2_8),
                        
                        .red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3), .red3_4(red3_4), .red3_5(red3_5), 
                       
                        .g3(g3));
  
  //REDUCTION 4
  
  wire [46:0]red4_0;
  wire [45:0]red4_1;
  wire [42:0]red4_2;
  wire [39:0]red4_3;
  
  wire g4;
  
  REDUCTION4 REDUCTION4(.red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3), .red3_4(red3_4), .red3_5(red3_5),
                        
                        .g3(g3),
                        
                        .red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2), .red4_3(red4_3),
                       
                        .g4(g4));
  
  //REDUCTION 5
  
  wire [47:0]red5_0;
  wire [45:0]red5_1;
  wire [43:0]red5_2;
  
  REDUCTION5 REDUCTION5(.red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2), .red4_3(red4_3),
                        
                        .g4(g4),
                        
                        .red5_0(red5_0), .red5_1(red5_1), .red5_2(red5_2));
  
  //REDUCTION 6
  
  wire [47:0]red6_0;
  wire [46:0]red6_1;
  
  REDUCTION6 REDUCTION6(.red5_0(red5_0), .red5_1(red5_1), .red5_2(red5_2),
                        
                        .red6_0(red6_0), .red6_1(red6_1));
  
  //FINAL CPA
  
  CPA CPA(.red6_0(red6_0), .red6_1(red6_1), .Z(Z));
  
  
endmodule

module MUL(
  input [22:0]frc_X, frc_Y,
  output [47:0]frc_Z_full);
  
  //wire [28:0]pp[12:0];
  
  wire [25:0]pp[10:0];
  wire [24:0]pp11;
  wire [22:0]pp12;
  
  booth booth(.X(frc_X), .Y(frc_Y), .pp(pp), .pp11(pp11), .pp12(pp12));
  
  REDUCTION_TREE RED(.pp(pp),
                     .pp11(pp11),
                     .pp12(pp12),
                     
                     .Z(frc_Z_full));
  
  //assign frc_Z_full = {1'b1, frc_X} * {1'b1, frc_Y};
  
endmodule

module NORM(
  input [47:0]Z_in,
  output [26:0]Z_out,
  output norm_n);
  
  wire [47:0]Z_shift;
  
  assign Z_shift = Z_in << !Z_in[47];
  
  assign Z_out[26:1] = Z_shift[47:22];
  assign Z_out[0] = |Z_shift[21:0]; //sticky
  
  assign norm_n = Z_in[47];
  
endmodule

module ROUND(
  input sign_Z,
  input [2:0]r_mode,
  input [26:0]Z_in,
  output norm_r,
  output [22:0]Z_out);
  
  wire [24:0]Z_plus, Z_up, Z_down, Z_near_max, Z_near_even;
  wire [24:0]Z_round;
  wire RNE, RTZ, RDN, RUP, RMM;
  
  assign RNE = (r_mode == 3'b000); //round to nearest, ties to even
  assign RTZ = (r_mode == 3'b001); //round to zero
  assign RDN = (r_mode == 3'b010); //round down
  assign RUP = (r_mode == 3'b011); //round up
  assign RMM = (r_mode == 3'b100); //round to nearest, ties to max magnitude
  
  assign Z_plus = Z_in[26:3] + 1'b1;
  
  assign Z_up = sign_Z ? {1'b0, Z_in[26:3]} : Z_plus;
  assign Z_down = sign_Z ? Z_plus : {1'b0, Z_in[26:3]};
  
  assign Z_near_even = !Z_in[2] ? Z_in[26:3] : (|Z_in[1:0] ? Z_plus : (Z_in[3] ? Z_plus : Z_in[26:3]));
  assign Z_near_max = !Z_in[2] ? Z_in[26:3] : Z_plus;
  
  //assign Z_round = Z_near_max;
  assign Z_round =
    RNE ? Z_near_even :
    (RTZ ? Z_in[26:3] :
     (RDN ? Z_down :
      (RUP ? Z_up : Z_near_max)));
  
  assign norm_r = Z_round[24];
  
  assign Z_out = norm_r ? Z_round[23:1] : Z_round[22:0];
  
endmodule

module EXP(
  input norm,
  input [7:0]exp_X, exp_Y,
  output [7:0]exp_Z,
  output ovrf, udrf);
  
  wire [8:0]buffer;
  
  assign buffer = exp_X + exp_Y;
  
  wire [7:0]bias;
  
  assign bias = {7'b0111111, !norm};
  
  assign ovrf = {buffer >= {255 + bias}};
  assign udrf = {buffer <= bias};
  
  assign exp_Z = exp_X + exp_Y - bias;
  
endmodule

module EXC(
  input [22:0]frc_X, frc_Y,
  input [7:0]exp_X, exp_Y,
  input udrf, ovrf,
  
  output nan, inf, zer);
  
  wire nan_X, nan_Y, nan_Z;
  wire inf_X, inf_Y;
  wire zer_X, zer_Y;
  
  assign inf_X = &exp_X & ~|frc_X;
  assign inf_Y = &exp_Y & ~|frc_Y;
  assign inf = inf_X | inf_Y | ovrf;
  
  assign zer_X = ~|exp_X;
  assign zer_Y = ~|exp_Y;
  assign zer = zer_X | zer_Y | udrf;
  
  assign nan_X = &exp_X & |frc_X;
  assign nan_Y = &exp_Y & |frc_Y;
  assign nan_Z = {&exp_X & zer_Y} | {&exp_Y & zer_X};
  assign nan = nan_X | nan_Y | nan_Z;
  
endmodule

module NET(
  input nan, inf, zer,
  input [31:0]Z,
  output [31:0]fp_Z);
  
  assign fp_Z = nan ? 32'h7fc00000 : (inf ? {Z[31], 8'hff, 23'b0} : (zer ? {Z[31], 8'h00, 23'b0} : Z));
  
  /*always @(posedge clk)begin
    if(nan)
      res <= {z[31], 8'hff, 22'b0, 1'b1};
    else if(inf)
      res <= {z[31], 8'hff, 23'b0};
    else if(zer)
      res <= {z[31], 8'h00, 23'b0};
    else
      res <= z;
    
  end*/
  
endmodule

module FPM(
  input [2:0]r_mode,
  input [31:0]fp_X, fp_Y,
  output [31:0]fp_Z,
  output ovrf, udrf);
  
  wire [31:0]z;
  
  wire [22:0]frc_X, frc_Y;
  wire [7:0]exp_X, exp_Y, exp_Z;
  
  wire nan, inf, zer;
  wire norm_n, norm_r;
  wire sign_Z;
  
  assign exp_X = fp_X[30:23];
  assign exp_Y = fp_Y[30:23];
  
  assign frc_X = fp_X[22:0];
  assign frc_Y = fp_Y[22:0];
  
  assign sign_Z = fp_X[31] ^ fp_Y[31];
  
  wire [47:0]frc_Z_full; //full multiplier output
  wire [26:0]frc_Z_norm; //with leading, guard, round and sticky bits
  wire [22:0]frc_Z; //rounded Z fraction bits
  
  MUL MUL(.frc_X(frc_X),
          .frc_Y(frc_Y),
          
          .frc_Z_full(frc_Z_full));
  
  NORM NORM(.Z_in(frc_Z_full),
            
            .Z_out(frc_Z_norm),
            .norm_n(norm_n));
  
  ROUND ROUND(.sign_Z(sign_Z),
              .r_mode(r_mode),
              .Z_in(frc_Z_norm),
              
              .norm_r(norm_r),
              .Z_out(frc_Z));
  
  EXP EXP(.norm(norm_n | norm_r),
          .exp_X(exp_X),
          .exp_Y(exp_Y),
          
          .exp_Z(exp_Z),
          .ovrf(ovrf),
          .udrf(udrf));
  
  EXC EXC(.frc_X(frc_X), .frc_Y(frc_Y),
          .exp_X(exp_X), .exp_Y(exp_Y),
          .ovrf(ovrf), .udrf(udrf),
          
          .nan(nan),
          .inf(inf),
          .zer(zer));
  
  NET NET(.nan(nan),
          .inf(inf),
          .zer(zer),
          .Z({sign_Z, exp_Z, frc_Z}),
          
          .fp_Z(fp_Z));
  
endmodule

module top(
  input clk,
  input [2:0]r_mode,
  input [31:0]fp_X, fp_Y,
  output [31:0]fp_Z,
  output ovrf, udrf);
  
  FPM FPM(.r_mode(r_mode),
          .fp_X(fp_X),
          .fp_Y(fp_Y),
          
          .fp_Z(fp_Z),
          .ovrf(ovrf),
          .udrf(udrf));
  
endmodule
