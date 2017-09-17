function Sj = starPoly()
  alpha = (2 * pi) / 10; 
  radius = 12;
  starXY = [0, 0];

  Sj = zeros(11, 2);
  for i = 11:-1:0
      r = radius*(mod(i, 2) + 1)/2;
      omega = alpha * i;
      Sj(11 -i +1, 1) = (r * sin(omega)) + starXY( 1 );
      Sj(11 -i +1, 2)  = (r * cos(omega)) + starXY( 2 );
  end
  Sj = -Sj(1:10, :);
end
