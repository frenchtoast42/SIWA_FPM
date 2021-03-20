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
