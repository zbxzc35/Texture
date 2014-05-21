function [ o_img ] = getTextonImg( i_img, i_textons )
%GETTEXTONIMG Summary of this function goes here
%   Detailed explanation goes here

%% obtain image responses
fb = makeLMfilters();
resp = zeros(size(i_img, 1), size(i_img, 2), size(fb, 3));
for fInd=1:size(fb, 3)
    resp(:, :, fInd) = conv2(i_img, fb(:, :, fInd), 'same');
end
data = reshape(resp, [size(resp, 1)*size(resp, 2) size(resp, 3)]);

%% obtain texton ids
kdtree = vl_kdtreebuild(i_textons);
IND = vl_kdtreequery(kdtree, i_textons, data');
o_img = reshape(IND, [size(i_img, 1), size(i_img, 2)]);

% %% visualize
% figure(3);
% imagesc(o_img);

end

