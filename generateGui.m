function hGui = generateGui(axis_limits, gcaFontSize)
  hGui = figure('Name', 'Environment');
  set(gcf,'render','painters')
  set(gcf,'units','normalized','outerposition',[0 0 1 1])
  set(0,'defaulttextinterpreter','latex')
  set(gcf,'color','white')
  set(gca,'fontsize', gcaFontSize)
  axis equal;
  axis(axis_limits);
  hold on;
  ax = gca;
  ax.TickLabelInterpreter='latex';
  grid on
  xlabel('$X$-axis');
  ylabel('$Y$-axis');
end
