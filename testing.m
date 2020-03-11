clear all; clc; close all;                                                                                                                                                                                                                                                                                                                                                                                                     

% Menepatkan Lokasi Data Train                                                                                        
folder_name = 'Data Testing1'; 
% Membaca nama file yang berformat .jpg                                    
file_name = dir(fullfile(folder_name,'*.jpg'));                                                                                                          
% Menghitung Jumlah file yang dibaca
total_file = numel(file_name); 

TestImgs = []; 
% TestImgs = zeros(total_file,20);    
for i=1:total_file                                                                                                               
    Img = imread(fullfile(folder_name, file_name(i).name));                                 
    
    [~,imSeg] = createMask(Img); 
    % Segmentasi Gambar
    rgb = im2double(imSeg); 
    r = rgb(:, :, 1);
    g = rgb(:, :, 2);
    b = rgb(:, :, 3);
    

%     % RGB ke HSV 
%     %  HSV Colour
    hsv = rgb2hsv(rgb);
    Hue = hsv(:,:,1);
    Sat = hsv(:,:,2);  
    Val = hsv(:,:,3);  
%     
%     mean_Hue = mean2(Hue);
%     mean_Sat = mean2(Sat);
%     mean_Val = mean2(Val);
    
    % LAB Colour
%     lab = rgb2lab(rgb);
%     mean_L = mean2(lab(:,:,1));
%     mean_A = mean2(lab(:,:,2));
%     mean_BB = mean2(lab(:,:,3));
% %     
%     % Color Feature Extraction 
%     stat = statwarna(rgb); 
%     
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
    
    % LBP
%     LBP = lbp(Sat,0.1); 
%     
%     Stat = stattekstur(LBP); 
%     mu=Stat.mu;
%     deviasi = Stat.deviasi;
%     skewness = Stat.skewness ;
%     energi = Stat.energi;
%     entropi = Stat.entropi;
%     smoothness = Stat.smoothness;
%     RMS = Stat.RMS;
%     
%     TestImgs =
%     [TestImgs;mu,deviasi,skewness,energi,entropi,smoothness,RMS];        
%      
%      LBPH = imhist(lbp(Hue));                                            
%      normLBPH = LBPH'/sum(LBPH);                                         

%      LBPS = imhist(lbp(Sat));                                            
     
    histLBP = lbp(Sat,1,8,0,'nh');                                                                                                    
%     histLBP = imhist(LBP);
%    Normalisasi Histogram LBP 
    normLBP = histLBP/sum(histLBP);

     TestImgs = [TestImgs;normLBP];   
     
%      TestImgs = [TestImgs;mean_r,mean_g,mean_b,mean_Hue,mean_Sat,mean_Val,mean_L,mean_A,mean_BB,dev_r,dev_g,dev_b,...
%                 skew_r,skew_g,skew_b];                                                                        
%     
    % Area yang terjangkit Penyakit
%     bw = im2bw(rgb);
%     area = bwarea(bw); 
    
%     TestImgs = [TestImgs;mean_r,mean_g,mean_b,mean_Hue,mean_Sat,mean_Val,mean_L,mean_A,mean_BB,dev_r,dev_g,dev_b,...
%                 skew_r,skew_g,skew_b,mu,deviasi,skewness,energi,entropi,smoothness]; 
%     TestImgs(i,:) = [mu,deviasi,skewness,energi,entropi,moothness]; 
%     
%     
%     TestImgs(i,:) = [mean_Hue,mean_Sat,mean_r,mean_g,mean_b,dev_r,dev_g,dev_b,skew_r,skew_g,skew_b,...
%                     cur_r,cur_g,cur_b,mu,deviasi,skewness,energi,entropi,smoothness];
    % Create the Gray Level Cooccurance Matrices (GLCMs)
%     glcms = graycomatrix(LBP);                                             
% 
%     % Derive Statistics from GLCM 
%     stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');   
% 
%     Contrast = stats.Contrast;
%     Correlation = stats.Correlation;
%     Energy = stats.Energy;
%     Homogeneity = stats.Homogeneity;                                     
%     
%     H = imhist(glcms)';
%     H = H/sum(H);
%     I = [0:255];
%     CiriMEAN = I*H';
%     CiriENT = -H*log2(H+eps)';
%     CiriVAR = (I-CiriMEAN).^2*H';
%     CiriSKEW = (I-CiriMEAN).^3*H'/CiriVAR^1.5;
%     CiriKURT = (I-CiriMEAN).^4*H'/CiriVAR^2-3;
%     Area = sum(sum(H));
%     
% 

end;

% test_label = zeros(1,total_file);  
% test_label(1:20) = 1; % BrownSpot
% test_label(21:40) = 2; % Hispa
% test_label(41:60) = 3; % LeafBlast

test_label = zeros(1,total_file);  
test_label(1:100) = 1; % BrownSpot
test_label(101:200) = 2; % Hispa
test_label(201:300) = 3; % LeafBlast


% load data_latih dan target_latih hasil pelatihan
load TrainData;
load TrainLabel;

% Menerapkan SVM
% SVMModel = fitcsvm(TestImgs,test_label); 
SVMTest = multisvm(TrainImgs, train_label, TestImgs);  
[a,~] = find(SVMTest'==test_label);
total_rightTest = sum(a);
total_errorTest = total_file - total_rightTest;
test_accuracy = (total_rightTest/total_file) * 100; 
