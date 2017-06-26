function [minVal, tVal] = getMinOrient(coeff)

  %pix = pi(1);
  %piy = pi(2);
  %sjx = sj(1);
  %sjy = sj(2);

  %d0x = d0(1);
  %d0y = d0(2);

  %eij = (sjx + d0x - pix)^2 + (sjy + d0y - piy)^2;
  %fij = 4 * ((d0y - piy) * sjx - (d0x - pix) * sjy);
  %gij = ((-d0x + pix + sjx)^2 + (-d0y + piy + sjy)^2);
  minVal = 0;

  gij = coeff(1);
  fij = coeff(2);
  eij = coeff(3);

  coeffDerv = [-fij, 2*(gij - eij), fij];
  rootsDerv = roots(coeffDerv);
  val1 = polyval(coeff, rootsDerv(1))/(1 + rootsDerv(1)^2);
  val2 = polyval(coeff, rootsDerv(2))/(1 + rootsDerv(2)^2);
  if(val1 < val2)
    minVal = val1;
    tVal = rootsDerv(1);
  else
    minVal = val2;
    tVal = rootsDerv(2);
  end
  
end

