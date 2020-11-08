clear;
rng(1);
% INPUT_MTRX_NUM = 3;
% OUTPUT_MTRX_NUM = 16;
% INPUT_MTRX_SIZE = 224;
%%
MAX_POOL_SIZE = 5;
%%
INPUT_MTRX_NUM = 17;
OUTPUT_MTRX_NUM = 2;
INPUT_MTRX_SIZE = 110;
%% 
input = (randi([-127,127],INPUT_MTRX_SIZE,INPUT_MTRX_SIZE,INPUT_MTRX_NUM));
%%
fileID = fopen(['./weights_tmp/weights/separable_conv2d_' num2str(1) '_depthwise_kernel_0.txt'],'w');
    for i=1:1:INPUT_MTRX_NUM*9
        fprintf(fileID,'%d\n',rand()-rand());
    end
fclose(fileID);

fileID = fopen(['./weights_tmp/weights/separable_conv2d_' num2str(1) '_pointwise_kernel_0.txt'],'w');
    for i=1:1:INPUT_MTRX_NUM*OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',rand()-rand());
    end
fclose(fileID);

fileID = fopen(['./weights_tmp/weights/separable_conv2d_' num2str(1) '_bias_0.txt'],'w');
    for i=1:1:OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',(rand()-rand()));
    end
fileID = fopen(['./weights_tmp/weights/batch_normalization_' num2str(1) '_beta_0.txt'],'w');
    for i=1:1:OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',(rand()-rand()));
    end

    fileID = fopen(['./weights_tmp/weights/batch_normalization_' num2str(1) '_gamma_0.txt'],'w');
    for i=1:1:OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',(rand()-rand()));
    end
fileID = fopen(['./weights_tmp/weights/batch_normalization_' num2str(1) '_moving_mean_0.txt'],'w');
    for i=1:1:OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',(rand()-rand()));
    end
fileID = fopen(['./weights_tmp/weights/batch_normalization_' num2str(1) '_moving_variance_0.txt'],'w');
    for i=1:1:OUTPUT_MTRX_NUM
        fprintf(fileID,'%d\n',(rand()));
    end    

fclose(fileID);

%% %fpga params
fileID = fopen(['./FPGA_input/fpga_params.txt'],'w');
fprintf(fileID,'%X\n',INPUT_MTRX_NUM);      
fprintf(fileID,'%X\n',OUTPUT_MTRX_NUM);     
fprintf(fileID,'%X\n',INPUT_MTRX_SIZE);     
fclose(fileID);

%%
sep_conv = separable_conv2d(input,1,INPUT_MTRX_NUM,OUTPUT_MTRX_NUM);
relu = relu_us(sep_conv);
maxpooling = maxpool(relu,[MAX_POOL_SIZE,MAX_POOL_SIZE]);
%% %fpga input
tmp = 1;
input_size = size(input);
fileID = fopen(['./FPGA_input/fpga_input.txt'],'w');
for i=1:1:input_size(1)
    for j=1:1:input_size(2)
        for k=1:1:input_size(3)
            fpga_input(tmp) = input(i,j,k);
            fprintf(fileID,'%X\n',Dop_code(fpga_input(tmp), 8, 0));            
            tmp = tmp + 1;
        end
    end
end
fclose(fileID);
%% %fpga output
tmp = 1;
output_size = size(sep_conv);
fileID = fopen(['./FPGA_input/model_output.txt'],'w');
fileID_relu = fopen(['./FPGA_input/model_output_relu.txt'],'w');
for i=1:1:output_size(1)
    for j=1:1:output_size(2)
        for k=1:1:output_size(3)
            fpga_output(tmp) = sep_conv(i,j,k);
            %fprintf(fileID,'%X\n',Dop_code(fpga_output(tmp), 40, 0));
            fprintf(fileID,'%X\n',Dop_code(sep_conv(i,j,k), 40, 0));
            fprintf(fileID_relu,'%X\n',Dop_code(relu(i,j,k), 40, 0));
            tmp = tmp + 1;
        end
    end
end
fclose(fileID);
fclose(fileID_relu);

fileID = fopen(['./FPGA_input/model_output_max_pool.txt'],'w');
output_size = size(maxpooling);
for i=1:1:output_size(1)
    for j=1:1:output_size(2)
        for k=1:1:output_size(3)
            fprintf(fileID,'%X\n',Dop_code(maxpooling(i,j,k), 40, 0));
            tmp = tmp + 1;
        end
    end
end
fclose(fileID);
%% %fpga params
fileID = fopen(['./FPGA_input/fpga_params.svh'],'w');
fprintf(fileID,'parameter INPUT_DATA_LEN = %d;\n',INPUT_MTRX_SIZE*INPUT_MTRX_SIZE*INPUT_MTRX_NUM);      
fprintf(fileID,'parameter STRING2MATRIX_STRING_LEN = %d;\n',INPUT_MTRX_SIZE);     
fprintf(fileID,'parameter OUTPUT_DATA_LEN = %d;\n',INPUT_MTRX_SIZE*INPUT_MTRX_SIZE*OUTPUT_MTRX_NUM);
fprintf(fileID,'parameter INPUT_MTRX_NUM = %d;\n',INPUT_MTRX_NUM);  
fprintf(fileID,'parameter OUTPUT_MTRX_NUM = %d;\n',OUTPUT_MTRX_NUM); 
fprintf(fileID,'parameter INP_DELAY = %d;\n',INPUT_MTRX_NUM*OUTPUT_MTRX_NUM);  
fprintf(fileID,'parameter MAX_POOL_SIZE = %d;\n',MAX_POOL_SIZE);  
fclose(fileID);
