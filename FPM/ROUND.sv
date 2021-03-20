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
