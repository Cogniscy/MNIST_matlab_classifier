function [result] = vect_conv(input_array, chan_prev, chan_out, num)
% vectorwise conv along channels
fileID = fopen(['pointwise' num2str(num) '.weight.txt'],'r');
formatSpec = '%f';
kernel_raw = fscanf(fileID,formatSpec);
fclose(fileID);

fileID = fopen(['pointwise' num2str(num) '.bias.txt'],'r');
formatSpec = '%f';
bias = fscanf(fileID,formatSpec);
fclose(fileID);
result = conv1d_t(input_array,bias, kernel_raw,chan_prev, chan_out,num);




