function [assgn, optAlpha, optCost] = hungarianScale(Pi, Sj, d0, Rrad, alphaRange, transRange)
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

  [assgn, pseudoCost] = munkres(costMat);

  dpdS = sum(sum((Pi - d0').^2, 2));
  dsS = sum(sum(Sj.^2, 2)); 

  dim = size(Pi, 2);
  if dim == 2
    v_p = [sum(Pi(:, 1)); sum(Pi(:, 2))];
    v_s = [sum(Sj(:, 1)); sum(Sj(:, 2))];
  end

  if dim == 3
    v_p = [sum(Pi(:, 1)); sum(Pi(:, 2)); sum(Pi(:, 3))];
    v_s = [sum(Sj(:, 1)); sum(Sj(:, 2)); sum(Sj(:, 3))];
  end

  alphaStar = -(pseudoCost + d0'*v_s)/dsS;
  optAlpha = alphaStar;
  if length(alphaRange) == 2
    if alphaRange(1) > alphaMin
      alphaMin = alphaRange(1)
    end

    if alphaMin > alphaStar
      optAlpha = alphaMin;
    elseif alphaMax < alphaStar
      optAlpha = alphaRange(2);
    end
  end

  optCost = dpdS + 2 * optAlpha * d0' * v_s + 2 * optAlpha * pseudoCost + optAlpha^2 * dsS; 

end

