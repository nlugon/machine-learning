function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of min AIC values for K-range
%       o BIC_curve  : (1 X K), vector of min BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

AIC_curve = [];
BIC_curve = [];

for i=K_range

    params.k = i;

    AIC_table = zeros(1,repeats);
    BIC_table = zeros(1,repeats);

    for repeat=1:repeats

        [Priors, Mu, Sigma, iter] = gmmEM(X, params);
        [AIC, BIC] =  gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);

        %mean_AIC = mean_AIC + AIC;
        %mean_BIC = mean_BIC + BIC;
        AIC_table(repeat) = AIC;
        BIC_table(repeat) = BIC;
    end

    %mean_AIC = mean_AIC / repeats;
    %mean_BIC = mean_BIC / repeats;

    min_AIC = min(AIC_table);
    min_BIC = min(BIC_table);

    AIC_curve = [AIC_curve, min_AIC];
    BIC_curve = [BIC_curve, min_BIC];


end




end
