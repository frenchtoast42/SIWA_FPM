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
