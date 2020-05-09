clear all; clc; close all;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                          
% Load Data Train                                                                                                      
load DataTrain.mat
%Total File                                                              
total_file = length(ImTrain);                                                                                                                                                                                                                                 

TrainFeature = [];                                                         

for i=1:total_file                                                                                                   
    Img = ImTrain(i).image;                                            
    
    [~, imSeg] = createMask(Img);                                                                                 
%     imSeg = segdaun2(Img);
    % Segmentasi Gambar
    rgb = im2double(imSeg);                                                
    r = rgb(:, :, 1);
    g = rgb(:, :, 2); 
    b = rgb(:, :, 3);
  
     
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
%     bw = im2bw(rgb,0.28);                                                
%     Area = bwarea(bw);
    
%     TrainFeature = [TrainFeature;normLBP,mean_r,mean_g,mean_b];                                                                                                                                                        
    
     TrainFeature = [TrainFeature;normLBP];                                                                       
    % Label Of Training
    train_label(1,i) = ImTrain(i).label;                                                                                                                
                            
    
end;                                                                       


% Menerapkan SVM                                                                                         
[SVMTrain, SVMModel ] = multisvm(TrainFeature, train_label, TrainFeature);                                                                                      
[a,~] = find(SVMTrain'==train_label);                                                                            
total_rightTrain = sum(a);
total_errorTrain = total_file - total_rightTrain;                                                                  
% train_accuracy = (total_rightTrain/total_file) * 100;  
[c_matrixTrain,Result] = confMatrix(SVMTrain,train_label);                                                                              
train_accuracy = Result.Accuracy; 

% KFold 10 for Cross Validation
for n=1:30
    CVSVMModel = crossval(SVMModel,'KFold', 8);                                                                                                                                                                                                                                                                                                                                                                                                     
    % Cross Validation misclassification error      
    loss(n) = kfoldLoss(CVSVMModel);
% Validation Accuracy  
end;
KFoldLoss = min(loss);                                                     
Valid_Accuracy = (1-KFoldLoss) * 100 ;                                                                                                                   
% Save Train SVM untuk data train    

save TrainFeature.mat TrainFeature SVMTrain train_accuracy total_rightTrain total_errorTrain c_matrixTrain SVMModel Valid_Accuracy;    
save TrainLabel.mat train_label;                                       
%  
