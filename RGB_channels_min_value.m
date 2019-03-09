function [Min_data] = RGB_channels_min_value(R, G, B)
%   Output the min value of RGB channels.

Size_X = size(R, 2);
Size_Y = size(R, 1);
Min_data = zeros(size(R));

for i = 1:Size_X
    for j = 1:Size_Y
        Min_data(j, i) = min([R(j, i), G(j, i), B(j, i)]);
%         Min_data(j, i) = R(j, i);
    end
end


end

