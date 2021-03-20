module booth(
  input [22:0]X, Y,
  output [26:0]pp[6:0],
  output [25:0]pp7,
  output [22:0]pp8);
  
  wire [23:0]Y3;
  
  Y3_gen Y3_gen(.Y(Y), .Y3(Y3));
  
  genvar i;
  for (i = 0; i < 9; i = i+1)begin
    if(i == 0) begin
      
      selector0 selector0(.x(X[3*i+2:i]), .y(Y), .Y3(Y3), .pp(pp[i][26:1]));
      assign pp[i][0] = X[3*i+2];
     
    end else if(i < 7) begin
      selector selector(.x(X[3*i+2:3*i-1]), .y(Y), .Y3(Y3), .pp(pp[i][26:1]));
      assign pp[i][0] = X[3*i+2];
      
      
    end else if(i < 8) begin
      
      selector7 selector7(.x(X[3*i+1:3*i-1]), .y(Y), .Y3(Y3), .pp(pp7));
      
      
    end else begin
      
      //selector selector(.x({3'b000, x[3*i-1]}), .y(y), .Y3(Y3), .pp(pp[i]));
      assign pp8 = Y;
      
    end
  end
  
endmodule
