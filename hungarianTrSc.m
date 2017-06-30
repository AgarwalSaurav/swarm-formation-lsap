function [assgn, optAlpha, opt_d, optCost] = hungarianScale(Pi, Sj)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n, n);
for i = 1:n
  for j = 1:n
    costMat(i, j) = - Pi(i, :) * Sj(j, :)';
  end
end
[assgn, cost] = munkres(costMat);
dpS = sum(sum(Pi.^2, 2));
dsS = sum(sum(Sj.^2, 2)); 
v_p = [sum(Pi(:, 1)); sum(Pi(:, 2))];
v_s = [sum(Sj(:, 1)); sum(Sj(:, 2))];
optAlpha = (v_p'*v_s + n*cost)/(v_s'*v_s - n*dsS);
opt_d = (v_p - optAlpha * v_s)/n;
optCost = dpS + optAlpha^2 * dsS + 2 * optAlpha * cost - 2 * v_p' * opt_d + 2 * optAlpha * v_s' * opt_d + n * opt_d' * opt_d;  
end

