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
allPerms = perms(1:n);

hPlotScaleCost = figure;
figure(hPlotScaleCost);
hPlotScaleCost.Color = 'White';
hold on
for i = 1:length(allPerms)
  newPerm = allPerms(i, :);
  rn = 1:n;
  sumCoeff = sum(costMat((rn - 1) * n + newPerm(rn), :));
  plotAlpha = 0:0.1:2;
  plotVal = polyval(sumCoeff, plotAlpha);
  plot(plotAlpha, plotVal, 'LineWidth', 2);
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
set(gca,'TickLabelInterpreter', 'latex');
title('\bf Plot of cost curves for all permutations of assignment', 'FontSize', 14);
xlabel('Scale parameter ($\alpha$)', 'FontSize', 12)
ylabel('Cost as sum of square of distances', 'FontSize', 12)

if(savePlots)
  print -depsc2 plot_scaleCostCurves_perms.eps
  print -dpdf plot_scaleCostCurves_perms.pdf 
end
end
