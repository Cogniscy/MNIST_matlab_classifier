function res = flatten(inp)

[n,m,k] = size(inp);
c = 1;
for i = 1 : n
    for j = 1: m
        for b = 1 : k
            res(c) = inp(i,j,b);
            c = c + 1;
            
        end
    end
end
