function [y_est] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,M_train] = size(X_train);
M_test = size(X_test,2);

y_est = zeros(1,M_test);

for query=1:M_test % chose all datapoint in X_test as a query point

    % Compute Pairwise Distance
    d_query = compute_distance(X_test(:,query), X_train, params);

    % Extract k-Nearest Neighbors
    [sorted_d_query,idx] = sort(d_query);
    y_knn = y_train(idx);
    first_k_y_knn = y_knn(1:params.k);

    % Majority Vote
    y_est(query) = mode(first_k_y_knn); 
    % or use unique()


end








end