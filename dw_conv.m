function result = dw_conv(input_array,num, next_layer_channels)
% deepwise separable conv
fileID = fopen(['depthwise' num2str(num) '.weight.txt'],'r');
formatSpec = '%f';
kernel_raw = fscanf(fileID, formatSpec);
fclose(fileID);
result = conv2d_t(input_array, kernel_raw, next_layer_channels,num);