function [ExpVar, CumVar, p_opt] = explained_variance(EigenValues, var_threshold)
%EXPLAINED_VARIANCE Function that returns the optimal p given a desired
%   explained variance.
%
%   input -----------------------------------------------------------------
%   
%       o EigenValues     : (N x 1), Diagonal Matrix composed of lambda_i 
%       o var_threshold   : Desired Variance to be explained
%  
%   output ----------------------------------------------------------------
%
%       o ExpVar  : (N x 1) vector of explained variance
%       o CumVar  : (N x 1) vector of cumulative explained variance
%       o p_opt   : optimal principal components given desired Var


sum_EigenValues = sum(EigenValues);
ExpVar = EigenValues/sum_EigenValues;
CumVar = cumsum(ExpVar);
p_opt = 1;
for i=1:length(CumVar)
    if CumVar(p_opt) > var_threshold
        break
    end
    p_opt = p_opt+1;
end


end

