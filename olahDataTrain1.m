clc;                                                                                                                                                                                                                                                                 
clear all;                                                                                                                        

% Membaca Data Train BacterialZ
folder_name = 'Edit Dataset\Bacterial';                                      
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
  ImTrain(i).image = imread(fullfile(folder_name, file_name(i).name));          
  ImTrain(i).label = 1;
end;

% Membaca Data Train BrownSpot
folder_name = 'Edit Dataset\Brownspot';                    
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);

for i = 1:total_file
  ImTrain(i+total_file).image = imread(fullfile(folder_name, file_name(i).name));
  ImTrain(i+total_file).label = 2;
end;                                                                       


% Membaca Data Train LeafSmut
folder_name = 'Edit Dataset\Leafsmut';                                                                                     
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);

for i = 1:total_file
  ImTrain(i+total_file*2).image = imread(fullfile(folder_name, file_name(i).name));
  ImTrain(i+total_file*2).label = 3;
end;

save DataTrain.mat ImTrain ;