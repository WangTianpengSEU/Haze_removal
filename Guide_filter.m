function [ Out_image ] = Guide_filter( Guide_image, Pending_image, radius, lamta )
%   The guided filter theory is introduced by He Kaiming in <<Guided Image Filtering>>
%   This program used his algorithm.

mean_of_Guide_image = Image_mean_filter(Guide_image, radius);
mean_of_Pending_image = Image_mean_filter(Pending_image, radius);

variance_of_Guide_image = Image_mean_filter(Guide_image .* Guide_image, radius) - ... 
                          mean_of_Guide_image .* mean_of_Guide_image;

Related_GuideAndPending = Guide_image .* Pending_image;

ak = ( Image_mean_filter(Related_GuideAndPending, radius) - ...
       mean_of_Guide_image .* mean_of_Pending_image ) ./ ...
     ( variance_of_Guide_image + (lamta * ones(size(Guide_image))));
  
bk = mean_of_Pending_image - ak .* mean_of_Guide_image;

ai = Image_mean_filter(ak, radius);
bi = Image_mean_filter(bk, radius);

Out_image = ai .* Guide_image + bi;

end

