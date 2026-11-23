`timescale 1ns/1ps



module tb_cordic_asin_acos;

    
    reg                clk = 0;
    reg                rst = 1;
    reg  signed [23:0] x_in = 0;
    wire signed [23:0] asin_out;
    wire signed [23:0] acos_out;

   
    localparam LATENCY = 17;              
    localparam N       = 2001;            
    localparam real SCALE = 1048576.0;    

   
    cordic_asin_acos dut (
        .clk(clk), .rst(rst), .x_in(x_in),
        .asin_out(asin_out), .acos_out(acos_out)
    );

    
    always #5 clk = ~clk;

    
    real asin_got, acos_got;              
    real asin_err, acos_err;              
    real max_asin_mid, max_acos_mid;      
    real max_asin_all, max_acos_all;      
    real x_real;
    integer n;


    
    task test_one;
        input real    x;
        input integer show;
        begin
            @(negedge clk);                      
            x_in = $rtoi(x * SCALE);             

            repeat (LATENCY + 1) @(posedge clk); 
            #1;                                  

            asin_got = asin_out / SCALE;         
            acos_got = acos_out / SCALE;

            asin_err = asin_got - $asin(x);      
            acos_err = acos_got - $acos(x);
            if (asin_err < 0) asin_err = -asin_err;   
            if (acos_err < 0) acos_err = -acos_err;

            
            if (asin_err > max_asin_all) max_asin_all = asin_err;
            if (acos_err > max_acos_all) max_acos_all = acos_err;
            if (x > -0.99 && x < 0.99) begin
                if (asin_err > max_asin_mid) max_asin_mid = asin_err;
                if (acos_err > max_acos_mid) max_acos_mid = acos_err;
            end

            if (show)
                $display("x = %9.6f | asin: design %9.6f exact %9.6f | acos: design %9.6f exact %9.6f",
                         x, asin_got, $asin(x), acos_got, $acos(x));
        end
    endtask

    
    initial begin
        max_asin_mid = 0.0;  max_acos_mid = 0.0;
        max_asin_all = 0.0;  max_acos_all = 0.0;

        
        repeat (3) @(posedge clk);
        rst = 0;

        
        $display("---- sample values ----");
        test_one(-1.0, 1);
        test_one(-0.6, 1);
        test_one(-0.2, 1);
        test_one( 0.2, 1);
        test_one( 0.6, 1);
        test_one( 1.0, 1);

        
        for (n = 0; n < N; n = n + 1) begin
            x_real = -1.0 + 2.0 * n / (N - 1);
            test_one(x_real, 0);
        end

        
        $display("---- results ----");
        $display("max error arcsin, |x| < 0.99 : %e rad", max_asin_mid);
        $display("max error arccos, |x| < 0.99 : %e rad", max_acos_mid);
        $display("max error arcsin, all x      : %e rad", max_asin_all);
        $display("max error arccos, all x      : %e rad", max_acos_all);

        if (max_asin_mid < 1.0e-4 && max_acos_mid < 1.0e-4)
            $display("PASS: error is below 1e-4 rad for |x| < 0.99");
        else
            $display("FAIL: error is too large");

        $finish;
    end

endmodule
