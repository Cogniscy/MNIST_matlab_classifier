function result = separable_conv2d(input_array, name, num_prev, chan_out)
% Совмещенные сверка по слоям и свертка с вектором

% Свертка по слоям - deepwise
result_int = dw_conv(input_array,name, num_prev);
% Свертка с вектором
result = vect_conv(result_int, num_prev, chan_out, name);
