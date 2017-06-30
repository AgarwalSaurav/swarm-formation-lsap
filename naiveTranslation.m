function [optPerm, opt_d, optCost] = naiveTranslation (Pi, Sj)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n * n, 3);

optVal = Inf;
optCost = Inf;
allPerms = perms(1:n);

for k = 1:length(allPerms)
  newPerm = allPerms(k, :);
  rn = 1:n;
  Aval = 0;
  Bval = 0;
  Eval = 0;
  for i = 1:n
    j = newPerm(i);
    Aval = Aval + (Pi(i, 1) - Sj(j, 1))^2 + (Pi(i, 2) - Sj(j, 2))^2;
    Bval = Bval - 2*(Pi(i, 1) - Sj(j, 1));
    Eval = Eval - 2*(Pi(i, 2) - Sj(j, 2));
  end
  val = Aval - Bval^2/(4*n) - Eval^2/(4*n);
  if val < optCost
    optCost = val;
    opt_d = [-Bval/(2*n), -Eval/(2*n)];
    optPerm = newPerm;
  end
end 
end
