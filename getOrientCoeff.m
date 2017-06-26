function coeff = getOrientCoeff(pi, sj, d0)

  pix = pi(1);
  piy = pi(2);
  sjx = sj(1);
  sjy = sj(2);

  d0x = d0(1);
  d0y = d0(2);

  eij = (sjx + d0x - pix)^2 + (sjy + d0y - piy)^2;
  fij = 4 * ((d0y - piy) * sjx - (d0x - pix) * sjy);
  gij = ((-d0x + pix + sjx)^2 + (-d0y + piy + sjy)^2);

  coeff = [gij, fij, eij];

end
