clear all

% Number of robots
n = 3;
intI = -10;
intF = 15;
pi = intI + (intF - intI).*randn(n, 2);

sj = intI + (intF - intI).*randn(n, 2);

d0 = intI + (intF - intI).*randn(1,2);

pi = randi([intI intF], n, 2);
sj = randi([intI intF], n, 2);
d0 = randi([intI intF], 1, 2);
% Get cost matrix in terms of alpha
costMat = zeros(n * n, 3);
for i = 1:n
  for j = 1:n
    costMat((i - 1) * n + j, :) = getOrientCoeff(pi(i, :), sj(j, :), d0);
  end
end
optVal = Inf;
allPerms = perms(1:n);
hold off
clf
for i = 1:length(allPerms)
  newPerm = allPerms(i, :);
  rn = 1:n;
  sumCoeff = sum(costMat((rn - 1) * n + newPerm(rn), :));
  plot_pi = -3.1412:0.01:3.1412;
  plot_t = tan(plot_pi/2);
  plotVal = polyval(sumCoeff, plot_t);
  plotVal = plotVal./(1 + plot_t.^2);
  %plotVal = plotVal;
  plot(plot_pi, plotVal);
  hold on
  [val, tval] = getMinOrient(sumCoeff);
  if val < optVal
    optVal = val;
    opt_tVal = tval;
    optPerm = newPerm;
  end
end
costMatVal = zeros(n * n, 1);
costMatVal = getOrientVal(costMat, 2);

% Incidence matrix
A = zeros(2*n, n^2);
for i = 1:n
  A(i, (i-1)*n+1:i*n) = ones(1, n);
  A(n+1:end, (i-1)*n+1:i*n) = eye(n);
end

A = A(1:end-1, :);
options = optimoptions('linprog','Algorithm','dual-simplex');

b = ones(2 * n - 1, 1);
lb = double(zeros(n * n, 1));
ub = double(ones(n * n, 1));
[x fval] = linprog(costMatVal, [], [], A, b, lb, ub, options)
costNet = costMat.*x;
polyCost = sum(costNet);
[cc, min_tVal] = getMinOrient(polyCost);

costMatVal = getOrientVal(costMat, min_tVal);

bscMat = A(:, x ~= 0);
nonMat = A(:, x == 0);
bscMat = [bscMat, nonMat(:, 1:n-1)];
nonMat(:, 1:n-1) = [];

CB = costMat(x ~= 0, :);
CN = costMat(x == 0, :);
CB = [CB; CN(1:n-1, :)];
CN(1:n-1, :) = [];
for kk = 1:10
  redCost_coeff = CN - (CB'*inv(bscMat)*nonMat)';
  redCost = zeros(size(redCost_coeff, 1), 1);
  redCost_tVal = zeros(size(redCost_coeff, 1), 1);
  for i=1:size(redCost_coeff, 1);
    [redCost(i) redCost_tVal(i)] = getMinOrient(redCost_coeff(i, :));
  end

  [minRedCost, redIdx] = min(redCost);
  minRedCost
  if(minRedCost >= 0)
    break
  end
  display('Yes');
  uCol = nonMat(:, redIdx);
  invBscMat = inv(bscMat);
  BinvU = invBscMat * uCol;
  flag = 0;
  for idx = 1:(2*n-1)
      if(BinvU(idx) > 0)
        newRatio =  -invBscMat(idx, :) * b / BinvU(idx);
        if(flag == 0)
          minRatio = newRatio;
          minIdx = idx;
          flag = 1;
        end
        if(newRatio < minRatio)
          minRatio = newRatio;
          minIdx = idx;
        end
      end
  end
  temp = nonMat(:, redIdx);
  nonMat(:, redIdx) = bscMat(:, minIdx);
  bscMat(:, minIdx) = temp;

  temp = CN(redIdx);
  CN(redIdx) = CB(minIdx);
  CB(minIdx) = temp;

end 
