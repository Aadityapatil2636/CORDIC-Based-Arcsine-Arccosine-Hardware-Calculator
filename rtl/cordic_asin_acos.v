
module cordic_asin_acos (
    input                     clk,
    input                     rst,
    input  signed [23:0]      x_in,
    output reg signed [23:0]  asin_out,
    output reg signed [23:0]  acos_out
);

    localparam W = 24;
    localparam M = 16;                          

    
    localparam signed [W-1:0] START_XY = 24'sd746442;   
    localparam signed [W-1:0] PI_4     = 24'sd823550;   
    localparam signed [W-1:0] PI_2     = 24'sd1647099;  

    
    function signed [W-1:0] angle_table;
        input integer i;
        begin
            case (i)
                1:  angle_table = 24'sd486170;
                2:  angle_table = 24'sd256879;
                3:  angle_table = 24'sd130396;
                4:  angle_table = 24'sd65451;
                5:  angle_table = 24'sd32757;
                6:  angle_table = 24'sd16383;
                7:  angle_table = 24'sd8192;
                8:  angle_table = 24'sd4096;
                9:  angle_table = 24'sd2048;
                10: angle_table = 24'sd1024;
                11: angle_table = 24'sd512;
                12: angle_table = 24'sd256;
                13: angle_table = 24'sd128;
                14: angle_table = 24'sd64;
                15: angle_table = 24'sd32;
                default: angle_table = 0;
            endcase
        end
    endfunction

    
    wire                neg [0:M-1];
    wire signed [W-1:0] x   [0:M-1];
    wire signed [W-1:0] y   [0:M-1];
    wire signed [W-1:0] z   [0:M-1];
    wire signed [W-1:0] t   [0:M-1];

    
    reg                neg_r;
    reg signed [W-1:0] x_r, y_r, z_r, t_r;

    always @(posedge clk) begin
        if (rst) begin
            neg_r <= 0;
            x_r   <= 0;
            y_r   <= 0;
            z_r   <= 0;
            t_r   <= 0;
        end else begin
            neg_r <= (x_in < 0);
            x_r   <= START_XY;
            y_r   <= START_XY;
            z_r   <= PI_4;
            t_r   <= (x_in < 0) ? -x_in : x_in;    
        end
    end

    assign neg[0] = neg_r;
    assign x[0]   = x_r;
    assign y[0]   = y_r;
    assign z[0]   = z_r;
    assign t[0]   = t_r;

    
    genvar k;
    generate
        for (k = 1; k < M; k = k + 1) begin : stages
            cordic_stage #(
                .W(W),
                .I(k),
                .ANGLE(angle_table(k))
            ) stage_k (
                .clk(clk),   .rst(rst),
                .neg_in(neg[k-1]),
                .x_in(x[k-1]), .y_in(y[k-1]), .z_in(z[k-1]), .t_in(t[k-1]),
                .neg_out(neg[k]),
                .x_out(x[k]),  .y_out(y[k]),  .z_out(z[k]),  .t_out(t[k])
            );
        end
    endgenerate

    
    wire signed [W-1:0] asin_value = neg[M-1] ? -z[M-1] : z[M-1];

    always @(posedge clk) begin
        if (rst) begin
            asin_out <= 0;
            acos_out <= 0;
        end else begin
            asin_out <= asin_value;
            acos_out <= PI_2 - asin_value;
        end
    end

endmodule
