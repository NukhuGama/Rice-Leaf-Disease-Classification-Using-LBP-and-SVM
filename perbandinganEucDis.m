clear all;
clc;
close all;
load TrainFeature.mat                                                                                                       

bacterialFeat = TrainFeature(1:180,:);
brownspotFeat = TrainFeature(181:360,:);
leafsmutFeat  = TrainFeature(361:540,:); 

% normBact = bacterialFeat/sum(bacterialFeat);                                                        

meanBact  = mean(std2(bacterialFeat));                                                                                  
meanBrown = mean(std2(brownspotFeat));
meanLeaf  = mean(std2(leafsmutFeat));             

gambar = imread('D:\MATERIA SEMESTER VIII\TUGAS AKHIR\TAAAAA\Edit Data UCI\DATA UCI BARU\Testing\Leafsmut\Leafsmut_116.jpg');
[~, imSeg] = createMask(gambar); 

rgb = im2double(imSeg);                                                    
r = rgb(:, :, 1);
g = rgb(:, :, 2); 
b = rgb(:, :, 3);                                                                                                       
%     
stat = statwarna(rgb);  

% Mean (Nilai rata rata setiap warna R, G,B)
mean_r = stat.mean_r;                                                  
mean_g = stat.mean_g;
mean_b = stat.mean_b;

%Standard Deviation (Nilai Standard Deviasi pada setiap warna R,G,B)   
dev_r = stat.dev_r;                                                    

hsv = rgb2hsv(rgb);                                                    
               
Hue = hsv(:,:,1);                                                                                                                                                                                         
Sat = hsv(:,:,2);
Val = hsv(:,:,3);

histLBP = lbp(Sat,2,8,0,'nh');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
%     histLBP = imhist(LBP);                                               
normLBP1 = histLBP/sum(histLBP);
normLBP = [ normLBP1,mean_r,mean_g,mean_b,dev_r];
%  
perBLB = norm(meanBact-normLBP);
perBS =  norm(meanBrown-normLBP);
perLS =  norm(meanLeaf-normLBP);                                         

% perBLB_BS = norm(meanBact-meanBrown);                                               
% perBLB_LS = norm(meanBact-meanLeaf);
% perBS_LS =  norm(meanBrown-meanLeaf); 
save meanFeat.mat meanBact meanBrown meanLeaf




