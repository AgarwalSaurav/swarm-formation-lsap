figure(1)
xlimL = min([min(Pi(:,1)), min(fjG(:,1)), min(sjG(:,1))])-2*Rrad;
xlimU = max([max(Pi(:,1)), max(fjG(:,1)), max(sjG(:,1))])+2*Rrad;
ylimL = min([min(Pi(:,2)), min(fjG(:,2)), min(sjG(:,2))])-2*Rrad;
ylimU = max([max(Pi(:,2)), max(fjG(:,2)), max(sjG(:,2))])+2*Rrad;
lLim = min(xlimL, ylimL);
uLim = max(xlimU, ylimU);
%axis([xlimL, xlimU, ylimL, ylimU]);
axis([lLim, uLim, lLim, uLim])
for i = 1:n
  hsjGC(i).Color = [0.5, 0.5, 0.5];
  hsjGM(i).Color = [0.5, 0.5, 0.5];
  hfiC(i) = plot(fjG(i, 1) + Rrad*cos(th), fjG(i, 2) + Rrad*sin(th), 'LineWidth', 1.5);
  hfiM(i) = plot(fjG(i,1), fjG(i, 2), 'x', 'MarkerSize', 10, 'LineWidth', 2);
end
hPolyPi.Color=[0.5, 0.5, 0.5];
fjGT = [fjG; fjG(1,:)];
hPolyf = line(fjGT(:,1), fjGT(:,2), 'Color', [0.8500    0.3250    0.0980]);
for i = 1:n
  line([Pi(i,1), fjG(i,1)], [Pi(i,2), fjG(i,2)])
end

axis equal;
axis(axis_limits);

title('\bf Final configuration: $+$ - initial pos., $\times$ - final pos., o - shape config. ');
xlabel('$X$-axis');
ylabel('$Y$-axis');
for i = 1:n
  txtIdx(i) = text(Pi(i, 1), Pi(i, 2), num2str(i), 'FontSize', 14);
end
hold off
if(savePlots)
  print -depsc2 final_config.eps
  print -dpdf final_config.pdf 
end
