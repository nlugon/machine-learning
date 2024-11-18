function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component 
%   Algorithm
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix


% A) DE-MEAN THE DATA
M = size(X,2);
Mu = mean(X.').';
%for i=1:M
 %   X(:,i)=X(:,i)-Mu;
%end
X = X-Mu;
%X = X - repmat(Mu',M,1).';

% B) COMPUTE COVARIANCE MATRIX
C = 1/(M-1).*X*X.';

% C) EIGENVALUE DECOMPOSITION
[EigenVectors,EigenValues] = eig(C,'vector');
[EigenValues,idx] = sort(EigenValues,'descend');
EigenVectors = EigenVectors(:,idx);

end

