function [acc] =  accuracy(y_test, y_est)
%My_accuracy Computes the accuracy of a given classification estimate.
%   input -----------------------------------------------------------------
%   
%       o y_test  : (1 x M_test),  true labels from testing set
%       o y_est   : (1 x M_test),  estimated labes from testing set
%
%   output ----------------------------------------------------------------
%
%       o acc     : classifier accuracy
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_test = size(y_test,2);
acc = 0;

% Compute Classification Accuracy
for i=1:M_test
    acc = acc + (y_test(i) == y_est(i));
end

acc = acc/M_test;


end