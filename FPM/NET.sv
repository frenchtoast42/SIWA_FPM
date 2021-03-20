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
