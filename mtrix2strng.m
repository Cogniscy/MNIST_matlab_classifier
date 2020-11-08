function outputStrng = mtrix2strng(inputArr,postfix)
inputArr_size = size(inputArr);
cnt = 1;
for j=1:1:inputArr_size(2)
	for k=1:1:inputArr_size(1)
        for i=1:1:inputArr_size(3)   
            outputStrng(cnt) = inputArr(j,k,i);
            cnt = cnt + 1;
        end
    end
end

my_file = fopen(strcat('fpga_input_',postfix,'.txt'),'w');
outputStrng_size = size(outputStrng);
for i=1:1:outputStrng_size(2)
    fprintf(my_file,'%x\n',Dop_code(outputStrng(i), 8, 0));
end
fclose(my_file);