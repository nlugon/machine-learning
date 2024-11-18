function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function
[N,M] = size(Z);

switch Sigma
    case 'sigmoid'
        A = 1./(1 + exp(-Z));
        
    case 'tanh'
        %A = (exp(Z)-exp(-Z)) ./ (exp(Z)+exp(-Z));
        A = tanh(Z);

    case 'relu'
        A = max(0,Z);
        
    case 'leakyrelu'
        A = max(0.01*Z,Z);

    case 'softmax'
        delta =  max(Z,[],1);
        denominator = sum(exp(Z-delta),1);
        A = exp(Z-delta) ./ denominator;

    otherwise
        error("no corresponding string in forward_activation")

end