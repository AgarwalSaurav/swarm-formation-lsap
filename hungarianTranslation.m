function [assgn, opt_d, optCost] = hungarianScale(Pi, Sj)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n, n);
for i = 1:n
  for j = 1:n
    costMat(i, j) = -2 * Pi(i, :) * Sj(j, :)';
  end
end
[assgn, cost] = munkres(costMat);
Aval = sum(sum(Pi.^2, 2)) + sum(sum(Sj.^2, 2)) + cost;
Bval = -2 * (sum(Pi(:, 1)) - sum(Sj(:, 1)));
Eval = -2 * (sum(Pi(:, 2)) - sum(Sj(:, 2)));
opt_d = [-Bval/(2 * n); -Eval/(2 * n)];
optCost = Aval - Bval^2/(4 * n) - Eval^2/(4 * n); 
end

