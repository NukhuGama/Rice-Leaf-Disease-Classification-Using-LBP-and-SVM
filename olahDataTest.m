clc;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
clear all;                                                                 

% Membaca Data Testing Bacterial 
folder_name = 'Testing\Bacterial';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);

for i = 1:total_file
  ImTest(i).image = imread(fullfile(folder_name, file_name(i).name));          
  ImTest(i).label = 1;
end;

% Membaca Data Testing BrownSpot
folder_name = 'Testing\Brownspot'; 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);

for i = 1:total_file
  ImTest(i+total_file).image = imread(fullfile(folder_name, file_name(i).name));
  ImTest(i+total_file).label = 2;
end;                                                                       


% Membaca Data Testing LeafSmut
folder_name = 'Testing\Leafsmut';                                         
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg'));                            
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);

for i = 1:total_file
  ImTest(i+total_file*2).image = imread(fullfile(folder_name, file_name(i).name));
  ImTest(i+total_file*2).label = 3;
end;

save DataTest.mat ImTest ;

