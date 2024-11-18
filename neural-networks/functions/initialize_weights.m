function [W, W0] = initialize_weights(LayerSizes, type)
%INITIALIZE_WEIGHTS Initialize the wieghts of the network according to the
%desired type of initialization
%   inputs:
%       o LayerSizes{L+1x1} Cell array containing the sizes of each layers.
%       Also contains the size of A0 input layer
%       o type (string) type of the desired initialization
%       ('random' or 'zeros')
%
%   outputs:
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers


N = LayerSizes{1};
P = LayerSizes{end};
L = length(LayerSizes)-1;

W = cell(L,1);
W0 = cell(L,1);


switch type
    case 'random'
        for i=1:L
            W{i} = randn(LayerSizes{i+1},LayerSizes{i});
            W0{i} = randn(LayerSizes{i+1},1);
        end
        
    case 'zeros'
        for i=1:L
            W{i} = zeros(LayerSizes{i+1},LayerSizes{i});
            W0{i} = zeros(LayerSizes{i+1},1);
        end

    otherwise
        error("no corresponding string in initialize_weights")
end
