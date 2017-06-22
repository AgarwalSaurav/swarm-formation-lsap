function polyCoeff = getScaleCoeff (pi, sj, d0)
  
  pix = pi(1);
  piy = pi(2);
  sjx = sj(1);
  sjy = sj(2);

  d0x = d0(1);
  d0y = d0(2);

  ai = (pix - d0x)^2 + (piy - d0y)^2;
  bij = -2 * ((pix - d0x) * sjx + (piy - d0y) * sjy);
  ej = sjx^2 + sjy^2;

  %Leading coefficient is the first element of the coefficient array
  polyCoeff = [ej, bij, ai];
end
