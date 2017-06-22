% Number of robots
n = 3;
pi = [0, 0;...
      1, sqrt(2);...
      2, 5];

sj = [3, 3;...
      4, 4;...
      5, 5];

d0 = [3, 3];

% Get cost matrix in terms of alpha
costMat = zeros(n * n, 3);
for i = 1:n
  for j = 1:n
    costMat((i - 1) * n + j, :) = getScaleCoeff(pi(i, :), sj(j, :), d0);
  end
end

costMatVal = zeros(n * n, 1);
for i = 1:n
  for j = 1:n
    idx = (i - 1) * n + j;
    costMatVal(idx) = polyval(costMat(idx, :), 0.5)
  end
end

% Incidence matrix
A = zeros(2*n, n^2);
for i = 1:n
  A(i, (i-1)*n+1:i*n) = ones(1, n);
  A(n+1:end, (i-1)*n+1:i*n) = eye(n);
end


options = optimoptions('linprog','Algorithm','dual-simplex');

b = ones(2 * n, 1);
lb = double(zeros(n * n, 1));
ub = double(ones(n * n, 1));
[x fval] = linprog(costMatVal, [], [], A, b, lb, ub, options)
[xD, fvalD] = linprog(-b, A', costMatVal,[],[],lb, [], options)
[xD1, fvalD1] = linprog([-b; zeros(n*n, 1)], [], [], [A', eye(n * n, n*n)], costMatVal,zeros(n*n + 2*n,1), [], options)
