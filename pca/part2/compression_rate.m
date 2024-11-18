function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements

s_cimg = numel(cimg);
s_ApList = numel(ApList);
s_muList = numel(muList);
s_img = numel(img);

compressedSize = s_cimg + s_ApList + s_muList;
cr = 1-(compressedSize/s_img);

compressedSize = compressedSize * 64;

% convert the size to megabits
compressedSize = compressedSize / 1048576; 
end

