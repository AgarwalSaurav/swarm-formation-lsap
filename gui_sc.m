close all
clear all
savePlots = 0;
%% Enter number of robots
%n = input('');
n = inputdlg('Enter number of robots');
n=str2num(n{:});
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
axis equal;
axis_limits = [-10, 10, -10, 10];
axis(axis_limits);
hold on;
ax = gca;
ax.TickLabelInterpreter='latex';
grid on
xlabel('$X$-axis');
ylabel('$Y$-axis');
%% Get the initial positions
Pi = zeros(n, 2);
sjG = zeros(n, 2);
th = linspace(0,2*pi);
waitfor(msgbox('Add initial points'));
for i = 1:n
  Pi(i,:) = ginput(1);
  hPiC(i) = plot(Pi(i, 1) + Rrad*cos(th), Pi(i, 2) + Rrad*sin(th), 'LineWidth', 1.5);
  hPiM(i) = plot(Pi(i,1), Pi(i, 2), '+', 'MarkerSize', 10, 'LineWidth', 2);
end

waitfor(msgbox('Add desired shape points'));
%% Get the desired shape
for i = 1:n
  sjG(i,:) = ginput(1);
  hsjGC(i) = plot(sjG(i, 1) + Rrad*cos(th), sjG(i, 2) + Rrad*sin(th), 'LineWidth', 1.5);
  hsjGM(i) = plot(sjG(i, 1), sjG(i, 2), 'o', 'MarkerSize', 8, 'LineWidth', 2);
end
sjGT = [sjG; sjG(1,:)];
hPolyPi = line(sjGT(:,1), sjGT(:, 2), 'Color', [0.8500    0.3250    0.0980]);
waitfor(msgbox('Proceed to compute optimal assignment and scale?'));
d0 = sjG(1, :);
Sj = sjG - d0;
[optPerm, optAlpha, optCost] = hungarianScale(Pi, Sj, d0)

fjG = optAlpha.*Sj + d0;
Gi = fjG;
Gi = Gi(optPerm, :);
fjG = Gi;
%plot_final_soln
plot_final_config
global button
global FAILED;
button = questdlg('Show animation?');
drawnow()
while(strcmp(button, 'Yes'))
  animate_llbap
  if(FAILED)
    break;
  end
  button = questdlg('Show animation again?');
  if(strcmp(button, 'No'))
    break;
  end
end
% fg = figure;  
% t1 = uitable('Position', [20, 20, 1500, 900]); 
% drawnow;
% set(t1, 'Data', [constraintsA, constB]);      
