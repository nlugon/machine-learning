function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X); % Change in names, normally [N,M] = size(X), so M -> N, N -> D
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == [];plot_iter = 0;end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);




%% INSERT CODE HERE

Mu_init = kmeans_init(X, K, init);




%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% INSERT CODE HERE

Mu = Mu_init;
iter = 0;
tol_iter = 0;

while 1

    Mu_previous = Mu;
    iter = iter+1;

    % Assignment Step

    d_i =  distance_to_centroids(X, Mu, type);
    [~,k_i] = min(d_i,[],1);
    %if K==1
     %   k_i = ones(1,N);
    %end

    r_i    = zeros(K,N);
    for j=1:N
        r_i(k_i(j),j) = 1;
    end

    % Update Step : Recompute Centroids

    sum_cluster = sum(r_i,2);

    
    if any(sum_cluster == 0)
        Mu_init = kmeans_init(X, K, init);
        Mu = Mu_init;
        iter = 0;
        tol_iter = 0;
        
    else
        for i=1:K
            Mu(:,i) = sum(r_i(i,:) .* X , 2) / sum_cluster(i);
        end
    


    [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance);
    if has_converged
        break
    end
    end

end



labels = k_i;



%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end


end