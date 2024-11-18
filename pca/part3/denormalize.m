function [Xinversed] = denormalize(X, param1, param2, normalization)
%DENORMALIZE Denormalize the data wrt to the normalization technique passed in
%parameter and param1 and param2 calculated during the normalization step
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o X : (N x M), normalized data of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : first parameter of the normalization 
%       o param2 : second parameter of the normalization
%
%   output ----------------------------------------------------------------
%
%       o Xinversed : (N x M), the denormalized data

if normalization == "minmax"
    Xmin = param1;
    Xmax = param2;
    
    Xinversed = zeros(size(X));
    for i=1:size(X,1)
        Xinversed(i,:) = X(i,:).*(Xmax(i)-Xmin(i)) + Xmin(i);
    end
    
    %Xinversed = X.*(Xmax-Xmin) + Xmin;
end

if normalization == "zscore"
    mu = param1;
    stdev = param2;
    
    
    Xinversed = zeros(size(X));
    for i=1:size(X,1)
        Xinversed(i,:) = X(i,:).*stdev(i) + mu(i);
    end

    %Xinversed = X.*stdev + mu;
end

if normalization == "none"
    Xinversed = X;
end



end

