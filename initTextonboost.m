function [ o_tbParams_parts ] = initTextonboost( i_tbParams_layoutFilterWH, i_tbParams_nParts )
%INITTEXTONBOOST Summary of this function goes here
%   Detailed explanation goes here

o_tbParams_parts = [];
tbWH = i_tbParams_layoutFilterWH;
for pInd=1:i_tbParams_nParts
    xs = [0; 0];
    while xs(1) == xs(2)
        xs = randi(tbWH(1), [2, 1]);
    end
    
    ys = [0; 0];
    while ys(1) == ys(2)
        ys = randi(tbWH(2), [2, 1]);
    end
    
    o_tbParams_parts = [o_tbParams_parts [min(xs); max(xs); min(ys); max(ys)]];
end

end

