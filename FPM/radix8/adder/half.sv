module half(A, B, S, Cout);
  
  input A, B;
  output S;
  output Cout;
  
  assign S = A ^ B;
  assign Cout = A & B;
  
endmodule
