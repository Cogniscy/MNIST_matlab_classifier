function result = reshape_python(input_array, size)


if numel(size) == 2
    result = zeros(size(1),size(2));
    for i = 1 : size(1)
        for j = 1 : size(2)
            result(i,j) = input_array((i - 1)*size(2) + j);
        end
    end
elseif numel(size) == 3
    result = zeros(size(1),size(2),size(3));
    for i = 1 : size(1)
        for j = 1 : size(2)
            for k = 1 : size(3)
                result(i,j,k) = input_array((i - 1)*size(2)*size(3) + (j-1)*size(3)+ k);
            end
        end
    end
end