matlab_GetMyColor
xlimL = floor(min([min(Pi(:,1)), min(fjG(:,1))])-2*Rrad);
xlimU = ceil(max([max(Pi(:,1)), max(fjG(:,1))])+2*Rrad);
ylimL = floor(min([min(Pi(:,2)), min(fjG(:,2))])-2*Rrad);
ylimU = ceil(max([max(Pi(:,2)), max(fjG(:,2))])+2*Rrad);
lLim = ceil(min(xlimL, ylimL));
uLim = ceil(max(xlimU, ylimU));
axis_limits = [xlimL, xlimU, ylimL, ylimU];

fig_gui = generateGui(axis_limits, 32);

th = linspace(0,2*pi);
for i = 1:n
  hPiC(i) = plot(Pi(i, 1) + Rrad*cos(th), Pi(i, 2) + Rrad*sin(th), 'LineWidth', 1.5, 'Color', myBlue);
  hPiM(i) = plot(Pi(i,1), Pi(i, 2), '+', 'MarkerSize', 16, 'LineWidth', 3, 'Color', myBlue);
end


for i = 1:n
  hsjGC(i).Color = [0.5, 0.5, 0.5];
  hsjGM(i).Color = [0.5, 0.5, 0.5];
  hfiC(i) = plot(fjG(i, 1) + Rrad*cos(th), fjG(i, 2) + Rrad*sin(th), 'LineWidth', 1.5, 'Color', myOrange);
  hfiM(i) = plot(fjG(i,1), fjG(i, 2), 'x', 'MarkerSize', 18, 'LineWidth', 3, 'Color', myOrange);
end
fjGT = [fjG; fjG(1,:)];
hPolyf = line(fjGT(:,1), fjGT(:,2),'LineStyle', '-', 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.5);
for i = 1:n
  lineA =line([Pi(i,1), Gi(i,1)], [Pi(i,2), Gi(i,2)],'Color', [0.5 0.5 0.5],'LineStyle', ':', 'LineWidth', 1.5);
end

axis equal;
axis(axis_limits);
%
%title('\bf Final configuration: $+$ - initial pos., $\times$ - final pos., o - shape config. ');
xlabel('$X$-axis');
ylabel('$Y$-axis');
lgd = legend( [hPolyf, hPiM(2), hfiM(1), lineA],  'Goal formation', 'Initial positions', 'Goal positions', 'Assignment');
set(lgd,'Interpreter','Latex');
lgd.FontSize = 14;
for i = 1:n
  %txtIdx(i) = text(Pi(i, 1)-1.1*Rrad, Pi(i, 2)+1.1*Rrad, num2str(i), 'FontSize', 14);
  %txtIdxfjG(i) = text(fjG(i, 1)-1.1*Rrad, fjG(i, 2)+1.1*Rrad, num2str(i), 'FontSize', 14);
end
hold off
if(savePlots)
  print -depsc2 lsap_transSc_eg.eps
  print -dpdf -fillpage lsap_transSc_eg.pdf 
end
