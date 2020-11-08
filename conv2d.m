function result = conv2d_t(input_array, kernel_raw, next_layer_channels)
    kernel_size = [3 3];
    kernel_space = reshape(kernel_raw, [3,3,next_layer_channels]);
    padding = 2;
    [n,m,k] = size(input_array);
    result = zeros(n+padding,m+padding,next_layer_channels);
    sub_inp = result;
    sub_inp(2:end-1, 2:end-1,:) = input_array;
    for i = 2 : n+ 1
        for j = 2 : m + 1
            for i1 = 1 : kernel_size(1)
                for i2 = 1 : kernel_size(2)
                    result(i,j,:) = result(i,j,:) + ...
                        sub_inp(i - 2 + i1,j -2 + i2,:)*...
                        kernel_space(i1,i2);              
                end
            end
        end
    end
    result = result(2:end-1, 2:end-1,:);