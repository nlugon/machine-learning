function [F1_curve] =  f1measure_eval(X, K_range, repeats, init, type, MaxIter, true_labels)
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
%       o true_labels : (1 x M) the real labels for the F1 measure
%                       computation
%
%   output ----------------------------------------------------------------
%       o F1_curve   : (1 X K_range), F1 values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_iter = 0;
[N,M] = size(X);

F1_curve = [];


for i=K_range

    mean_F1 = 0;

    for repeat=1:repeats
        [labels, Mu, Mu_init, iter] =  kmeans(X,i,init,type,MaxIter,plot_iter);
        [F1_overall, P, R, F1] =  f1measure(labels, true_labels);
        % store_labels = [store_labels; {labels}];
        % store_Mu = [store_Mu; {Mu}];

        mean_F1 = mean_F1 + F1_overall;
        

    end

    mean_F1 = mean_F1 / repeats;
    F1_curve = [F1_curve, mean_F1];

end



end