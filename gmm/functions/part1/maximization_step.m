function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

[N,M] = size(X);
K = params.k;
type = params.cov_type;

epsilon = 1e-5;

sum_k = sum(Pk_x,2); % K x 1, each element is the sum of all elements in line k
% Update Priors

Priors = sum_k' / M;

% Update Centroids

Mu = zeros(N,K);
for k=1:K
    Mu(:,k) = sum(Pk_x(k,:).*X, 2) / sum_k(k);
end

% Update Covariance Matrix, using now the updates Mu

switch type
    case 'full'
        Sigma = zeros(N,N,K);
        for k=1:K
            for i=1:M
                Sigma(:,:,k) = Sigma(:,:,k) + Pk_x(k,i)*(X(:,i)-Mu(:,k))*(X(:,i)-Mu(:,k))'; 
            end
            Sigma(:,:,k) = Sigma(:,:,k) / sum_k(k);
        end
        
    case 'diag'
        Sigma = zeros(N,N,K);
        for k=1:K
            for i=1:M
                Sigma(:,:,k) = Sigma(:,:,k) + Pk_x(k,i)*(X(:,i)-Mu(:,k))*(X(:,i)-Mu(:,k))'; 
            end
            Sigma(:,:,k) = Sigma(:,:,k) .* eye(N) / sum_k(k) ;
        end

    case 'iso'
        Sigma = zeros(N,N,K);
        for k=1:K
        sigma_iso = 0;
            for i=1:M
                sigma_iso = sigma_iso + Pk_x(k,i) * (X(:,i)-Mu(:,k))'*(X(:,i)-Mu(:,k));
            end
            sigma_iso = sigma_iso/(N*sum_k(k));
            Sigma(:,:,k) = eye(N)*sigma_iso;
        end

end

% Add tiny variance to avoid numerical instability

for k=1:K
    Sigma(:,:,k) = Sigma(:,:,k) + eye(N)*epsilon;
end





end

