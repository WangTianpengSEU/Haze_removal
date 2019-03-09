function [Transmit_function] = Transmit_image(Dark_channel_image_original, Atmosphere_value, W)
%   Calculate the Transmit function

X = size(Dark_channel_image_original, 2);
Y = size(Dark_channel_image_original, 1);
Temp = ones(X*Y,1) - (W/Atmosphere_value) * (Dark_channel_image_original(:));

Transmit_function = reshape(Temp, [Y, X]);
end

