% % folder_name = 'Data Baru\Data Testing';
% % % Membaca nama file yang berformat .jpg
% % file_name = dir(fullfile(folder_name,'*.jpg')); 
% % % Menghitung Jumlah file yang dibaca
% % total_file = numel(file_name);
% % 
gambarasli = imread('Smut.jpg');
gambarasli = segdaun2(gambarasli);
[~, seg] = createMask(gambarasli);
% [bar,kol,dim] = size(hsv);
% sat = hsv(:,:,2);
% gray = rgb2gray(gambarasli);
% LBP_I = lbpI(sat,0.2);
figure
% % % a = segdaun2(a);
imshow(gambarasli);

figure
% % % a = segdaun2(a);
imshow(seg)



% 
% Sat = hsv(:,:,2);
% updateSat = Sat + 5;
% 
% figure
% imshow(hsv);
% 
% figure
% [pixelCount SatLevels] = imhist(updateSat); 
% subplot(1, 1, 1);  
% bar(pixelCount, 'BarWidth', 1, 'EdgeColor', 'black');     
% grid on;
% title('Histogram Update SAturasi', 'FontSize', 16);
% 
% % 
% load TrainData.mat
% xlswrite('TrainData.xlsx',TrainImgs);

% imFog = imread('fog.jpg');
% 
% imDehaze = imreducehaze(imFog);