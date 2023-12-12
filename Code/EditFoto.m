clear all; clc; close all;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                               
% Membaca Data Train Bacterial
folder_name = 'Foto';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg'));
Img= imread(fullfile(folder_name, file_name.name));

gray = rgb2gray(Img);

baseFileName = file_name.name; % Whatever....
fullFileName = fullfile('EditFoto', baseFileName);                         
imwrite(gray, fullFileName);