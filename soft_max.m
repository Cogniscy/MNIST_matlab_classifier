function res = soft_max(inp)

sup = exp(inp);
res = sup/sum(sup);
