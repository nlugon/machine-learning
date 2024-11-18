function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%   
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization


if normalization == "minmax"
    switch nargin
        case 4
            Xmin = param1;
            Xmax = param2;
        case 2
            Xmin = min(data,[],2); %column vector whose rows are the min values of each features (or rows) of the data matrix
            Xmax = max(data,[],2);

    end

    X = zeros(size(data));
    for i=1:size(data,1)
        X(i,:) = (data(i,:)-Xmin(i))./(Xmax(i)-Xmin(i));
    end

    %X = (data - Xmin)/(Xmax-Xmin);
    param1 = Xmin;
    param2 = Xmax;
end

if normalization == "zscore"
    switch nargin
        case 4
            mu = param1;
            stdev = param2;
           
        case 2
            mu = mean(data,2);
            stdev = std(data,0,2);
    end
    
    X = zeros(size(data));
    for i=1:size(data,1)
        X(i,:) = (data(i,:)-mu(i))./stdev(i);
    end
    %X = (data - mu)./stdev;
    param1 = mu;
    param2 = stdev;
end

if normalization == "none"
    switch nargin
        case 2
            X = data;
    end

    param1 = 0;
    param2 = 0;
end

end

