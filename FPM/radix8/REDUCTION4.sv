module REDUCTION4(
  input [46:0]red3_0,
  input [44:0]red3_1,
  input [40:0]red3_2,
  input [35:0]red3_3,
  
  output [47:0]red4_0,
  output [44:0]red4_1,
  output [41:0]red4_2);
  
  assign red4_0[47:46] = {red3_1[44], !red3_1[44]};
  
  assign {red4_1[44], red4_0[45]} = {
    (red3_1[43] ^ red3_2[40]) | (red3_1[43] & red3_2[40]),
    ~(red3_1[43] ^ red3_2[40])};
  
  half half4_0[1:0](
    .A({red3_1[42], red3_1[6]}),
    .B({red3_2[39], red3_2[3]}),
    .S({red4_0[44], red4_0[8]}),
    .Cout({red4_1[43], red4_1[7]}));
  
  full full4_0[34:0](
    .C(red3_1[41:7]),
    .B(red3_2[38:4]),
    .A(red3_3[35:1]),
    .S(red4_0[43:9]),
    .Cout(red4_1[42:8]));
  
  
  assign red4_0[7:0] = red3_0[7:0];
  
  assign red4_1[6:0] = {red3_0[8], red3_1[5:0]};
  
  assign red4_2[41:0] = {red3_0[46:9], red3_3[0], red3_2[2:0]};
  
endmodule
