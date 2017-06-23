function costMatVal = getCostVal(costMat, alpha)
  n = sqrt(length(costMat));
  for i = 1:n
    for j = 1:n
      idx = (i - 1) * n + j;
      costMatVal(idx) = polyval(costMat(idx, :), alpha);
    end
  end
end 
