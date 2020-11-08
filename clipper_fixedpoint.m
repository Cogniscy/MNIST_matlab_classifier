function out = clipper_fixedpoint(input, frac_length)

common_mult = 2^frac_length;

out = round(input*common_mult);
% out(out>2^frac_length -1 ) = 2^frac_length -1;
% out(out<-2^frac_length) = -2^frac_length;
