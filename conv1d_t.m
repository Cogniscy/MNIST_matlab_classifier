function result = conv1d_t(input_array,bias, kernel_raw, chan_prev,...
                            next_layer_channels, num)
%% Операция свертки с вектором (по сути скалярное перемножение со 
%  скользящим вектором)

[n,m,k] = size(input_array);
% Меняем форму массива и производим перевод в инт 
%kernel_channel = reshape_python(kernel_raw,...
                                   % [chan_prev, next_layer_channels]);
 kernel_channel = reshape(kernel_raw,...
                                     [chan_prev, next_layer_channels]);
result = zeros(n,m,next_layer_channels);


% % "Смешиваем" веса с весами BN
% for i = 1 : next_layer_channels 
%     % Цикл вводится из-за того, что я случайно пропустил одну операцию BN при
%     % составлении архитектуры, возможно добавим
%     if num == 15
%         bias_m = clipper_fixedpoint(bias,8);
%     elseif num == 16
%         [A,B] = batch_norm_weight(15);
% 
%         
%         bias_m(i) = clipper_fixedpoint(bias(i),8) + round(B(i));
%         kernel_channel(:,i) = kernel_channel(:,i)*A(i); 
%     elseif num == 17
%         [A,B] = batch_norm_weight(16);
% 
%         
%         bias_m(i) = clipper_fixedpoint(bias(i),8) + round(B(i));
%         kernel_channel(:,i) = kernel_channel(:,i)*A(i); 
%     else
%         [A,B] = batch_norm_weight(num);
% 
%         bias_m(i) = clipper_fixedpoint(bias(i),8) + round(B(i));
%         kernel_channel(:,i) = kernel_channel(:,i)*A(i); 
%     end
% end
% kernel_channel(kernel_channel > 2^7 - 1) = 2^7 - 1;
% kernel_channel(kernel_channel < -2^7) = -2^7;
% % Здесь можно ставить точку останова и выгружать веса векторов для свертки 
% % kernel_channel и смещения bias_m
% % подготавливаем ядра для FPGA
% kc_size = size(kernel_channel);
% all_size = prod(prod(prod(kc_size)));
% fileID = fopen(['FPGA_kernels/conv_vect' num2str(num-1) '.txt'],'w');
% for fk1=1:kc_size(1)
%     for fk2=1:kc_size(2)
%         fprintf(fileID,'%02X\n',Dop_code(kernel_channel(fk1,fk2), 8, 0));
% %        kernel_channel(fk1,fk2)
%     end
% end
% fclose(fileID);
% b_size = size(bias_m);
% fileID = fopen(['FPGA_kernels/bias_' num2str(num-1) '.txt'],'w');
% for fk3=1:b_size(2)
%     fprintf(fileID,'%06X\n',int32(Dop_code(bias_m(fk3),24, 0)));   
%     %fprintf(fileID,'%06X\n',Dop_code(bias_m(fk3),24, 0));    
%     %fprintf('%06X\n',Dop_code(bias_m(fk3),24, 0));  
% end
% fclose(fileID);
% Сама операция свертки
for i = 1 : n
    for j = 1 : m 
        for j4 = 1 : next_layer_channels
            for kk = 1 : k
            result(i,j,j4) = result(i,j,j4) + (input_array(i,j,kk).*...
                            kernel_channel(kk,j4));
            end
            result(i,j,j4) = result(i,j,j4) + bias(j4);
        end
    end
end


