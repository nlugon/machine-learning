function [rimg] = reconstruct_image(cimg, ApList, muList)
%RECONSTRUCT_IMAGE Reconstruct the image given the compressed image, the
%projection matrices and mean vectors of each channels
%
%   input -----------------------------------------------------------------
%   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%       o cimg : (p x width x 3) The projection of the image on the eigenvectors
%       o ApList : (p x height x 3) The projection matrices for each channels
%       o muList : (height x 3) The mean vector for each channels
%
%   output ----------------------------------------------------------------
%
%       o rimg : The reconstructed image


height_N = size(ApList,2);
width_M = size(cimg,2);

rimg = zeros(height_N,width_M,3);

for i=1:3
    Yproj = cimg(:,:,i);
    Ap = ApList(:,:,i);
    Mu = muList(:,i);
    Xhat = reconstruct_pca(Yproj, Ap, Mu);
    rimg(:,:,i) = Xhat;
end

end

