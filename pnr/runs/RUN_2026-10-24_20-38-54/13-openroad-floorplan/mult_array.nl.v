module mult_array (clk,
    rst_n,
    a,
    b,
    p);
 input clk;
 input rst_n;
 input [3:0] a;
 input [3:0] b;
 output [7:0] p;

 wire \FA0.sum ;
 wire \FA10.sum ;
 wire \FA11.cout ;
 wire \FA11.sum ;
 wire \FA4.sum ;
 wire \FA8.sum ;
 wire \FA9.sum ;
 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire \a_reg[0] ;
 wire \a_reg[1] ;
 wire \a_reg[2] ;
 wire \a_reg[3] ;
 wire \b_reg[0] ;
 wire \b_reg[1] ;
 wire \b_reg[2] ;
 wire \b_reg[3] ;
 wire \pp0[0] ;

 sky130_fd_sc_hd__and2_2 _047_ (.A(\a_reg[0] ),
    .B(\b_reg[0] ),
    .X(\pp0[0] ));
 sky130_fd_sc_hd__and3_2 _048_ (.A(\b_reg[1] ),
    .B(\a_reg[1] ),
    .C(\pp0[0] ),
    .X(_000_));
 sky130_fd_sc_hd__a22oi_2 _049_ (.A1(\b_reg[1] ),
    .A2(\a_reg[0] ),
    .B1(\a_reg[1] ),
    .B2(\b_reg[0] ),
    .Y(_001_));
 sky130_fd_sc_hd__nor2_2 _050_ (.A(_000_),
    .B(_001_),
    .Y(\FA0.sum ));
 sky130_fd_sc_hd__nand4_2 _051_ (.A(\b_reg[1] ),
    .B(\a_reg[1] ),
    .C(\b_reg[0] ),
    .D(\a_reg[2] ),
    .Y(_002_));
 sky130_fd_sc_hd__a22o_2 _052_ (.A1(\b_reg[1] ),
    .A2(\a_reg[1] ),
    .B1(\b_reg[0] ),
    .B2(\a_reg[2] ),
    .X(_003_));
 sky130_fd_sc_hd__nand2_2 _053_ (.A(_002_),
    .B(_003_),
    .Y(_004_));
 sky130_fd_sc_hd__xnor2_2 _054_ (.A(_000_),
    .B(_004_),
    .Y(_005_));
 sky130_fd_sc_hd__and3_2 _055_ (.A(\a_reg[0] ),
    .B(\b_reg[2] ),
    .C(_005_),
    .X(_006_));
 sky130_fd_sc_hd__a21oi_2 _056_ (.A1(\a_reg[0] ),
    .A2(\b_reg[2] ),
    .B1(_005_),
    .Y(_007_));
 sky130_fd_sc_hd__nor2_2 _057_ (.A(_006_),
    .B(_007_),
    .Y(\FA4.sum ));
 sky130_fd_sc_hd__o2111a_2 _058_ (.A1(\a_reg[0] ),
    .A2(\a_reg[2] ),
    .B1(\a_reg[1] ),
    .C1(\b_reg[1] ),
    .D1(\b_reg[0] ),
    .X(_008_));
 sky130_fd_sc_hd__nand2_2 _059_ (.A(\b_reg[1] ),
    .B(\a_reg[3] ),
    .Y(_009_));
 sky130_fd_sc_hd__and4_2 _060_ (.A(\b_reg[1] ),
    .B(\b_reg[0] ),
    .C(\a_reg[2] ),
    .D(\a_reg[3] ),
    .X(_010_));
 sky130_fd_sc_hd__nand4_2 _061_ (.A(\b_reg[1] ),
    .B(\b_reg[0] ),
    .C(\a_reg[2] ),
    .D(\a_reg[3] ),
    .Y(_011_));
 sky130_fd_sc_hd__a22o_2 _062_ (.A1(\b_reg[1] ),
    .A2(\a_reg[2] ),
    .B1(\a_reg[3] ),
    .B2(\b_reg[0] ),
    .X(_012_));
 sky130_fd_sc_hd__a21o_2 _063_ (.A1(_011_),
    .A2(_012_),
    .B1(_008_),
    .X(_013_));
 sky130_fd_sc_hd__nand3_2 _064_ (.A(_008_),
    .B(_011_),
    .C(_012_),
    .Y(_014_));
 sky130_fd_sc_hd__and4_2 _065_ (.A(\a_reg[1] ),
    .B(\b_reg[2] ),
    .C(_013_),
    .D(_014_),
    .X(_015_));
 sky130_fd_sc_hd__a22o_2 _066_ (.A1(\a_reg[1] ),
    .A2(\b_reg[2] ),
    .B1(_013_),
    .B2(_014_),
    .X(_016_));
 sky130_fd_sc_hd__nand2b_2 _067_ (.A_N(_015_),
    .B(_016_),
    .Y(_017_));
 sky130_fd_sc_hd__xnor2_2 _068_ (.A(_006_),
    .B(_017_),
    .Y(_018_));
 sky130_fd_sc_hd__and3_2 _069_ (.A(\a_reg[0] ),
    .B(\b_reg[3] ),
    .C(_018_),
    .X(_019_));
 sky130_fd_sc_hd__a21oi_2 _070_ (.A1(\a_reg[0] ),
    .A2(\b_reg[3] ),
    .B1(_018_),
    .Y(_020_));
 sky130_fd_sc_hd__nor2_2 _071_ (.A(_019_),
    .B(_020_),
    .Y(\FA8.sum ));
 sky130_fd_sc_hd__a21o_2 _072_ (.A1(\a_reg[3] ),
    .A2(_000_),
    .B1(_010_),
    .X(_021_));
 sky130_fd_sc_hd__a221o_2 _073_ (.A1(\a_reg[3] ),
    .A2(_000_),
    .B1(_002_),
    .B2(_009_),
    .C1(_010_),
    .X(_022_));
 sky130_fd_sc_hd__nand2_2 _074_ (.A(\b_reg[2] ),
    .B(\a_reg[2] ),
    .Y(_023_));
 sky130_fd_sc_hd__nand2_2 _075_ (.A(_022_),
    .B(_023_),
    .Y(_024_));
 sky130_fd_sc_hd__nor2_2 _076_ (.A(_022_),
    .B(_023_),
    .Y(_025_));
 sky130_fd_sc_hd__xnor2_2 _077_ (.A(_022_),
    .B(_023_),
    .Y(_026_));
 sky130_fd_sc_hd__a41o_2 _078_ (.A1(\a_reg[0] ),
    .A2(\b_reg[2] ),
    .A3(_005_),
    .A4(_016_),
    .B1(_015_),
    .X(_027_));
 sky130_fd_sc_hd__xnor2_2 _079_ (.A(_026_),
    .B(_027_),
    .Y(_028_));
 sky130_fd_sc_hd__and3_2 _080_ (.A(\a_reg[1] ),
    .B(\b_reg[3] ),
    .C(_028_),
    .X(_029_));
 sky130_fd_sc_hd__a21o_2 _081_ (.A1(\a_reg[1] ),
    .A2(\b_reg[3] ),
    .B1(_028_),
    .X(_030_));
 sky130_fd_sc_hd__nand2b_2 _082_ (.A_N(_029_),
    .B(_030_),
    .Y(_031_));
 sky130_fd_sc_hd__xnor2_2 _083_ (.A(_019_),
    .B(_031_),
    .Y(\FA9.sum ));
 sky130_fd_sc_hd__and2_2 _084_ (.A(\a_reg[2] ),
    .B(\b_reg[3] ),
    .X(_032_));
 sky130_fd_sc_hd__and2_2 _085_ (.A(\b_reg[2] ),
    .B(_021_),
    .X(_033_));
 sky130_fd_sc_hd__a21oi_2 _086_ (.A1(\b_reg[2] ),
    .A2(\a_reg[3] ),
    .B1(_021_),
    .Y(_034_));
 sky130_fd_sc_hd__or2_2 _087_ (.A(_033_),
    .B(_034_),
    .X(_035_));
 sky130_fd_sc_hd__a21o_2 _088_ (.A1(_024_),
    .A2(_027_),
    .B1(_025_),
    .X(_036_));
 sky130_fd_sc_hd__xnor2_2 _089_ (.A(_035_),
    .B(_036_),
    .Y(_037_));
 sky130_fd_sc_hd__or2_2 _090_ (.A(_032_),
    .B(_037_),
    .X(_038_));
 sky130_fd_sc_hd__nand2_2 _091_ (.A(_032_),
    .B(_037_),
    .Y(_039_));
 sky130_fd_sc_hd__nand2_2 _092_ (.A(_038_),
    .B(_039_),
    .Y(_040_));
 sky130_fd_sc_hd__a21o_2 _093_ (.A1(_019_),
    .A2(_030_),
    .B1(_029_),
    .X(_041_));
 sky130_fd_sc_hd__xnor2_2 _094_ (.A(_040_),
    .B(_041_),
    .Y(\FA10.sum ));
 sky130_fd_sc_hd__a31o_2 _095_ (.A1(\b_reg[2] ),
    .A2(\a_reg[3] ),
    .A3(_036_),
    .B1(_033_),
    .X(_042_));
 sky130_fd_sc_hd__a21bo_2 _096_ (.A1(_038_),
    .A2(_041_),
    .B1_N(_039_),
    .X(_043_));
 sky130_fd_sc_hd__and3_2 _097_ (.A(\b_reg[3] ),
    .B(\a_reg[3] ),
    .C(_042_),
    .X(_044_));
 sky130_fd_sc_hd__a31o_2 _098_ (.A1(\b_reg[3] ),
    .A2(\a_reg[3] ),
    .A3(_043_),
    .B1(_044_),
    .X(\FA11.cout ));
 sky130_fd_sc_hd__a21oi_2 _099_ (.A1(\b_reg[3] ),
    .A2(\a_reg[3] ),
    .B1(_042_),
    .Y(_045_));
 sky130_fd_sc_hd__or2_2 _100_ (.A(_044_),
    .B(_045_),
    .X(_046_));
 sky130_fd_sc_hd__xnor2_2 _101_ (.A(_043_),
    .B(_046_),
    .Y(\FA11.sum ));
 sky130_fd_sc_hd__dfrtp_2 _102_ (.CLK(clk),
    .D(\pp0[0] ),
    .RESET_B(rst_n),
    .Q(p[0]));
 sky130_fd_sc_hd__dfrtp_2 _103_ (.CLK(clk),
    .D(\FA0.sum ),
    .RESET_B(rst_n),
    .Q(p[1]));
 sky130_fd_sc_hd__dfrtp_2 _104_ (.CLK(clk),
    .D(\FA4.sum ),
    .RESET_B(rst_n),
    .Q(p[2]));
 sky130_fd_sc_hd__dfrtp_2 _105_ (.CLK(clk),
    .D(\FA8.sum ),
    .RESET_B(rst_n),
    .Q(p[3]));
 sky130_fd_sc_hd__dfrtp_2 _106_ (.CLK(clk),
    .D(\FA9.sum ),
    .RESET_B(rst_n),
    .Q(p[4]));
 sky130_fd_sc_hd__dfrtp_2 _107_ (.CLK(clk),
    .D(\FA10.sum ),
    .RESET_B(rst_n),
    .Q(p[5]));
 sky130_fd_sc_hd__dfrtp_2 _108_ (.CLK(clk),
    .D(\FA11.sum ),
    .RESET_B(rst_n),
    .Q(p[6]));
 sky130_fd_sc_hd__dfrtp_2 _109_ (.CLK(clk),
    .D(\FA11.cout ),
    .RESET_B(rst_n),
    .Q(p[7]));
 sky130_fd_sc_hd__dfrtp_2 _110_ (.CLK(clk),
    .D(a[0]),
    .RESET_B(rst_n),
    .Q(\a_reg[0] ));
 sky130_fd_sc_hd__dfrtp_2 _111_ (.CLK(clk),
    .D(a[1]),
    .RESET_B(rst_n),
    .Q(\a_reg[1] ));
 sky130_fd_sc_hd__dfrtp_2 _112_ (.CLK(clk),
    .D(a[2]),
    .RESET_B(rst_n),
    .Q(\a_reg[2] ));
 sky130_fd_sc_hd__dfrtp_2 _113_ (.CLK(clk),
    .D(a[3]),
    .RESET_B(rst_n),
    .Q(\a_reg[3] ));
 sky130_fd_sc_hd__dfrtp_2 _114_ (.CLK(clk),
    .D(b[0]),
    .RESET_B(rst_n),
    .Q(\b_reg[0] ));
 sky130_fd_sc_hd__dfrtp_2 _115_ (.CLK(clk),
    .D(b[1]),
    .RESET_B(rst_n),
    .Q(\b_reg[1] ));
 sky130_fd_sc_hd__dfrtp_2 _116_ (.CLK(clk),
    .D(b[2]),
    .RESET_B(rst_n),
    .Q(\b_reg[2] ));
 sky130_fd_sc_hd__dfrtp_2 _117_ (.CLK(clk),
    .D(b[3]),
    .RESET_B(rst_n),
    .Q(\b_reg[3] ));
endmodule
