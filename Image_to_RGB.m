function [Image_R, Image_G, Image_B, Image_data] = Image_to_RGB(Image_data)
%   Transform Image_data to RGB data in every single channel
Image_data = im2double(Image_data);
Image_R = (Image_data(:,:,1));
Image_G = (Image_data(:,:,2));
Image_B = (Image_data(:,:,3));
end

