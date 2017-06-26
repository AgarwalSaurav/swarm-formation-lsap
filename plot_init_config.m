figure
set(gcf,'render','painters')
plt = plot(Pi(:,1), Pi(:,2),sjG(:,1), sjG(:,2));
plt(1).LineStyle = 'none';
plt(2).LineStyle = 'none';
plt(1).LineWidth = 2;
plt(2).LineWidth = 2;
plt(1).MarkerSize = 10;
plt(2).MarkerSize = 10;
plt(1).Marker = '+';
plt(2).Marker = 'o';
axis equal;
%axis(axis_limits);
title('\bf Initial configuration: $+$ - initial pos., o - shape config. ');
xlabel('$X$-axis');
ylabel('$Y$-axis');
hold off
if(savePlots)
  print -depsc2 inital_config.eps
  print -dpdf initial_config.pdf 
end
