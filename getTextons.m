function [ o_textons ] = getTextons( i_trainImgs, i_sampleStep, i_K, i_fb )
%GETTEXTON Summary of this function goes here
%   Detailed explanation goes here

%% get filter responses
disp('* getting filter responses...');
data_cell = cell(size(i_trainImgs, 1), size(i_trainImgs, 2));
for imgInd=1:size(i_trainImgs, 1)
    fprintf('- %d/%d\n', imgInd, size(i_trainImgs, 1));
    smapleStep = i_sampleStep;
    data_cell_s = cell(1, size(i_trainImgs, 2));
    for sInd=1:size(i_trainImgs, 2)
        curImg = i_trainImgs{imgInd, sInd};
        curResp = zeros(size(curImg, 1), size(curImg, 2), size(i_fb, 3));
        for fInd=1:size(i_fb, 3)
            curResp(:, :, fInd) = conv2(curImg, i_fb(:, :, fInd), 'same');
        end
        data_cell_s{1, sInd} = reshape(curResp, [size(curResp, 1)*size(curResp, 2) size(curResp, 3)]);
        data_cell_s{1, sInd} = data_cell_s{1, sInd}(1:round(smapleStep(sInd)):end, :);
    end
    data_cell(imgInd, :) = data_cell_s;
end

%% find textons
data = cell2mat(data_cell(:));
fprintf('* clustering %d data...\n', size(data, 1));
o_textons = vl_kmeans(data', i_K, 'Algorithm', 'Elkan');

%% visualize
fb_c = {};
for i=1:size(i_fb, 3)
    fb_c{i} = i_fb(:, :, i);
end
[tim,tperm] = visTextons(o_textons, fb_c);
figure(20001); clf;
imgarray = cell2mat(reshape({tim{tperm}}, [1 1 1 i_K]));
montage(cell2mat(reshape({tim{tperm}}, [1 1 1 i_K])), 'DisplayRange', [min(imgarray(:)), max(imgarray(:))])
axis image; colorbar;


end

