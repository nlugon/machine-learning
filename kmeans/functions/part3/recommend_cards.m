function [cards] = recommend_cards(deck, Mu, type)
%RECOMMAND_CARDS Recommands a card for the deck in input based on the
%centroid of the clusters
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N, 1) a deck of card
%       o Mu : (M x k) the centroids of the k clusters
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o cards : a set of cards recommanded to add to this deck
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist = deck_distance(deck, Mu, type);

[~,closest_cluster_idx] = min(dist,[],1);

closest_cluster = Mu(:,closest_cluster_idx);

nnzero_cluster = [];
idx_cluster = [];
for i=1:size(closest_cluster,1)
    if closest_cluster(i,1) ~=0
        nnzero_cluster = [nnzero_cluster;closest_cluster(i,1)];
        idx_cluster = [idx_cluster;i]; % each element of idx_cluster corresponds to a card in unique_card cell array 
    end
end

[sorted_cluster,idx] = sort(nnzero_cluster,"descend");
%Xsorted = Xshuffled(idx,:);
cards = idx_cluster(idx,:);


%nnzero_cluster = closest_cluster(closest_cluster~=0);
%sorted_cluster = sort(nnzero_cluster,"descend")



end

