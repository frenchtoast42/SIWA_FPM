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
