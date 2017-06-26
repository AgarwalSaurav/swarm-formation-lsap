close all
clear all
% Number of robots
n = 5;
randomInit
savePlots = 0;
%[optPerm, optAlpha, optCost] = naiveScaleLSAP(Pi, Sj, d0, savePlots)
%[optPerm, optAlpha] = naiveScaleLSAP_sf(Pi, Sj, d0)
[optPerm, optAlpha, optCost] = hungarianScale(Pi, Sj, d0)


