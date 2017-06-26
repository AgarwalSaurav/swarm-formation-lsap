function [assgn, optAlpha, optCost] = hungarianScale(Pi, Sj, d0)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n, n);
for i = 1:n
  for j = 1:n
    costMat(i, j) = getLSAPCostScaleSf(Pi(i, :), Sj(j, :));
  end
end
[assgn, cost] = munkres(costMat);
Aval = sum(sum(Sj.^2, 2));
Bval = (sum(Sj*d0') + cost)*2;
Cval = sum(sum((Pi - d0).^2, 2));
optAlpha = -Bval/(2*Aval);
optCost = -Bval^2/(4*Aval) + Cval;
end

