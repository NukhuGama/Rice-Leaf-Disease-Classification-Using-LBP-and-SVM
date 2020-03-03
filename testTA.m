clc;                          
clear all; 
tic;


image = imread('sudah.jpg');  

imSeg = segdaun2(image);

rgb = im2double(imSeg);
r = rgb(:, :, 1);
g = rgb(:, :, 2);
b = rgb(:, :, 3);

im = RGBkeHSV(r,g,b);
im2 = rgb2gray(rgb);
% ekstraksi ciri LBP terhadap masing-masing citra
lbpI = lbp(im2);
lbpI2 = lbp(im);

figure('NumberTitle', 'off', 'Name', 'Gambar Asli');
imshow(image);

figure('NumberTitle', 'off', 'Name', 'Gambar Segmentasi');
imshow(imSeg);

% Make Croping 
[baris, kolom] = size(imSeg); 
% 
figure('NumberTitle', 'off', 'Name', 'Gambar HSV');
imshow(im);

figure('NumberTitle', 'off', 'Name', 'LBP Image Grayscale'); 
imshow(lbpI);                                        

figure('NumberTitle', 'off', 'Name', 'LBP Image HSV');
imshow(lbpI2);
% Let's compute and display the histogram. 
figure
[pixelCount grayLevels] = imhist(lbpI); 
subplot(1, 1, 1);  
bar(pixelCount, 'BarWidth', 1, 'EdgeColor', 'black');     
grid on;
title('Histogram of Original LBP from GrayScale', 'FontSize', 16); 
xlim([0 grayLevels(end)]); % Scale x axis manually.

figure
[pixelCount HSVLevels] = imhist(lbpI2); 
subplot(1, 1, 1);  
bar(pixelCount, 'BarWidth', 1, 'EdgeColor', 'blue'); 
grid on;
title('Histogram of Original LBP from HSV', 'FontSize', 16); 
xlim([0 HSVLevels(end)]); % Scale x axis manually.  




