function [result] = upsampling(inputArray,stride)
%Upsampling by bilinear inerpolation


[n,m,k] = size(inputArray);
result = zeros(round(n*stride(1)),round(m*stride(2)),k);
for kk = 1 : k
    for i = 1 : n
        for j = 1 : m
            for i_s = 1 : stride(1)
               for j_s = 1 : stride(2) 
                   result((i-1)*stride(1) + i_s , (j-1)*stride(2) + j_s,kk) = ...
                       inputArray(i, j, kk);
               end
            end
        end
    end
end

% % 
% % 
% % %// Get some necessary variables first
% % [in_rows, in_cols] = size(inputArray);
% % result_rows = in_rows * stride(1);
% % result_cols = in_cols * stride(1);
% % %     %// Let S_R = R / R'        
% % %     S_R = in_rows / result_rows;
% % %     %// Let S_C = C / C'
% % %     S_C = in_cols / result_cols;
% % %// Define grid of co-ordinates in our inputArrayage
% % %// Generate (x,y) pairs for each point in our inputArrayage
% % [cf, rf] = meshgrid(1 : result_cols, 1 : result_rows);
% % %// Let r_f = r'*S_R for r = 1,...,R'
% % %// Let c_f = c'*S_C for c = 1,...,C'
% % cf = cf / stride(1);
% % rf = rf / stride(1);
% % %// Let r = floor(rf) and c = floor(cf)
% % c = floor(cf);
% % r = floor(rf);
% % %// Any values result of range, cap
% % r(r < 1) = 1;
% % c(c < 1) = 1;
% % r(r > in_rows - 1) = in_rows - 1;
% % c(c > in_cols - 1) = in_cols - 1;
% % %// Let delta_R = rf - r and delta_C = cf - c
% % delta_R =  rf - r;
% % delta_C =  cf - c;
% % %// Final line of algorithm
% % %// Get column major indices for each point we wish
% % %// to access
% % in1_ind = sub2ind([in_rows, in_cols], r, c);
% % in2_ind = sub2ind([in_rows, in_cols], r+1,c);
% % in3_ind = sub2ind([in_rows, in_cols], r, c+1);
% % in4_ind = sub2ind([in_rows, in_cols], r+1, c+1);       
% % %// Now interpolate
% % %// Go through each channel for the case of colour
% % %// Create resultput inputArrayage that is the same class as input
% % result = zeros(result_rows, result_cols, size(inputArray, 3));
% % %     result = cast(result, class(inputArray));
% % result = cast(result, 'like', inputArray);
% % for idx = 1 : size(inputArray, 3)
% %   chan = double(inputArray(:,:,idx)); %// Get i'th channel
% %   %// Interpolate the channel
% %   tmp = chan(in1_ind).*(1 - delta_R).*(1 - delta_C) + ...
% %                  chan(in2_ind).*(delta_R).*(1 - delta_C) + ...
% %                  chan(in3_ind).*(1 - delta_R).*(delta_C) + ...
% %                  chan(in4_ind).*(delta_R).*(delta_C);
% %   result(:,:,idx) = cast(tmp,'like',inputArray);
% % end

% % for i = 1 : round((n)*stride(1))
% %     for j = 1 : round((m)*stride(1))
% %         if i > round((n)*stride(1))/2   && j > round((n)*stride(1))/2 
% %             if rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) == 0
% %                 result(i+1,j+1,:) = inputArray((i-1)/stride(1)+1,(j-1)/stride(2)+1,:);  
% %             elseif rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) ~= 0 &&...
% %                     i > round((n)*stride(1))/2 +1
% %                 result(i,j,:) = (inputArray(round((i-1)/stride(1)),round((j-1)/stride(2)),:) + ...
% %                                     inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2)),:))/2;
% %             elseif rem((i-1),stride(1)) ~=0 && rem((j-1),stride(2)) == 0 &&...
% %                     j > round((n)*stride(1))/2 +1
% %                 result(i,j,:) = (inputArray(round((i-1)/stride(1)),round((j-1)/stride(2))+1,:) + ...
% %                                     inputArray(round((i-1)/stride(1)),round((j-1)/stride(2)),:))/2;
% %             end 
% %         elseif i > round((n)*stride(1))/2  && j < round((n)*stride(1))/2 
% %             if rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) == 0
% %                 result(i+1,j,:) = inputArray((i-1)/stride(1)+1,(j-1)/stride(2)+1,:);  
% %             end  
% %         elseif i < round((n)*stride(1))/2  && j > round((n)*stride(1))/2 
% %             if rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) == 0
% %                 result(i,j+1,:) = inputArray((i-1)/stride(1)+1,(j-1)/stride(2)+1,:);  
% %             elseif rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) ~= 0 
% %                 result(i,j,:) = 10*(inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2)),:) + ...
% %                                     inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2)),:))/2;
% %             elseif rem((i-1),stride(1)) ~=0 && rem((j-1),stride(2)) == 0 
% %                 result(i-1,j,:) = (inputArray(round((i-1)/stride(1)),round((j-1)/stride(2))+1,:) + ...
% %                                     inputArray(round((i-1)/stride(1)),round((j-1)/stride(2)),:))/2;
% %             end 
% %         elseif i < round((n)*stride(1))/2   && j < round((n)*stride(1))/2 
% %             if rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) == 0
% %                 result(i,j,:) = inputArray((i-1)/stride(1)+1,(j-1)/stride(2)+1,:);  
% %             elseif rem((i-1),stride(1)) ==0 && rem((j-1),stride(2)) ~= 0 
% %                 result(i,j,:) = (inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2)),:) + ...
% %                                     inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2)+1),:))/2;
% %             elseif rem((i-1),stride(1)) ~=0 && rem((j-1),stride(2)) == 0 
% %                 result(i,j,:) = (inputArray(round((i-1)/stride(1))+0,round((j-1)/stride(2))+1,:) + ...
% %                                     inputArray(round((i-1)/stride(1))+1,round((j-1)/stride(2))+1,:))/2;
% %             end 
% %         end
% %     end
% % end

