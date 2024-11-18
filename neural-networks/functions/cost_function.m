function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error

[P,M] = size(Y);

E = 0;

switch type
    case 'LogLoss'
        logloss = Yd .* log(Y) + (1 - Yd) .* log(1 - Y);
        E = -1/M * sum(logloss,2);

    case 'CrossEntropy'
        %Ydmat = one_hot_encoding(Yd);
        xentropy = 0;
        for i=1:M
            for j=1:P
                xentropy = xentropy + Yd(j,i)*log(Y(j,i));
            end
        end
        E = -1/M * xentropy;

    otherwise
        error("no corresponding string in cost_function")
        
end









end