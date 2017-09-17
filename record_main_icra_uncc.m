
close all
clear all

savePlots = 0;
saveData = 1;
%% Enter number of robots
n = 600;
Rrad = 0.25;
%
fig_gui = figure('Name', 'Environment');
set(gcf,'render','painters')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(0,'defaulttextinterpreter','latex')
set(gcf,'color','white')
axis equal;
axis_limits = [-15, 45, -3, 22];
axis(axis_limits);
hold on;
ax = gca;
ax.TickLabelInterpreter='latex';
grid on
xlabel('$X$-axis');
ylabel('$Y$-axis');
%clf
folder_name = './ICRA_VariableFormation_frames/';
%  img = imread(strcat(folder_name, 'titleSlide.png'));
%  imshow(img)
%

%% Get the initial positions
sep = 1;
Pi = zeros(n, 2);
count = 0;
for i = 1:30
  for j = 1:20
    count = count+1;
    Pi(count, :) = [(i-1)*sep, (j-1)*sep];
  end
end
icra_word
sjG = zeros(n, 2);
sjG = uncc_wordPts;
th = linspace(0,2*pi);

if saveData
  csvwrite('PiCordinatesRec.csv', Pi);
  csvwrite('SjCordinatesUNCC.csv', sjG);

  [optPerm, optAlpha,opt_d optCost] = hungarianTrSc(Pi, sjG, Rrad)
  save('rec2uncc.mat', 'optPerm', 'optAlpha', 'opt_d', 'optCost')
end
load('rec2uncc.mat')

flagIcra = 0;
plot_icra_uncc
record_icra

for i=1:n
  %delete(lnP(i))
  delete(hPiC(i))
end
%lnP
hPiC
Pi = Gi;
sjG = icra_wordPts;

if saveData
  csvwrite('PiCordinatesUNCC.csv', Pi);
  csvwrite('SjCordinatesICRA.csv', sjG);
  [optPerm, optAlpha,opt_d optCost] = hungarianTrSc(Pi, sjG, Rrad)
  save('uncc2icra.mat', 'optPerm', 'optAlpha', 'opt_d', 'optCost')
end
load('uncc2icra.mat')

flagIcra = 1;
plot_icra_uncc
record_icra

%record_video
