
module cordic_stage #(
    parameter W = 24,                    
    parameter I = 1,                     
    parameter signed [W-1:0] ANGLE = 0   
)(
    input                     clk,
    input                     rst,
    input                     neg_in,   
    input  signed [W-1:0]     x_in,
    input  signed [W-1:0]     y_in,
    input  signed [W-1:0]     z_in,
    input  signed [W-1:0]     t_in,
    output reg                neg_out,
    output reg signed [W-1:0] x_out,
    output reg signed [W-1:0] y_out,
    output reg signed [W-1:0] z_out,
    output reg signed [W-1:0] t_out
);

    
    
    
    
    wire go_up = (y_in < t_in) && (x_in >= 0);

    
    wire signed [W-1:0] x_shifted = x_in >>> I;
    wire signed [W-1:0] y_shifted = y_in >>> I;
    wire signed [W-1:0] t_shifted = t_in >>> (2*I + 1);   

    always @(posedge clk) begin
        if (rst) begin
            neg_out <= 0;
            x_out   <= 0;
            y_out   <= 0;
            z_out   <= 0;
            t_out   <= 0;
        end else begin
            neg_out <= neg_in;

            
            if (go_up) begin
                x_out <= x_in - y_shifted;
                y_out <= y_in + x_shifted;
                z_out <= z_in + ANGLE;       
            end else begin
                x_out <= x_in + y_shifted;
                y_out <= y_in - x_shifted;
                z_out <= z_in - ANGLE;       
            end

            
            t_out <= t_in + t_shifted;
        end
    end

endmodule
