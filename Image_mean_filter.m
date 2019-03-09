function [ output_image ] = Image_mean_filter( Input_image, Windows_size )
%   Calculate the mean value in every window of the input image.
%   Return the Filtered image which have the same size of input image.
%   Notice that the distance the window moves is one pixel at a time.

Input_image = im2double(Input_image);
width = size(Input_image, 2);
height = size(Input_image, 1);
output_image = zeros(size(Input_image));
Sum_accumulate = zeros(size(Input_image));
r = floor((Windows_size-1)/2);

for j = 1:height
    Sum_accumulate(j, :) = cumsum(Input_image(j, :));
end

for i = 1:width
    Sum_accumulate(:, i) = cumsum(Sum_accumulate(:, i), 1);
end

for j = 1:height
    for i = 1:width
        if(j > r+1 && j < (height-r-1) && i > r+1 && i < (width-r-1))
            output_image(j, i) = ...
                ( Sum_accumulate(j+r, i+r) - ...
                  Sum_accumulate(j-r-1, i+r) - ...
                  Sum_accumulate(j+r, i-r-1) + ...
                  Sum_accumulate(j-r-1, i-r-1) )/(Windows_size * Windows_size);
        elseif(j < (height-r-1) && i < (width-r-1))
            output_image(j, i) = ...
                ( Sum_accumulate(j+r, i+r) - ...
                  Sum_accumulate(j, i+r) - ...
                  Sum_accumulate(j+r, i) + ...
                  Sum_accumulate(j, i) )/(r * r);
        elseif(j > r+1 && i > r+1)
            output_image(j, i) = ...
                ( Sum_accumulate(j, i) - ...
                  Sum_accumulate(j, i-r) - ...
                  Sum_accumulate(j-r, i) + ...
                  Sum_accumulate(j-r, i-r) )/(r * r);
        else
           output_image(j, i) = Input_image(j, i);  
           % Ignore the two square area of diagonal. (size (r+1)*(r+1))
        end
    end
end

end

