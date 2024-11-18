function [dZ] = cost_derivative(Y, Yd, typeCost, typeLayer)
%COST_DERIVATIVE compute the derivative of the cost function w.r.t to the Z
%value of the last layer
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Yd
%       o Yd (PxM) Ground truth
%       o typeCost (string) type of the cost evaluation function
%       o typeLayer (string) type of the last layer
%   outputs:
%       o dZ (PxM) The derivative dE/dZL



switch typeCost
    case 'LogLoss'
        dZ = Y-Yd;
    case 'CrossEntropy'
        dZ = Y-Yd;
%         syms x
%         f = cost_function(x, Yd, typeCost);
%         Df = diff(f,x);
%         
%         
%         Dfs = subs(Df,Y);
%         Dfd = double(Dfs);
%         dZ = Dfd .* backward_activation(Y, typeLayer);

    otherwise
        error("no corresponding string in cost_function")
end

% 
% dZ = Dfd .* backward_activation(Y, typeLayer);


% syms x
% f = cost_function(x, Yd, typeCost);
% Df = diff(f,x);
% 
% 
% Dfs = subs(Df,Y);
% Dfd = double(Dfs);
% 
% dZ = Dfd .* backward_activation(Y, typeLayer);






% PrintYD = Yd
% PrintY = Y
% [P,M] = size(Y);
% dEA = 0;
% dZ = 0;
% 
% switch typeCost
%     case 'LogLoss'
%         for i=1:M
%             dEA = dEA + Yd(:,i)' * (1./Y(:,i)) + (1 - Yd(:,i))' * ( 1./(Y(:,i)-1) );
%         end
%         dEA = -1/M * dEA;
% 
% end
% 
% dZ = dEA .* backward_activation(Y, typeLayer)
% 
% 
% % syms x
% % dEA = diff(cost_function(x, Yd, typeCost));
% % 
% % S = sym(zeros(size(Y)));
% % 
% % numerator = arrayfun(@(x) dEA, Y);
% % 
% % % % dZ = cost_function(Y, Yd, typeCost) ./ backward_activation(Y, typeLayer);
% % 
% % dZ = numerator .* backward_activation(Y, typeLayer);

%dZ = (Y - Yd) .* Y .* (1-Y);


