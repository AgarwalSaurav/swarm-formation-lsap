close all
clear all
savePlots = 1;
%% Enter number of robots
%n = input('');
n = 3;
Rrad = 0.5;
%
%% Get the initial positions
Pi = [-6, -6; -4, -6; -2, -6];

%% Get the desired shape
sjG = [0, 4; -2, 0; 3, 0];

d0 = sjG(1, :)';
Sj = sjG - d0';
[optPerm, optAlpha, optCost] = naiveScaleLSAP(Pi, Sj, d0, savePlots)
[optPerm, optAlpha, optCost] = hungarianScale(Pi, Sj, d0, [], [])

fjG = optAlpha.*Sj + d0';
Gi = fjG;
fjG = fjG(optPerm, :);
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
