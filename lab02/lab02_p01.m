clear all
close all
clc

%load original image
img0 = imread('JB.jpg');
% imshow(img0);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Vignette filter 

% Method 1: using zero padding

%Create Vignette effect/filter (gaussian window)
%create Gaussian window for vignette. Vignette is done in original domain
%gaussian alpha factor = 1.5 here. Alpha controls the spread of the
%gaussian filter. Higher the value, the lower the spread
v = gausswin(1000,1.5);  %dark-circle-zoom effect
v = v*v';
figure (1);
imagesc(v);title('Scale color, window = 1000, factor = 1.5'); % display image with scaled color

%convert image from 8-bit unsigned integer to double for calculations
%(we cannot perform calculations in the same domain)
img1 = double(img0);
%using zero padding for img --> now img size is 1000x1000
img1 = padarray(img1,[167,0]);
img1 = padarray(img1,[0,1],'post');
%apply Vignette
img1(:,:,1) = img1(:,:,1).*v;  %red
img1(:,:,2) = img1(:,:,2).*v;  %green
img1(:,:,3) = img1(:,:,3).*v;  %blue
%convert image back to 8-bit unsigned integer to display img
figure (2); 
imshow(uint8(img1));title('Zero-padding image & vignette');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Vignette filter 

%Method 2: crop img

%Crop image to 660x660 for applying Vignette filter with same window size
%660x660
targetSize = [660 660];
r = centerCropWindow2d(size(img0),targetSize);
img2 = imcrop(img0,r);
figure (3);
imshow(img2);title('Cropped image');

%Create Vignette effect/filter (gaussian window)
%Vignette is done in the original domain
h = gausswin(660,1.5);  %dark-circle-zoom effect
h = h*h';
figure (4);
imagesc(h); % display image with scaled color
title('Scale color, window = 660, factor = 1.5');

%apply Vignette effect/filter to each Red Green and Blue field
%convert image from 8-bit unsigned integer to double for calculations
img2 = double(img2); 
img2(:,:,1) = img2(:,:,1).*h;  %red
img2(:,:,2) = img2(:,:,2).*h;  %green
img2(:,:,3) = img2(:,:,3).*h;  %blue
%convert image back to 8-bit unsigned integer to display
figure (5);
imshow(uint8(img2));title('Cropped image & vignette');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Filter wrinkles, blur effect

%Method 1: fspecial gaussian
w = fspecial('gaussian', [9 9], 2); 
wf = fft2(w,660*2,660*2);
figure (6);
imagesc(w);title('fspecial gaussian filter');

%apply blur effect on image
imgf1(:,:,1) = fft2(img0(:,:,1),660*2,660*2).*wf;
imgf1(:,:,2) = fft2(img0(:,:,2),660*2,660*2).*wf;
imgf1(:,:,3) = fft2(img0(:,:,3),660*2,660*2).*wf;
figure(7);
imshow(uint8(ifft2(imgf1)));title('Filter - fspecial gaussian');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Method 2: Blur original image with convolutional filter
imgf2 = zeros(size(img0),class(img0));
for k = 1 : size(img0,3)
    imgf2(:,:,k) = conv2(img0(:,:,k), ones(3,3)/9,'same');
end
figure(8);
imshow(uint8(imgf2)); title('Filter - convolutional filter');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filter-Vignette
img_final_1 = imcrop(imgf2,r);
img_final_1 = double(img_final_1); 
%apply vignette
img_final_1(:,:,1) = img_final_1(:,:,1).*h;  %red
img_final_1(:,:,2) = img_final_1(:,:,2).*h;  %green
img_final_1(:,:,3) = img_final_1(:,:,3).*h;  %blue
%convert image back to 8-bit unsigned integer to display
figure(9);
imshow(uint8(img_final_1)); title('Filter-Vignette');


% Vignette-Filter
img_final_2 = zeros(size(img2),class(img2));
%apply filter
for k = 1 : size(img2,3)
    img_final_2(:,:,k) = conv2(img2(:,:,k), ones(3,3)/9,'same');
end
figure(10);
imshow(uint8(img_final_2));title('Vignette-Filter');

