function [result] = maxpool(inputArray,stride)
%MAXPOOL layer
% TODO add case for odd number of input array dimensions

[n,m,k] = size(inputArray);
result = zeros(floor((n)/stride(1)),floor((m)/stride(1)),k);
for kk = 1 : k
    for i = 1 : floor((n)/stride(1))
        for j = 1 : floor((m)/stride(1))
            supp = -inf;
            for i1 = 1 : stride(1)
                for i2 = 1 : stride(2)
                    if inputArray((i-1)*stride(1) + i1,(j-1)*stride(2) + i2,kk) > supp
                        supp = inputArray((i-1)*stride(1) + i1,(j-1)*stride(2) + i2,kk);  
                    end    
                end
            end
            result(i,j,kk) = supp;
        end
    end
end
rrr=7;
