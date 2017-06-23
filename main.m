% Number of robots
n = 3;
pi = [0, 0;...
      1, sqrt(2);...
      2, 5];

sj = [6, 6;...
      4, 4;...
      5, 5];

d0 = [-1, -1];

% Get cost matrix in terms of alpha
costMat = zeros(n * n, 3);
for i = 1:n
  for j = 1:n
    costMat((i - 1) * n + j, :) = getScaleCoeff(pi(i, :), sj(j, :), d0);
  end
end

costMatVal = zeros(n * n, 1);
costMatVal = getCostVal(costMat, 0.5);

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
costNet = costMat.*x;
polyCost = sum(costNet);
[~, optAlpha] = minQuad(polyCost);

costMatVal = getCostVal(costMat, optAlpha);

[xD, fvalD] = linprog(-b, A', costMatVal,[],[],lb, [], options)
bD = [-b; zeros(n * n, 1)];
AD = [A', eye(n * n, n * n)];
[xD1, fvalD1] = linprog(bD, [], [], AD, costMatVal,zeros(n * n + 2 * n,1), [], options)
bscMat = AD(:, xD1 ~= 0);
nonMat = AD(:, xD1 == 0);

CB = bD(xD1 ~= 0);
CN = bD(xD1 == 0);
for kk = 1:10
redCost = CN' - CB'*inv(bscMat)*nonMat;
[minRedCost, redIdx] = min(redCost);
minRedCost
if(minRedCost >= 0)
  break
end
uCol = nonMat(:, redIdx);
invBscMat = inv(bscMat);
BinvU = invBscMat * uCol;
flag = 0;
for i = 1:n
  for j = 1:n
    idx = (i - 1) * n + j;
    if(BinvU(idx) > 0)
      polyCoeff = invBscMat(idx, :) * costMat
      newRatio = -minQuad(polyCoeff) / BinvU(idx);
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
end
temp = nonMat(:, redIdx);
nonMat(:, redIdx) = bscMat(:, minIdx);
bscMat(:, minIdx) = temp;

temp = CN(redIdx);
CN(redIdx) = CB(minIdx);
CB(minIdx) = temp;

end
