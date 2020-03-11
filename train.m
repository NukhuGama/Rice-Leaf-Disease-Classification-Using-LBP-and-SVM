clear all; clc; close all;                                                                                                                                                                                                                                                                                                            

% Menepatkan Lokasi Data Train 
folder_name = 'Data Train1'; 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg')); 
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name);
% kelas_penyakit = cell(total_file,1);  
% Gambar1 = imread(fullfile(folder_name, file_name(1).name));                          
% imshow(Gambar1);
% lbpI = [];
TrainImgs = [];
% TrainImgs = zeros(total_file,20);
for i=1:total_file                                                         
    Img = imread(fullfile(folder_name, file_name(i).name));                                            
    
    
    [~,imSeg] = createMask(Img);
    % Segmentasi Gambar
    rgb = im2double(imSeg); 
    r = rgb(:, :, 1);
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3);
  
%     CiriR = mean2(r);
%     CiriG = mean2(g);
%     CiriB = mean2(b);                                                    
    gray = rgb2gray(rgb);
%    RGB ke HSV 
%   Statistic Colour HSV 
    hsv = rgb2hsv(rgb);
    
    Hue = hsv(:,:,1);
    Sat = hsv(:,:,2);
    Val = hsv(:,:,3);
%     
%     mean_Hue = mean2(Hue);
%     mean_Sat = mean2(Sat);
%     mean_Val = mean2(Val);
% %     
%     % Stat Colour LAB 
%     lab = rgb2lab(rgb);
%     mean_L = mean2(lab(:,:,1));
%     mean_A = mean2(lab(:,:,2));
%     mean_BB = mean2(lab(:,:,3));
%      
%     
%     % Stat Colour RGB
%     stat = statwarna(rgb); 
%     mean_r = stat.mean_r;
%     mean_g = stat.mean_g;
%     mean_b = stat.mean_b; 
% 
%     dev_r = stat.dev_r;
%     dev_g = stat.dev_g;
%     dev_b = stat.dev_b;
% 
%     skew_r = stat.skew_r; 
%     skew_g = stat.skew_g;
%     skew_b = stat.skew_b; 
%     
%     bw = im2bw(rgb,1);                                                        
%     area = bwarea(bw); 
% 
%     cur_r = stat.cur_r;                                                                                           
%     cur_g = stat.cur_g;                                                                                     
%     cur_b = stat.cur_b;  

%     LBPH = imhist(lbp(Hue)); 
%     normLBPH = LBPH'/sum(LBPH); 
    
    histLBP = lbp(Sat,1,8,0,'nh');                                                                      
%     histLBP = imhist(LBP);
    normLBP = histLBP/sum(histLBP); 
%     
    TrainImgs = [TrainImgs;normLBP]; 
    
%     LBPV = imhist(lbp(Val));
%     normLBPV = LBPV'/sum(LBPV);
    
%     TrainImgs = [TrainImgs;normLBPS];  
    
%     TrainImgs = [TrainImgs;mean_r,mean_g,mean_b,mean_Hue,mean_Sat,mean_Val,mean_L,mean_A,mean_BB,dev_r,dev_g,dev_b,...
%                 skew_r,skew_g,skew_b]; 
%     

%     LBP = lbp(Sat);
%     Stat = stattekstur(LBP);
%     mu=Stat.mu;
%     deviasi = Stat.deviasi;
%     skewness = Stat.skewness ;
%     energi = Stat.energi; 
%     entropi = Stat.entropi;
%     smoothness = Stat.smoothness; 
%     RMS = Stat.RMS;
    
%     Area yg terjangkit penyakit
%     bw = im2bw(rgb);
%     area = bwarea(bw);
    
%     TrainImgs = [TrainImgs;mu,deviasi,skewness,energi,entropi,smoothness,RMS];       
    
%     TrainImgs(i,:) = [mu,deviasi,skewness,energi,entropi,moothness];     
    
     
%     TrainImgs(i,:) = [mean_Hue,mean_Sat,mean_r,mean_g,mean_b,dev_r,dev_g,dev_b,skew_r,skew_g,skew_b,...
%                      cur_r,cur_g,cur_b,mu,deviasi,skewness,energi,entropi,smoothness]; 
%     % Create the Gray Level Cooccurance Matrices (GLCMs)
%     glcms = graycomatrix(LBP);
% 
%     % Derive Statistics from GLCM
%     stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');   
% 
%     Contrast = stats.Contrast;
%     Correlation = stats.Correlation;
%     Energy = stats.Energy;
%     Homogeneity = stats.Homogeneity; 

%     H = imhist(glcms); 
%     H = H/sum(H);
%     I = [0:255];
%     CiriMEAN = I*H';
%     CiriENT = -H*log2(H+eps)';
%     CiriVAR = (I-CiriMEAN).^2*H';
%     CiriSKEW = (I-CiriMEAN).^3*H'/CiriVAR^1.5;
%     CiriKURT = (I-CiriMEAN).^4*H'/CiriVAR^2-3;
%     Area = sum(sum(H));
   
    
 
    
%     TrainImgs(i,:)= [Contrast,Correlation,Energy,Homogeneity,CiriENT,CiriVAR,CiriSKEW,CiriKURT,Area];


%     TrainImgs(i,:) =  imhist(LBP,255);                                 
    
end;

% Membuat Kelas Label untuk setiap jenis penyakit untuk data train               
% Pada dataset ini memiliki 1200 total file gambar

% train_label = zeros(1,total_file);  
% train_label(1:40) = 1; % BrownSpot
% train_label(41:80) = 2; % Hispa
% train_label(81:120) = 3; % LeafBlast 

train_label = zeros(1,total_file);  
train_label(1:500) = 1; % BrownSpot
train_label(501:1000) = 2; % Hispa
train_label(1001:1500) = 3; % LeafBlast


% Menerapkan SVM                                                          
% SVMModel = fitcsvm(TrainImgs,train_label);                               
SVMTrain = multisvm(TrainImgs, train_label, TrainImgs);                                                                       
[a,~] = find(SVMTrain'==train_label);
total_rightTrain = sum(a);
total_errorTrain = total_file - total_rightTrain;                          
train_accuracy = (total_rightTrain/total_file) * 100;  

% Save Train SVM untuk data train
 save TrainData.mat TrainImgs train_accuracy total_rightTrain total_errorTrain;    
 save TrainLabel.mat train_label;   
 
