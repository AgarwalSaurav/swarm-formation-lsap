function [optPerm, optAlpha] = naiveScaleLSAP_sf (Pi, Sj, d0)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n * n, 1);
for i = 1:n
  for j = 1:n
    idx = (i - 1) * n + j;
    costMat(idx) = getLSAPCostScaleSf(Pi(i, :), Sj(j, :));
  end
end
optVal = Inf;
allPerms = perms(1:n);

Aval = sum(sum(Sj.^2, 2));
Bval = sum(Sj*d0');

for i = 1:length(allPerms)
  newPerm = allPerms(i, :);
  rn = 1:n;
  val = sum(costMat((rn - 1) * n + newPerm(rn)));
  if val < optVal
    optVal = val;
    optAlpha = -(Bval + val)/Aval;
    optPerm = newPerm;
  end
end 
end

