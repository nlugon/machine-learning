function [Y, Ap] = project_pca(X, Mu, V, p)
%PROJECT_PCA Compute Projection Matrix and Projected data y
%   In this function, the student should construct the projection matrix
%   from the Eigenvectors and the data projected to lower-dimensional space
%
%   input -----------------------------------------------------------------
%   
%       o X      : (N x M), a data set with M samples each being of dimension N.
%       o Mu     : (N x 1), Mean Vector from Original Data
%       o V      : (N x N), Eigenvector Matrix from PCA.
%       o p      :  Number of Components to keep.
%
%   output ----------------------------------------------------------------
%
%       o Y        : (p x M), Projected data set with N samples each being of dimension k.
%       o Ap       : (p x N), Projection Matrix.

%for i=1:size(X,2)
 %   X(:,i)=X(:,i)-Mu;
%end
X = X - Mu;

Ap = V(:,1:p).'; 
%Ap = V(1:p,:);
Y = Ap*X;


end

