function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function

[N,M] = size(Z);
dZ = zeros(size(Z));

switch Sigma
    case 'sigmoid'
        A = 1./(1 + exp(-Z));
        dZ = A .* (1-A);
%         dZ = exp(-Z)./((1 + exp(-Z)).^2);
        
    case 'tanh'
        A = tanh(Z);
        dZ = 1 - (A.*A);

    case 'relu'
        dZ = (Z>0);
        
    case 'leakyrelu'
        dZ = (Z>=0);
        dZ(dZ==0) = 0.01;

    case 'softmax'
        syms x
        f = forward_activation(x, Sigma);
        Df = diff(f,x);
        Dfs = subs(Df,Z);
        dZ = double(Dfs);

    otherwise
        error("no corresponding string in backward_activation")
        
end






end