function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = size(cluster_labels,2);

% number of members of each cluster :
nClusters = max(cluster_labels,[],2);

% number of members of each class : 
nClasses = max(class_labels,[],2);

% matrix whose colums are equal to zero except at the row corresponding to
% the cluster number that the datapoint is assigned to
cluster_table = zeros(nClusters,M);
for j=1:M
    cluster_table(cluster_labels(j),j) = 1;
end
k = sum(cluster_table,2); % size 1xnCluster


% matrix whose colums are equal to zero except at the row corresponding to
% the class number that the datapoint is assigned to
class_table = zeros(nClasses,M);
for j=1:M
    class_table(class_labels(j),j) = 1;
end
ci = sum(class_table,2); % size 1xnClass

nik = zeros(nClusters,nClasses);
%R = zeros(nClusters,nClasses);
%P = zeros(nClusters,nClasses);
F1 = zeros(nClusters,nClasses);

for i=1:nClasses
    for j=1:nClusters
        for l=1:M
        if class_labels(l) == i && cluster_labels(l) == j
            nik(j,i) = nik(j,i) + 1;
        end
        end
    end
end



R = nik ./ ci'; % could be ci
P = nik ./ k; % could be k'

for i=1:nClasses
    for j=1:nClusters
        if (R(j,i)+P(j,i)) ~= 0
            F1(j,i) = 2*R(j,i)*P(j,i)/(R(j,i)+P(j,i));
        else
            F1(j,i) = 0;
        end


    end
end

max_F1 = max(F1,[],1); % or along dim1? this should output a nClassesx1 vector
F1_overall = max_F1 * ci / M ;



end
