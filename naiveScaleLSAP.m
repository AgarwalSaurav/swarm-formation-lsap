function [optPerm, optAlpha, optCost] = naiveScaleLSAP (Pi, Sj, d0, savePlots)
n = size(Pi, 1);
% Get cost matrix in terms of alpha
costMat = zeros(n * n, 3);
for i = 1:n
  for j = 1:n
    idx = (i - 1) * n + j;
    costMat(idx, :) = getScaleCoeff(Pi(i, :), Sj(j, :), d0);
  end
end
optVal = Inf;
optCost = Inf;
allPerms = perms(1:n)

hPlotScaleCost = figure;
figure(hPlotScaleCost);
hPlotScaleCost.Color = 'White';
hold on
for i = 1:length(allPerms)
  newPerm = allPerms(i, :);
  rn = 1:n;
  sumCoeff = sum(costMat((rn - 1) * n + newPerm(rn), :));
  plotAlpha = 0:0.1:3;
  plotVal = polyval(sumCoeff, plotAlpha);
  plot(plotAlpha, plotVal, 'LineWidth', 4);
  [val, alpha] = minQuad(sumCoeff);
  if val < optVal
    optVal = val;
    optAlpha = alpha;
    optPerm = newPerm;
    optCost = polyval(sumCoeff, optAlpha);
  end
end 
set(gcf,'render','painters')
set(0,'defaulttextinterpreter','latex')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'TickLabelInterpreter', 'latex');
set(gca,'fontsize',32)
set(gcf,'color','white')
%title('\bf Plot of cost curves for all permutations of assignment', 'FontSize', 14);
xlabel('Scale parameter ($\alpha$)')
ylabel('Cost as sum of squared distances, $\mathcal C_\alpha(\alpha, \mathbf{X})$')

if(savePlots)
  print -depsc2 plot_scaleCostCurves_perms.eps
  system('epstopdf plot_scaleCostCurves_perms.eps')
  print -dpdf plot_scaleCostCurves_perms.pdf 
end
end
