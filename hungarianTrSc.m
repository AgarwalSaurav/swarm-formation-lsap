function [assgn, optAlpha, opt_d, optCost] = hungarianScale(Pi, Sj, Rrad, alphaRange, transRange)
  n = size(Pi, 1);
  % Get cost matrix in terms of alpha
  costMat = zeros(n, n);
  for i = 1:n
    for j = 1:n
      costMat(i, j) = - Pi(i, :) * Sj(j, :)';
    end
  end
  % Get alphMin
  alphaMin = 0;
  for i = 1:n
    for j = 1:n
      if i~=j
        distSij = norm(Sj(i, :) - Sj(j, :));
        alphaRatio = 2*sqrt(2)*Rrad/distSij;
        if(alphaRatio > alphaMin)
          alphaMin = alphaRatio;
        end
      end
    end
  end
  alphaMin

  [assgn, pseudoCost] = munkres(costMat);

  dpS = sum(sum(Pi.^2, 2));
  dsS = sum(sum(Sj.^2, 2)); 

  dim = size(Pi, 2);
  if dim == 2
    v_p = [sum(Pi(:, 1)); sum(Pi(:, 2))];
    v_s = [sum(Sj(:, 1)); sum(Sj(:, 2))];
    hessianMat = 2.*[dsS, v_s(1), v_s(2); v_s(1), n, 0; v_s(2), 0, n];
    fVec = [2 * pseudoCost; -2 * v_p(1); -2 * v_p(2)];
    lb = [alphaMin, -Inf, -Inf]
    ub = [Inf, Inf, Inf];
  end

  if dim == 3
    v_p = [sum(Pi(:, 1)); sum(Pi(:, 2)); sum(Pi(:, 3))];
    v_s = [sum(Sj(:, 1)); sum(Sj(:, 2)); sum(Sj(:, 3))];
    hessianMat = 2.*[dsS, v_s(1), v_s(2), v_s(3); v_s(1), n, 0, 0; v_s(2), 0, n, 0; v_s(3), 0, 0, n];
    fVec = [2 * pseudoCost; -2 * v_p(1); -2 * v_p(2); -2 * v_p(3)];
    lb = [alphaMin, -Inf, -Inf, -Inf]
    ub = [Inf, Inf, Inf, Inf];
  end

  if length(alphaRange) == 2
    if alphaMin < alphaRange(1)
      lb(1) = alphaRange(1);
    end
  end

  for i = 1: size(transRange, 1)
    lb(i + 1) = transRange(i, 1);
    ub(i + 1) = transRange(i, 2);
  end

  [x, fval, exitflag, output, lambda] = ...
  quadprog(hessianMat, fVec, [], [], [], [], lb, ub);


  if dim == 2
    opt_d = [x(2); x(3)];
  else
    opt_d = [x(2); x(3); x(4)];
  end

  optAlpha = x(1);
  optCost = fval + dpS;

end

