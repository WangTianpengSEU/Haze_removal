function [Atmosphere_value] = Atmosphere_estimate(Dark_channel_image_original)
%   Estimate the Atmosphere value of the image

X = size(Dark_channel_image_original, 2);
Y = size(Dark_channel_image_original, 1);

A = Dark_channel_image_original(:);
upsize = 1;
A = A(1:upsize:end);
Sum = 0;
Num = 1000;                      % pay attention to this parameter, try 10 and 1000;
Num_calculate = floor(X*Y/(upsize*upsize*Num));  % This step desides the calculated number in the Dark channel image;

for i = 1:Num_calculate
    [p, Index] = max(A);
    Sum = Sum + p;
    A(Index) = 0;
end

Atmosphere_value = Sum/Num_calculate;

end

