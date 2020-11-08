function result = conv2d_t(input_array, kernel_raw, next_layer_channels,num)
    % Операция свертки по слоям
    % Размер ядра свертки
    kernel_size = [3 3];
    % Изменение формы и перевод в int8 ядер свертки, после этого их можно
    % загружать
    %kernel_space = reshape_python(kernel_raw, [3,3,next_layer_channels]);
    kernel_space = permute(reshape(kernel_raw, [3,3,next_layer_channels]), [2,1,3]);
    %kernel_space = reshape(kernel_raw, [3,3,next_layer_channels]);
% %%
% fileID = fopen(['FPGA_kernels/conv2' num2str(num-1) '.txt'],'w');
% %fprintf(fileID,'test %x\n');
% ks_size = size(kernel_space);
% for k = 1:1:ks_size(3)
%     fprintf(fileID,'%02X_%02X_%02X_%02X_%02X_%02X_%02X_%02X_%02X\n',...
%         Dop_code(kernel_space(1,1,k), 8, 0),Dop_code(kernel_space(1,2,k), 8, 0),Dop_code(kernel_space(1,3,k), 8, 0),...
%     Dop_code(kernel_space(2,1,k), 8, 0),Dop_code(kernel_space(2,2,k), 8, 0),Dop_code(kernel_space(2,3,k), 8, 0),...
%     Dop_code(kernel_space(3,1,k), 8, 0),Dop_code(kernel_space(3,2,k), 8, 0),Dop_code(kernel_space(3,3,k), 8, 0));
% end
% fclose(fileID);
%% 
    
    % Суммарное заполнение нулями сбоку
    padding = 1;

    [n,m,k] = size(input_array);
    result = (zeros(n+padding*2,m+padding*2,next_layer_channels));
    sub_inp = result;
    sub_inp(2:end-1, 2:end-1,:) = input_array;
    for kk = 1 : next_layer_channels
        for i = 1 : n 
            for j = 1 : m 
                for i1 = 1 : kernel_size(1)
                    for i2 = 1 : kernel_size(2)
                        result(i,j,kk) = result(i,j,kk) + ...
                            sub_inp(i + i1 - 1,j + i2 - 1,kk)*...
                            kernel_space(i1,i2,kk);              
                    end
                end
            end
        end
    end

    result = result(1:end - kernel_size(1) + 1, 1:end - kernel_size(2) +1,:);
