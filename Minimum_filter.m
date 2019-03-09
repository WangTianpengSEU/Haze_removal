function [Dark_channel_image_original] = Minimum_filter(Single_channel_data, Scale_X)
%   Product the original dark channel image

Dark_channel_image_original = zeros(size(Single_channel_data));
X = size(Single_channel_data,2);
Y = size(Single_channel_data,1);
X_times = floor(X/Scale_X);    
Y_times = floor(Y/Scale_X);
min_matrix = size(Y_times+1, X_times+1);



for i = 1:(X_times+1)
    for j = 1:(Y_times+1)
        if(i == (X_times+1) && j < (Y_times+1))
            min_matrix(j, i) = min(min(Single_channel_data(((j-1)*Scale_X+1):j*Scale_X, X_times*Scale_X:X)));
        elseif(j == (Y_times+1) && i < (X_times+1))
            min_matrix(j, i) = min(min(Single_channel_data(Y_times*Scale_X:Y, ((i-1)*Scale_X+1):i*Scale_X)));
        elseif(i == (X_times+1) && j == (Y_times+1))
            min_matrix(j, i) = min(min(Single_channel_data(Y_times*Scale_X:Y, X_times*Scale_X:X)));
        else
            min_matrix(j, i) = min(min(Single_channel_data(((j-1)*Scale_X+1):j*Scale_X, ((i-1)*Scale_X+1):i*Scale_X)));
        end
    end
end

for i = 1:X
    for j = 1:Y
        Dark_channel_image_original(j, i) = min_matrix(floor(j/Scale_X)+1, floor(i/Scale_X)+1);
    end
end


end

