function [A,B] = batch_norm_weight(num)
fileID = fopen(['batch_normalization_' num2str(num) '_beta_0.txt'],'r');
formatSpec = '%f';
beta = fscanf(fileID,formatSpec);
fclose(fileID);
epsilon = 0.0001;
fileID = fopen(['batch_normalization_' num2str(num) '_gamma_0.txt'],'r');
formatSpec = '%f';
gamma = fscanf(fileID,formatSpec);
fclose(fileID);

signed = 1;
word_length = 8;
frac_length = 3;
oa = 'Saturate';
rm = 'Floor';
q = fixed.Quantizer(signed,word_length,frac_length,rm,oa);


fileID = fopen(['batch_normalization_' num2str(num) '_moving_mean_0.txt'],'r');
formatSpec = '%f';
mean_m = fscanf(fileID,formatSpec);
fclose(fileID);

fileID = fopen(['batch_normalization_' num2str(num) '_moving_variance_0.txt'],'r');
formatSpec = '%f';
var_mean = fscanf(fileID,formatSpec);
fclose(fileID);

for i = 1 : length(mean_m)
    A(i)  = (gamma(i))/sqrt(var_mean(i) + epsilon);
    B(i) = -mean_m(i)*gamma(i)/sqrt(var_mean(i) + epsilon) + beta(i);
end

A = clipper_fixedpoint(A,7-4);
B = clipper_fixedpoint(B,11+12-4);
