close all
clear all
savePlots = 1;
%% Enter number of robots
%n = input('');
n = 4;
if(n>10)
  disp('The number of robots is large and it might take a long time in MATLAB')
  return;
end
Rrad = 0.5;
%
fig_gui = figure('Name', 'Environment');
set(gcf,'render','painters')
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(0,'defaulttextinterpreter','latex')
set(gca,'fontsize',32)
set(gcf,'color','white')
axis equal;
axis_limits = [-6, 10, -5, 5];
axis(axis_limits);
hold on;
ax = gca;
ax.TickLabelInterpreter='latex';
grid on
xlabel('$X$-axis');
ylabel('$Y$-axis');
%% Get the initial positions
Pi = [0, 4; 0, 1; 0, -1; 0, -4];
sjG = zeros(n, 2);
th = linspace(0,2*pi);
for i = 1:n
  hPiC(i) = plot(Pi(i, 1) + Rrad*cos(th), Pi(i, 2) + Rrad*sin(th), 'LineWidth', 4, 'Color', [0 0.4470 0.7410]);
  hPiM(i) = plot(Pi(i,1), Pi(i, 2), '+', 'MarkerSize', 16, 'LineWidth', 5, 'Color', [0 0.4470 0.7410]);
end

sjG = [0,0; 0, -6; 10, -6; 10, 0];
%% Get the desired shape
%for i = 1:n
%  hsjGC(i) = plot(sjG(i, 1) + Rrad*cos(th), sjG(i, 2) + Rrad*sin(th), 'LineWidth', 1.5);
%  hsjGM(i) = plot(sjG(i, 1), sjG(i, 2), 'o', 'MarkerSize', 8, 'LineWidth', 2);
%end
sjGT = [sjG; sjG(1,:)];
d0 = sjG(1, :);
Sj = sjG - d0;
[optPerm, opt_d optCost] = hungarianTranslation(Pi, Sj)

fjG = Sj + opt_d';
Gi = fjG;
Gi = Gi(optPerm, :);
%plot_final_soln
plot_trans_ICRA
