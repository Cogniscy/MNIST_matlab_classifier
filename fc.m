function result = fc(input_array, name, num_prev, chan_out)
% Полносвязный слой


fileID = fopen(['fc' num2str(name) '._packed_params.weight.txt'],'r');
formatSpec = '%f';
kernel_raw = fscanf(fileID,formatSpec);
fclose(fileID);

fileID = fopen(['fc' num2str(name) '._packed_params.bias.txt'],'r');
formatSpec = '%f';
bias = fscanf(fileID,formatSpec);
fclose(fileID);

for j = 1 : num_prev
    for i = 1 : chan_out
        mat(j,i) = kernel_raw(j + (i-1)*num_prev);
        
    end
end

result = input_array*mat + bias';