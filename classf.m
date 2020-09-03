
function yfit = classf(Xtrain,ytrain,Xtest)                                                  

    % Standardize the training predictor data. Then, find the 
    % principal components for the standardized training predictor
    % data.
    [Ztrain,Zmean,Zstd] = zscore(Xtrain);
    [coeff,scoreTrain,~,~,explained,mu] = pca(Ztrain);

    % Find the lowest number of principal components that account
    % for at least 95% of the variability.
    n = find(cumsum(explained)>=95,1);

    % Find the n principal component scores for the standardized
    % training predictor data. Train a classification tree model
    % using only these scores.
    scoreTrain95 = scoreTrain(:,1:n);
    mdl = fitctree(scoreTrain95,ytrain);

    % Find the n principal component scores for the transformed
    % test data. Classify the test data.
    Ztest = (Xtest-Zmean)./Zstd;
    scoreTest95 = (Ztest-mu)*coeff(:,1:n);
    yfit = predict(mdl,scoreTest95);

end