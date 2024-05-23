module sorting (clk,reset,sortType,load_enable,data_in, data_out);

    parameter m = 15;         //# of inputs (row)
    parameter n = 8;         //bit width for each input (col)


    input clk;
    input reset;
    input sortType;         // 0 for ascending order sorting, 1 for descending order sorting
    input [n-1:0] data_in;
    input load_enable;    // when load_enable=1, load all inputs 1-by-1 into a 2d array, when it is 0, loading finished, can perform sorting algorithm.
    output reg [n-1:0] data_out;

    //reg [n-1:0] data_out;

    reg [n-1:0] reg_in [m-1 :0];       
    reg [n-1:0] reg_out [m-1:0];       

    reg [5:0] addr_in;    //Input register data pointer
    reg [5:0] addr_out;    //Output register data pointer    

    reg data_sorted;    // when data_sorted=1, sorting finished, can output data to register
    reg done;        // finished signal for the whole codes

    reg [4:0]sort_count;    //counting up to max 2^5=32 inputs
    reg [n-1:0] temp;

    integer i,j;


   always @ (posedge clk)begin
       if(reset)begin                //reset
           for(i=0; i<m; i=i+1)
           reg_out[i] <= 8'd0;
           addr_in <=6'd0;
           addr_out <=6'd0;
           data_out<= 8'd0;
           data_sorted<=1'b0;
           done <=1'b0;
           sort_count <=6'd0;
       end
       else if (load_enable)begin        //loading data
           reg_in[addr_in] = data_in;                               //change in here <= or =
           addr_in <= addr_in +1'b1;
           addr_out <= 6'd0;
       end
       else if (!load_enable)begin        //sorting
           if (!sortType)begin         
               //for (j=m-1; j>=1; j=j-1)begin    //looping reduced by 1 cycle
        //if (j<m)
            //if(i<m-2) 
        for (j=0;j<m; j=j+1)begin    
                   for (i=0; i<= m-2; i=i+1)begin
                       if(reg_in[i] > reg_in[i+1])begin      //ascending order sorting                  
                           //reg_in[i] <= reg_in[i+1];    
                           //reg_in[i+1]<= reg_in[i];  
                temp = reg_in[i];
                reg_in[i] = reg_in[i+1];    
                reg_in[i+1] = temp;   
                       end
                   //reg_out[i] <= reg_in[i]; 
                   end
                   sort_count <= sort_count +1'b1;
               end
           end
           else if (sortType)begin
           //for (j=m-1; j>=1; j=j-1)begin    //looping reduced by 1 cycle
        for (j=0;j<m; j=j+1)begin   
                   for (i=0; i<= m-2; i=i+1)begin
                       if(reg_in[i] < reg_in[i+1])begin      //descending order sorting                  
                           //reg_in[i] <= reg_in[i+1];    
                           //reg_in[i+1]<= reg_in[i]; 
                temp = reg_in[i];
                reg_in[i] = reg_in[i+1];    
                reg_in[i+1]= temp;   
                       end
                   //reg_out[i] <= reg_in[i]; 
                   end
                   sort_count <= sort_count +1'b1;
               end
           end
           if( sort_count == (m-1))        //finish sorting, m-1 or 4'b1110
               data_sorted <=1'b1;
               for (i=0;i<m;i=i+1)begin
                   reg_out[i] <= reg_in[i]; 
               end
       end
       if(data_sorted) begin    
           if (addr_out == m)begin        //set done signal
               done <= 1'b1;
               data_out<= reg_out[m-1]; // set output to last sorted value
           end
           else if (!done)begin
               data_out<= reg_out[addr_out];    //output sorted values
                   addr_out <= addr_out + 1'b1;
                   addr_in <= 6'd0;
           end
       end
   end
endmodule