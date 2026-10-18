module four_bit_adder(input wire [3:0] a,input wire [3:0] b, input cin,output wire [3:0] s,output wire cout);
        wire c1,c2,c3;
        full_adder FA0(.a(a[0]),.b(b[0]),.cin(cin),.sum(s[0]),.cout(c1));
        full_adder FA1(.a(a[1]),.b(b[1]),.cin(c1),.sum(s[1]),.cout(c2));
	full_adder FA2(.a(a[2]),.b(b[2]),.cin(c2),.sum(s[2]),.cout(c3));
	full_adder FA3(.a(a[3]),.b(b[3]),.cin(c3),.sum(s[3]),.cout(cout));
endmodule

