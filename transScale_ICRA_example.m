close all
clear all
savePlots = 1;

%% Enter number of robots
%n = input('');
n = 10;
Rrad = 0.5;

%
%% Get the initial positions
% Two column arrangement
Pi = [0, 0; 0, 2; 0, 4; 0, 6; 0, 8; 2, 0; 2, 2; 2, 4; 2, 6; 2, 8];
% Swapping x and y for row arrangement
PiT = Pi(:, 1);
Pi(:, 1) = Pi(:, 2);
Pi(:, 2) = PiT;

%% Get the desired shape
%for i = 1:n
%  hsjGC(i) = plot(sjG(i, 1) + Rrad*cos(th), sjG(i, 2) + Rrad*sin(th), 'LineWidth', 1.5);
%  hsjGM(i) = plot(sjG(i, 1), sjG(i, 2), 'o', 'MarkerSize', 8, 'LineWidth', 2);
%end
sjG = starPoly();
d0 = sjG(1, :)';
Sj = sjG - d0'; 
[optPerm,optAlpha,  opt_d optCost] = hungarianTrSc(Pi, Sj, Rrad, [], []);

fjG = optAlpha*Sj + opt_d';
Gi = fjG;
Gi = Gi(optPerm, :);
%plot_final_soln
plotAllConfig

global button
global FAILED;
button = questdlg('Show animation?');
drawnow()
while(strcmp(button, 'Yes'))
  animate_straightLine
  if(FAILED)
    break;
  end
  button = questdlg('Show animation again?');
  if(strcmp(button, 'No'))
    break;
  end
end
%
