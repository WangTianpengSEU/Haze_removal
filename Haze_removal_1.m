%  Instructions
%  ------------
%

%  This program is used for image defogging.
%  Version 1.0  2019/02/28 By Tianpeng Wang
%  ----- Use the theory of "Dark Channel". And build a basic code
%  framework. 

%% Loop time
Index = 1;
while Index < 2
    
%% Initial the parameter 
fprintf('Initial the parameter ...\n');

Minimum_size = 5;                   % Minimum filter windows size
W = 0.95;                        % Haze_reserve
t0 = 0.1;                       % Eliminate division noise
% Filter_windows_size = 10*Index+1;       % Guided filter size  
Filter_windows_size = 41;       % Guided filter size  
lamta = 0.001;                  % Least squares Eliminate sensitivity
% Index = 1;                % The processed images' filename
fprintf('Initial the parameter finished ...\n');

%% Import the image data
fprintf('\n\n');
fprintf('Import the image data ...\n');
Image_data = ...
imread('H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Other_size\Tiananmen_haze.png');
fprintf('Import the image data finished.\n');
imshow(Image_data);

imwrite(Image_data, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\1Original_image\',...
          strcat('Original_image','_',int2str(Index)),'.jpg']);
      
Gray_figure = rgb2gray(Image_data);
% figure;imshow(Gray_figure);

imwrite(Gray_figure, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\2Gray_image\',...
          strcat('Gray_image','_',int2str(Index)),'.jpg']);
      
% pause;

%% Transform uint8 array to double matrix
fprintf('Transform uint8 array to double matrix ...\n');
[Image_R, Image_G, Image_B, Image_data_array] = Image_to_RGB(Image_data); 
fprintf('Transform uint8 array to double matrix finished.\n');

% pause;

%% Calculate the minimum R/G/B value in every pixel
fprintf('Calculate the minimum R/G/B value in every pixel ...\n');
[Min_data] = RGB_channels_min_value(Image_R, Image_G, Image_B); 
fprintf('Calculate the minimum R/G/B value in every pixel finished \n');

imwrite(Min_data, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\3Min_channel\',...
          strcat('Min_channel','_',int2str(Index)),'.jpg']);
      
% figure;imshow(Min_data);

% pause;

%% Use minimum filter and get the Dark channel image
fprintf('Use minimum filter and get the Dark channel image ...\n');
% [Dark_channel_image_original] = Minimum_filter(Min_data, Minimum_size);
% figure;imshow(Dark_channel_image_original);
[Dark_channel_image_original] = Minimum_filter2(Min_data, Minimum_size);
% figure;imshow(Dark_channel_image_original);
fprintf('Use minimum filter and get the Dark channel image finished \n');

imwrite(Dark_channel_image_original, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\4Dark_original\',...
          strcat('Dark_original','_',int2str(Index)),'.jpg']);
      
% pause;

%% Estimate the Atmosphere value
fprintf('Estimate the Atmosphere value ...\n');
tic
[Atmosphere_value] = Atmosphere_estimate(Dark_channel_image_original);
toc
fprintf('Estimate the Atmosphere value finished \n');

% pause;

%% Calculate the Transmit map
fprintf('Calculate the Transmit map ...\n');
[Transmit_function] = Transmit_image(Dark_channel_image_original, Atmosphere_value, W);
fprintf('Calculate the Transmit map finished \n');

imwrite(Transmit_function, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\5Transmit_original\',...
          strcat('Transmit_original','_',int2str(Index)),'.jpg']);

% figure;imshow(Transmit_function);
% pause;

%% Use guided filter algorithm to smooth the transmit map
% R_I = im2double(Image_data(:,:,1));
% G_I = im2double(Image_data(:,:,2));
% B_I = im2double(Image_data(:,:,3));
Smooth_transmit_function1 = Guide_filter(im2double(Gray_figure), Transmit_function, Filter_windows_size, lamta);   % Guide_filter is my program
% Smooth_transmit_function2 = Guide_filter(R_I, Transmit_function, Filter_windows_size, lamta);   % Guide_filter is my program
% Smooth_transmit_function3 = Guide_filter(G_I, Transmit_function, Filter_windows_size, lamta);   % Guide_filter is my program
% Smooth_transmit_function4 = Guide_filter(B_I, Transmit_function, Filter_windows_size, lamta);   % Guide_filter is my program
% Smooth_transmit_function = guidedfilter(Min_data, Transmit_function, floor((Filter_windows_size - 1)/2), lamta); % guidedfilter is He Kaiming's program
figure;
imshow(Smooth_transmit_function1);
% figure;
% imshow(Smooth_transmit_function2);
% figure;
% imshow(Smooth_transmit_function3);
% figure;
% imshow(Smooth_transmit_function4);

imwrite(Smooth_transmit_function1, ...
       ['H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\6Smooth_transmit\',...
          strcat('Smooth_transmit','_',int2str(Index)),'.jpg']);

% pause;

%% Rebuild the image
fprintf('Rebuild the image ...\n');
[Haze_removal_image] = Rebuild_image(Image_data_array, Smooth_transmit_function1, Atmosphere_value, t0);
imwrite(  Haze_removal_image, ...
        [ 'H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\7Final_image\',...
          strcat('Final_image','_',int2str(Index)),'.jpg']);
% [Haze_removal_image] = Rebuild_image(Image_data_array, Smooth_transmit_function2, Atmosphere_value, t0);
% imwrite(Haze_removal_image, 'H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\2.jpg');
% [Haze_removal_image] = Rebuild_image(Image_data_array, Smooth_transmit_function3, Atmosphere_value, t0);
% imwrite(Haze_removal_image, 'H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\3.jpg');
% [Haze_removal_image] = Rebuild_image(Image_data_array, Smooth_transmit_function4, Atmosphere_value, t0);
% imwrite(Haze_removal_image, 'H:\Desktop\Master_graduation_design_wtp\MATLAB_project\Haze_removal1\DATA\Haze_image\Processed_image\4.jpg');
fprintf('Rebuild the image finished \n');


%% Close all windows
fprintf('Enter and close all windows \n');
pause;
close all;
 
    Index = Index + 1;

end
