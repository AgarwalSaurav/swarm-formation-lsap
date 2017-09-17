
d0 = sjG(1, :);
Sj = sjG - d0;

fjG = optAlpha*Sj + opt_d';
Gi = fjG;
Gi = Gi(optPerm, :);

for i = 1:n
  %lnP(i) = line([Pi(i,1), Gi(i,1)], [Pi(i,2), Gi(i,2)],'LineStyle', '-', 'Color', [0.5,0.5,0.5],'LineWidth', 0.5);
end
drawnow
for i = 1:n
  hPiC(i) = plot(Pi(i, 1) + Rrad*cos(th), Pi(i, 2) + Rrad*sin(th), 'LineWidth', 1);
end
drawnow

