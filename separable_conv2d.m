function result = separable_conv2d(input_array, name, num_prev, chan_out)
% ����������� ������ �� ����� � ������� � ��������

% ������� �� ����� - deepwise
result_int = dw_conv(input_array,name, num_prev);
% ������� � ��������
result = vect_conv(result_int, num_prev, chan_out, name);
