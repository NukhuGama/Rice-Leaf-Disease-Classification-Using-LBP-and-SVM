% Membaca Data Train Bacterial                                             
folder_name = 'Train\Bacterial';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                                                                                          
    rotIm = imrotate(Img,180);
    
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('RotateImage180/Bacterial', baseFileName);         
    imwrite(rotIm, fullFileName);                     
end;

% Membaca Data Train Bacterial
folder_name = 'Train\Brownspot';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                                                                                          
    rotIm = imrotate(Img,180);
    
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('RotateImage180/Brownspot', baseFileName);            
    imwrite(rotIm, fullFileName);                     
end;

% Membaca Data Train Leafsmut
folder_name = 'Train\Leafsmut';                                 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
for i = 1:total_file
    Img= imread(fullfile(folder_name, file_name(i).name));          
                                                                                                                                                                          
    rotIm = imrotate(Img,180);
    
    baseFileName = file_name(i).name; % Whatever....
    fullFileName = fullfile('RotateImage180/Leafsmut', baseFileName);              
    imwrite(rotIm, fullFileName);                     
end;