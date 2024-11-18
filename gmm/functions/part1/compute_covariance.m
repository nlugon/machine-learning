function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

[N,M] = size(X);

switch type
    case 'full'
        X_zero_mean = X-X_bar;
        Sigma = 1/(M-1).*X_zero_mean*X_zero_mean';
        
    case 'diag'
        X_zero_mean = X-X_bar;
        Sigma = 1/(M-1).*X_zero_mean*X_zero_mean';
        Sigma = Sigma .* eye(N);

    case 'iso'
        sigma_iso = 0;
        for i=1:M
            sigma_iso = sigma_iso + (X(:,i)-X_bar)'*(X(:,i)-X_bar);
        end
        sigma_iso = sigma_iso/(N*M);
        Sigma = eye(N)*sigma_iso;
end



end

