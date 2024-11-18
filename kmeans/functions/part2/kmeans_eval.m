function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%   
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_iter = 0;
[N,M] = size(X);
% K_max = size(K_range,2);
RSS_curve = [];
AIC_curve = [];
BIC_curve = [];



for i=K_range

    % store_labels = [];
    % store_Mu = [];

    % mean_labels = zeros(size(1,M));
    % mean_Mu = zeros(size(N,i));

    mean_RSS = 0;
    mean_AIC = 0;
    mean_BIC = 0;

    for repeat=1:repeats
        [labels, Mu, Mu_init, iter] =  kmeans(X,i,init,type,MaxIter,plot_iter);
        % store_labels = [store_labels; {labels}];
        % store_Mu = [store_Mu; {Mu}];

        [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu);
        mean_RSS = mean_RSS + RSS;
        mean_AIC = mean_AIC + AIC;
        mean_BIC = mean_BIC + BIC;
    end

    mean_RSS = mean_RSS / repeats;
    mean_AIC = mean_AIC / repeats;
    mean_BIC = mean_BIC / repeats;

    RSS_curve = [RSS_curve, mean_RSS];
    AIC_curve = [AIC_curve, mean_AIC];
    BIC_curve = [BIC_curve, mean_BIC];


end






end