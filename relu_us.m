function [out] = relu_us(in)
    % relu activation 
    %out = fix(in/2^(30));
    out = in;
    out(out <= 0) = 0;
    
%     thresh = 2^7;
%     out(out >= thresh) = thresh;
    
    %out(out>thresh-1) = thresh-1;
    %out(out<-thresh) = -thresh;
