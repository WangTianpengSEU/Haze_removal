function [Original_image] = Rebuild_image(Original_image, Transmit_function, Atmosphere_value, t0)
%   Rebuild the image

X = size(Transmit_function,2);
Y = size(Transmit_function,1);

for i = 1:X
    for j = 1:Y
    Transmit_function(j, i) = max(Transmit_function(j, i), t0);
    end
end

for i = 1:3
    if(i == 1)
        k = 1;
    elseif(i == 2)
        k = 1;
    else
        k = 0.9;
    end
    Original_image(:,:,i) = ...
         k * (Atmosphere_value * ones(size(Transmit_function)) + ... 
        (Original_image(:,:,i) - Atmosphere_value * ones(size(Transmit_function))) ./ Transmit_function);
end
figure;
imshow(Original_image);
end

