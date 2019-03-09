function [ Mean_image ] = Rough_Image_mean( Input_image, Windows_size )
%   Calculate the mean value in every window of the input image.
%   Return the Filtered image which have the same size of input image.
%   Notice that every window is not overlapping.

Input_image = im2double(Input_image);
width = size(Input_image, 2);
height = size(Input_image, 1);
Row_windows = floor(width/Windows_size);
Column_windows = floor(height/Windows_size);
Mean_data = zeros(Column_windows+1, Row_windows+1);
Mean_image = zeros(size(Input_image));

index_i = 1;
index_j = 1;
Times = 0;

for index_i = 1:Row_windows
    for index_j = 1:Column_windows
        for i = ((index_i-1)*Windows_size + 1):(index_i*Windows_size)
            for j = ((index_j-1)*Windows_size + 1):(index_j*Windows_size)
                Mean_data(index_j, index_i) = Mean_data(index_j, index_i) + Input_image(j, i);
            end
        end
    end
end
Mean_data(1:Column_windows, 1:Row_windows) = ...
    Mean_data(1:Column_windows, 1:Row_windows) .* ...
    ones(Column_windows, Row_windows) / (Windows_size*Windows_size);

for index_i = 1:Row_windows
    for i = ((index_i-1)*Windows_size + 1):(index_i*Windows_size)
        for j = (index_j*Windows_size):height
            Times = Times + 1;
            Mean_data(Column_windows+1, index_i) = Mean_data(Column_windows+1, index_i) + Input_image(j, i);
        end
    end
    Mean_data(Column_windows+1, 1:Row_windows) = ...
        Mean_data(Column_windows+1, 1:Row_windows) .* ...
        ones(1, Row_windows) / Times;
    Times = 0;
end

for index_j = 1:Column_windows
    for i = (index_i*Windows_size):width
        for j = ((index_j-1)*Windows_size + 1):(index_j*Windows_size)
            Times = Times + 1;
            Mean_data(index_j, Row_windows+1) = Mean_data(index_j, Row_windows+1) + Input_image(j, i);
        end
    end
    Mean_data(1:Column_windows, Row_windows+1) = ...
        Mean_data(1:Column_windows, Row_windows+1) .* ...
        ones(Column_windows, 1) / Times;
    Times = 0;
end

for i = (index_i*Windows_size):width
    for j = (index_j*Windows_size):height
        Times = Times + 1;
        Mean_data(Column_windows+1 , Row_windows+1) = Mean_data(Column_windows+1 , Row_windows+1) + Input_image(j, i);
    end
end
Mean_data(Column_windows+1 , Row_windows+1) = ...
    Mean_data(Column_windows+1 , Row_windows+1) .* ...
    ones(1, 1) / Times;

for i = 1:width
    for j = 1:height
        Mean_image(j, i) = Mean_data(floor(j/Windows_size)+1, floor(i/Windows_size)+1);
    end
end
        
imshow(Mean_image);  

            
            

end

