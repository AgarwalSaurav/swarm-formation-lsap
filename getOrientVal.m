
function costMatVal = getOrientVal(costMat, tVal)
  n = sqrt(length(costMat));
  for i = 1:n
    for j = 1:n
      idx = (i - 1) * n + j;
      costMatVal(idx) = polyval(costMat(idx, :), tVal)/(1 + tVal^2);
    end
  end
end 
