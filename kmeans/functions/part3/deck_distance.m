function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,K] = size(Mu);
%dist =  distance_to_centroids(deck, Mu, type);

deck_subset = [];
%idx_subset = [];
Mu_subset = [];

for i=1:N
    if deck(i,1) ~=0
        deck_subset = [deck_subset;deck(i,1)];
        %idx_subset = [idx_subset;i];
        Mu_subset = [Mu_subset;Mu(i,:)];
    end
end

dist =  distance_to_centroids(deck_subset, Mu_subset, type);









end

