clear all; clc; close all;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                               
% Membaca Data Train Bacterial
folder_name = 'Train\Bacterial';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                 
    [~, imSeg] = createMask(Img);                                                                                 
%     imSeg = segdaun2(Img);
    % Segmentasi Gambar
    rgb = im2double(imSeg);                                                  
%     gray = rgb2gray(rgb);
%    RGB ke HSV 
    hsv = rgb2hsv(rgb);                                                                                                                                                                                            
                                                                                                            
    Hue = hsv(:,:,1);                                                         
    Sat = hsv(:,:,2);                                                                          
                                                                                                                 
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('SaturationImage/Train/Bacterial', baseFileName);
    imwrite(Sat, fullFileName);                     
end;

% Membaca Data Train Brownspot
folder_name = 'Train\Brownspot';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                 
    [~, imSeg] = createMask(Img);                                                                                 
%     imSeg = segdaun2(Img);
    % Segmentasi Gambar
    rgb = im2double(imSeg);                                                  
%     gray = rgb2gray(rgb);
%    RGB ke HSV 
    hsv = rgb2hsv(rgb);                                                                                                                                                                                            
                                                                                                            
    Hue = hsv(:,:,1);                                                         
    Sat = hsv(:,:,2);                                                                          
                                                                                                                 
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('SaturationImage/Train/Brownspot', baseFileName);
    imwrite(Sat, fullFileName);                     
end;   


% Membaca Data Train Leafsmut
folder_name = 'Train\Leafsmut';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                 
    [~, imSeg] = createMask(Img);                                                                                 
%     imSeg = segdaun2(Img);
    % Segmentasi Gambar
    rgb = im2double(imSeg);                                                  
%     gray = rgb2gray(rgb);
%    RGB ke HSV 
    hsv = rgb2hsv(rgb);                                                                                                                                                                                            
                                                                                                            
    Hue = hsv(:,:,1);                                                         
    Sat = hsv(:,:,2);                                                                          
                                                                                                                 
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('SaturationImage/Train/Leafsmut', baseFileName); 
    imwrite(Sat, fullFileName);                     
end;  