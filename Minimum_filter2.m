function [ Minimum_image ] = Minimum_filter2( Single_channel_data, Minimum_size )
%   Get the minimum value in the windows, and The distance the window moves is one pixel at a time.

width = size(Single_channel_data, 2);
height = size(Single_channel_data, 1);
Minimum_image = zeros(size(Single_channel_data));
r = floor((Minimum_size-1)/2);

for j = 1:height
    for i = 1:width
        if(i > r && i < (width-r+1) && j > r && j < (height-r+1))
            Minimum_image(j, i) = min(min(Single_channel_data(j-r:j+r, i-r:i+r)));
        elseif(i < (width-r+1) && j < (height-r+1))
            Minimum_image(j, i) = min(min(Single_channel_data(j:j+r, i:i+r)));
        elseif(i > r && j > r)
            Minimum_image(j, i) = min(min(Single_channel_data(j-r:j, i-r:i)));
        elseif(i > (width-r))
            Minimum_image(j, i) = min(min(Single_channel_data(1:r, (width-r):width)));
        else
            Minimum_image(j, i) = min(min(Single_channel_data((height-r):height, i:r)));
        end
    end
end
            
            
        

end

