function [out] = relu(in)
    % relu activation
    out = in;
    out(out <= 0) = 0;
    thresh = 2^-5;
    out(out >= thresh) = thresh;
    
