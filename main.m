close all
clear all
% Number of robots
n = 5;
randomInit
savePlots = 0;
plot_init_config
set(gcf,'render','painters')
set(gcf,'defaulttextinterpreter','latex')
set(gca,'TickLabelInterpreter', 'latex');%[optPerm, optAlpha, optCost] = naiveScaleLSAP(Pi, Sj, d0, savePlots)
%[optPerm, optAlpha] = naiveScaleLSAP_sf(Pi, Sj, d0)
[optPerm, optAlpha, optCost] = hungarianScale(Pi, Sj, d0)

%[optPerm, opt_d, optCost] = naiveTranslation(Pi, Sj)
[optPerm, opt_d, optCost] = hungarianTranslation(Pi, Sj)

