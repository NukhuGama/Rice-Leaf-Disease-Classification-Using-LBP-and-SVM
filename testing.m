clear all; clc; close all;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           

% Load Data Train                                                                      
load DataTest.mat;
%Total File
total_file = length(ImTest);                                                                                                                                                                                                                                                                                                                                                                  

TestFeature = [];

for i=1:total_file                                                         
    Img = ImTest(i).image;                                                                                            
    
    [~, imSeg] = createMask(Img);                                                                                                                        
%     imSeg = segdaun2(Img);                                                      
    % Segmentasi Gambar             
    rgb = im2double(imSeg); 
    r = rgb(:, :, 1);
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3);                                                                                                       
%     
    stat = statwarna(rgb);
    
    mean_r = stat.mean_r;
    mean_g = stat.mean_g;
    mean_b = stat.mean_b;

    dev_r = stat.dev_r;
    dev_g = stat.dev_g;
    dev_b = stat.dev_b; 
% 
%     skew_r = stat.skew_r;                                                
%     skew_g = stat.skew_g;                                                
%     skew_b = stat.skew_b;                                                
%     gray = rgb2gray(rgb);                                                                                                
%    RGB ke HSV                                                            
    hsv = rgb2hsv(rgb);                                                    
               
    Hue = hsv(:,:,1);                                                                                                                                                                                         
    Sat = hsv(:,:,2);
    Val = hsv(:,:,3);
                                                                           
                                                                           
%     mean_Hue = mean(mean(Hue));                                                                                                     
%     mean_Sat = mean(mean(Sat)); 
%     mean_Val = mean(mean(Val));
%     
%     std_Hue = std2(Hue);
%     std_Sat = std2(Sat);
%     std_Val = std2(Val);                                                 
    
    histLBP = lbp(Sat,1,8,0,'nh');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
%     histLBP = imhist(LBP);                                               
    normLBP = histLBP/sum(histLBP);                                        
%    
% Area
%     bw = im2bw(rgb,0.01);
%     Area = bwarea(bw);
    
%     TestFeature = [TestFeature;normLBP,mean_r,mean_g,mean_b];                                                                                                                
    
    TestFeature = [TestFeature;normLBP];                                                                             
    
    % Label Of Training 
    test_label(1,i) = ImTest(i).label;                                                                   
                            
end; 

% Load Train Feature dan Train Label untuk Bandingkan dengan Testing;                                               
load TrainFeature.mat;                                                     
load TrainLabel.mat; 
                                                                          

% Menerapkan SVM                                                                                         
[SVMTesting,~] = multisvm(TrainFeature, train_label, TestFeature);                                                                              
[a,~] = find(SVMTesting'==test_label);
total_rightTesting = sum(a);
total_errorTesting = total_file - total_rightTesting;                          
% test_accuracy = (total_rightTesting/total_file) * 100; 
[c_matrixTest,Result] = confMatrix(SVMTesting,test_label);
test_accuracy = Result.Accuracy;  

bacterial_Accuracy = c_matrixTest(1,1)/(c_matrixTest(1,1)+c_matrixTest(2,1)+c_matrixTest(3,1));

brownspot_Accuracy = c_matrixTest(2,2)/(c_matrixTest(1,2)+c_matrixTest(2,2)+c_matrixTest(3,2));

leafsmut_Accuracy = c_matrixTest(3,3)/(c_matrixTest(1,3)+c_matrixTest(2,3)+c_matrixTest(3,3));
% save TestFeature.mat  TestFeature test_label;                            