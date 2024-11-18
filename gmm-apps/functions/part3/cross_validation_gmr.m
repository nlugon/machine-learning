function [metrics] = cross_validation_gmr(X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X_train, y_train, X_test, y_test ] = split_regression_data(X, y, valid_ratio );



AICmat = [];
BICmat = [];
MSEmat = [];
NMSEmat = [];
R2mat = [];

for f=1:F_fold

    AICf = [];
    BICf = [];
    MSEf = [];
    NMSEf = [];
    R2f = [];

    [X_train, y_train, X_test, y_test] = split_regression_data(X, y, valid_ratio);
    data_train = [X_train ; y_train];
    data_test = [X_test ; y_test];
    
    [N_test,M_test] = size(X_test);
    P_test = size(y_test,1);
    in_test = 1:N_test;
    out_test = (N_test+1):(N_test+P_test);

    [N_train,M_train] = size(X_train);
    P_train = size(y_train,1);
    in_train = 1:N_train;
    out_train = (N_train+1):(N_train+P_train);

    for i=k_range
        params.k = i;
        

        [Priors, Mu, Sigma, ~] = gmmEM(data_train, params); % data_train or data_test? X or [X;y]?
        [AIC, BIC] =  gmm_metrics(data_train, Priors, Mu, Sigma, params.cov_type);
        AICf = [AICf , AIC];
        BICf = [BICf , BIC];

        [yest, ~] = gmr(Priors, Mu, Sigma, X_test, in_train, out_train);
        [MSE, NMSE, R2] = regression_metrics( yest, y_test );
        MSEf = [MSEf , MSE];
        NMSEf = [NMSEf , NMSE];
        R2f = [R2f , R2];
    end

    AICmat = [AICmat ; AICf];
    BICmat = [BICmat ; BICf];
    MSEmat = [MSEmat ; MSEf];
    NMSEmat = [NMSEmat ; NMSEf];
    R2mat = [R2mat ; R2f];

    
end


metrics.mean_AIC = mean(AICmat,1);
metrics.std_AIC = std(AICmat,0,1);

metrics.mean_BIC = mean(BICmat,1);
metrics.std_BIC = std(BICmat,0,1);

metrics.mean_MSE = mean(MSEmat,1);
metrics.std_MSE = std(MSEmat,0,1);

metrics.mean_NMSE = mean(NMSEmat,1);
metrics.std_NMSE = std(NMSEmat,0,1);

metrics.mean_R2 = mean(R2mat,1);
metrics.std_R2 = std(R2mat,0,1);






end

