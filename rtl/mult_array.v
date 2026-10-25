module mult_array(input wire clk,input wire rst_n,input wire [3:0] a,input wire [3:0] b,output reg [7:0] p);
        reg [3:0] a_reg;
        reg [3:0] b_reg;
        wire [7:0] prod_comb;
        wire [3:0] pp0,pp1,pp2,pp3,r0,r1,r2,s1,s2,s3;
        wire c1,c2,c3;
	wire cc1,cc2,cc3,cc4,cc5,cc6,cc7,cc8,cc9;

        always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                        a_reg<=4'b0;
                        b_reg<=4'b0;
                end else begin
                        a_reg<=a;
                        b_reg<=b;
                end
        end
        assign pp0 = a_reg & {4{b_reg[0]}};
        assign pp1 = a_reg & {4{b_reg[1]}};
        assign pp2 = a_reg & {4{b_reg[2]}};
        assign pp3 = a_reg & {4{b_reg[3]}};
        
        assign prod_comb[0]=pp0[0];
	assign r0={1'b0,pp0[3],pp0[2],pp0[1]};
	
	full_adder FA0(.a(pp1[0]),.b(r0[0]),.cin(1'b0),.sum(s1[0]),.cout(cc1));
        full_adder FA1(.a(pp1[1]),.b(r0[1]),.cin(cc1),.sum(s1[1]),.cout(cc2));
        full_adder FA2(.a(pp1[2]),.b(r0[2]),.cin(cc2),.sum(s1[2]),.cout(cc3));
        full_adder FA3(.a(pp1[3]),.b(r0[3]),.cin(cc3),.sum(s1[3]),.cout(c1));
	assign prod_comb[1]=s1[0];
	assign r1={c1,s1[3],s1[2],s1[1]};

	
	full_adder FA4(.a(pp2[0]),.b(r1[0]),.cin(1'b0),.sum(s2[0]),.cout(cc4));
        full_adder FA5(.a(pp2[1]),.b(r1[1]),.cin(cc4),.sum(s2[1]),.cout(cc5));
        full_adder FA6(.a(pp2[2]),.b(r1[2]),.cin(cc5),.sum(s2[2]),.cout(cc6));
        full_adder FA7(.a(pp2[3]),.b(r1[3]),.cin(cc6),.sum(s2[3]),.cout(c2));
	assign prod_comb[2]=s2[0];
	assign r2={c2,s2[3],s2[2],s2[1]};
	
	
	full_adder FA8(.a(pp3[0]),.b(r2[0]),.cin(1'b0),.sum(s3[0]),.cout(cc7));
        full_adder FA9(.a(pp3[1]),.b(r2[1]),.cin(cc7),.sum(s3[1]),.cout(cc8));
        full_adder FA10(.a(pp3[2]),.b(r2[2]),.cin(cc8),.sum(s3[2]),.cout(cc9));
        full_adder FA11(.a(pp3[3]),.b(r2[3]),.cin(cc9),.sum(s3[3]),.cout(c3));
	assign prod_comb[7:3]={c3,s3};
	
        always @(posedge clk or negedge rst_n) begin
                if(!rst_n)
                        p<=8'b0;
                else
                        p<=prod_comb;
        end

endmodule

