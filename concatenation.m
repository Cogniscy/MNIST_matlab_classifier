function outputArr = concatenation(inputArr1,inputArr2)
%CONCATENATION Summary of this function goes here
%   Detailed explanation goes here
[n_1,m_1,k_1] = size(inputArr1);
[~,~,k_2] = size(inputArr2);

outputArr = zeros(n_1, m_1, k_1 + k_2);
outputArr(:,:,1 : k_1) = inputArr1;
outputArr(:,:, k_1 + 1 : k_1 + k_2) = inputArr2;
% outputArr(:,:,1 : k_1) = inputArr2;
% outputArr(:,:, k_1 + 1 : k_1 + k_2) = inputArr1;


