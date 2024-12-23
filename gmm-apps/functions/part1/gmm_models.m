function [models] = gmm_models(Xtrain, Ytrain, params)
%GMM_MODELS Computes maximum likelihood estimate of the parameters for the 
% given GMM using the EM algorithm and initial parameters for each class of
% the dataset X_train
%   input------------------------------------------------------------------
%
%       o Xtrain   : (N x M_train), a data set with M_train samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o Ytrain   : (1 x M_train), a vector with labels y corresponding to X_train.
%       o params    : The structure of hyperparameters for the GMM
%
%   output ----------------------------------------------------------------
%       o models    :  (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids 
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

models.Priors = [];
models.Mu = [];
models.Sigma = [];

% Here we consider K = 1 for each classes

Ytrain_unique = unique(Ytrain);
for c = 1:length(Ytrain_unique)
    Xtrain_c = Xtrain(:,Ytrain==Ytrain_unique(c));
    [models(c).Priors, models(c).Mu, models(c).Sigma, iter] = gmmEM(Xtrain_c, params);
    
end






end