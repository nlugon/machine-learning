function [XNew] = sample_from_gmm(gmm, nbSamples)
%SAMPLE_FROM_GMM Generate new samples from a learned GMM
%
%   input------------------------------------------------------------------
%       o gmm    : (structure), Contains the following fields
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o nbSamples    : (int) Number of samples to generate.
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.
%%
K = size(gmm.Mu,2);
k_range = 1:K;
k_choices = randsrc(nbSamples,1,[k_range;gmm.Priors]);
[k_count,k_values] = groupcounts(k_choices);

XNew = [];
for i=1:size(k_values)
    XNew = [XNew, mvnrnd(gmm.Mu(:,k_values(i)),gmm.Sigma(:,:,k_values(i)),k_count(i))'];
end



end

