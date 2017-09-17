
close all
clear all
savePlots = 0;

%% Get the initial positions
Pi=load('R200pi.csv');
sjL=load('R200sj.csv');
d0 = [0, 0, 2];
sjG =sjL + sjL;
[optPerm, optAlpha, opt_d, optCost] = hungarianTrSc(Pi, sjL)
csvwrite('optPermr200.csv', optPerm)
fjG = optAlpha.*sjL + opt_d';
Gi = fjG;
Gi = Gi(optPerm, :);
fjG = Gi;
