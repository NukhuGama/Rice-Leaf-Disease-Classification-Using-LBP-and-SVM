% Load Train Feature dan Train Label untuk Bandingkan dengan Testing;
clear all; clc; close;
load TrainFeature.mat;
load TrainLabel.mat



rng('default') % For reproducibility
cvp = cvpartition(train_label,'KFold',10);                                 
% 
X = SVMTrain;
y = train_label';
% 
% %Cross Validation Error (mcr= missclassification error)
% cvError = crossval('mcr',X,y,'Predfun',@classf,'Partition',cvp);


% validationAccuracy =(1-cvError) * 100; 


c = cvpartition(train_label,'KFold',5);

% Create a function that computes the number of misclassified test samples.

fun = @(xTrain,yTrain,xTest,yTest)(sum(~strcmp(yTest,...
    classify(xTest,xTrain,yTrain)))); 

% Return the estimated misclassification rate using cross-validation.

rateMissClass = sum(crossval(fun,X,y,'Partition',c))/sum(c.TestSize);

valid_accuracy = (1 - rateMissClass) * 100; 









