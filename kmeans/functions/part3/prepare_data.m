function [X, unique_cards] = prepare_data(data)
%PREPARE_DATA Convert the list of cards and deck to a matrix representation
%             where each row is a unique card and each column a deck. The
%             value in each cell is the number of time the card appears in
%             the deck
%
%   input -----------------------------------------------------------------
%   
%       o data   : (60, M) a dataset of M decks. A deck contains 60 non
%       necesserally unique cards
%
%   output ----------------------------------------------------------------
%
%       o X  : (N x M) matrix representation of the frequency of appearance
%       of unique cards in the decks whit N the number of unique cards in
%       the dataset and M the number of decks
%       o unique_cards : {N x 1} the set of unique card names as a cell
%       array
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
unique_cards = unique(data);
[P,M] = size(data);
N = size(unique_cards,1); % or use numel()
X = zeros(N,M);

data_numerical = zeros(size(data));
for k=1:N % N = 642
    c = string(unique_cards{k});
    for j=1:M % M = 777
        for i=1:P % P = 60
            data_numerical(i,j) = data_numerical(i,j) + (string(data{i,j}) == c)*k; 
        end
    end
end

for j=1:M
    [GC,GR] = groupcounts(data_numerical(:,j));
    for l = 1:numel(GR)
        X(GR(l),j) = GC(l); % = X(GR(l),j) + GC(l);
    end
end








end

