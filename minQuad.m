
function [minVal, minAlpha] = minQuad(polyCoeff)
  
  a = polyCoeff(1);
  b = polyCoeff(2);
  c = polyCoeff(3);
  
  minVal = -(b * b)/(4 * a) + c;
  minAlpha = -b/(2 * a);

end

