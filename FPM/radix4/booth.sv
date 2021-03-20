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
