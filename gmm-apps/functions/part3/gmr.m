function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N,M] = size(X);
[D,K] = size(Mu);
P = D-N;

Mux = Mu(in,:);
Muy = Mu(out,:);

Sigmaxx = Sigma(in,in,:);
Sigmayx = Sigma(out,in,:);
Sigmaxy = Sigma(in,out,:);
Sigmayy = Sigma(out,out,:);

% Calculate Beta (Mixing Weights)

Beta = zeros(K,M);
denominator = zeros(1,M);
for k=1:K
    denominator = denominator + Priors(:,k).*gaussPDF(X(in,:), Mux(:,k), Sigmaxx(:,:,k));
end

for k=1:K
    Beta(k,:) = Priors(:,k).*gaussPDF(X(in,:), Mux(:,k), Sigmaxx(:,:,k)) ./ denominator;      
end


% Calculate Mutilde (local regressive functions)

Mutilde = zeros(P,M,K);
for k=1:K
    Mutilde(:,:,k) = Muy(k) + Sigmayx(:,:,k) * inv(Sigmaxx(:,:,k)) * (X(in,:) - Mux(k)); % make sure Muy(k) is size(P,1)
end


% Compute Regressive Function
y_est = zeros(P,M);
for k=1:K
    y_est = y_est + Beta(k,:).*Mutilde(:,:,k);
end

% Compute Uncertainty of the Prediction
Sigmatilde = zeros(P,P,K);
for k=1:K
    Sigmatilde(:,:,k) = Sigmayy(:,:,k) - Sigmayx(:,:,k) * inv(Sigmaxx(:,:,k)) * Sigmaxy(:,:,k);
end

var_est = zeros(P,P,M);
for m=1:M
    for k=1:K
        %Mutilde_k_squared = Mutilde(:,m,k)'*Mutilde(:,m,k);
        Mutilde_k_squared = Mutilde(:,m,k)*Mutilde(:,m,k)';
        var_est(:,:,m) = var_est(:,:,m) + Beta(k,m) * (Mutilde_k_squared +  Sigmatilde(:,:,k));
    end
    %var_est(:,:,m) = var_est(:,:,m) - y_est(:,m)'*y_est(:,m);
    var_est(:,:,m) = var_est(:,:,m) - y_est(:,m)*y_est(:,m)';
end

end

