function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[P,M] = size(y);

% Compute Mean Square Error
MSE = 0;
for i=1:M
    MSE = MSE + (yest(:,i)-y(:,i))'*(yest(:,i)-y(:,i));
end
MSE = MSE/M;

% Compute Normalized Square Error
VarY = 0;
avgY = sum(y,2)/M;
for i=1:M
    VarY = VarY + (y(:,i)-avgY)'*(y(:,i)-avgY);
end
VarY = VarY / (M-1);

NMSE = MSE / VarY;

% Compute Coefficient of Determination
Rsquared = 0;
avgYest = sum(yest,2)/M;

numerator = 0;
denominator_obs = 0;
denominator_est = 0;
for i=1:M
    numerator = numerator + (y(:,i)-avgY)'*(yest(:,i)-avgYest);
    denominator_obs = denominator_obs + (y(:,i)-avgY)'*(y(:,i)-avgY);
    denominator_est = denominator_est + (yest(:,i)-avgYest)'*(yest(:,i)-avgYest);
end

denominator = denominator_obs * denominator_est;

if denominator ~= 0
    Rsquared = numerator*numerator/denominator;
end













end

