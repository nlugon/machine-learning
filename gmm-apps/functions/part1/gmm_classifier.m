function [Yest] = gmm_classifier(Xtest, models, labels)
%GMM_CLASSIFIER Classifies datapoints of X_test using ML Discriminant Rule
%   input------------------------------------------------------------------
%
%       o Xtest    : (N x M_test), a data set with M_test samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o models    : (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels    : (1 x N_classes) unique labels of X_test.
%   output ----------------------------------------------------------------
%       o Yest  :  (1 x M_test), a vector with estimated labels y \in {0,...,N_classes}
%                   corresponding to X_test.
%%

M_test = size(Xtest,2);
N_classes = length(labels);

Yest = zeros(1,M_test);

prob = zeros(N_classes,M_test);


for c = 1:N_classes
    for k=1:size(models(c).Mu,2)
        prob(c,:) = prob(c,:) + models(c).Priors(:,k).*gaussPDF(Xtest, models(c).Mu(:,k), models(c).Sigma(:,:,k));
    end
    %prob(c,:) = gaussPDF(Xtest, models(c).Mu, models(c).Sigma); % row vector of size 1xM_test
end

loglik = -log(prob);

[~,idx] = min(loglik);

for i=1:M_test
    Yest(i) = labels(idx(i));
end






end