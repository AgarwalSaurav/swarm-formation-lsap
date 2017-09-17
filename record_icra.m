ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
marg = 50;
rect = [-marg, -marg, pos(3) + 1 * marg, pos(4) - 3 * marg];
hold on

if ~flagIcra
  ax = gca;
  outerpos = ax.OuterPosition;
  ti = ax.TightInset; 
  left = outerpos(1) + ti(1)+20;
  bottom = outerpos(2) + ti(2)-20;
  ax_width = outerpos(3) - ti(1) - ti(3)  -50;
  ax_height = outerpos(4) - ti(2) - ti(4);
  ax.Position = [left bottom ax_width ax_height];
end

th = 0:pi/100:2*pi;

v = zeros(n, 1);
%set(gcf, 'renderer', 'zbuffer');
normI = zeros(n, 1);
tRun = 20;
for i = 1:n
  a = Pi(i, :);
  b = Gi(i, :);
  v(i) = norm(b - a)/tRun;
  normI(i) = norm(b-a);
end
xunitI = Rrad * cos(th);
yunitI = Rrad * sin(th);
loops = 600;
if ~flagIcra
  F(loops) = struct('cdata',[],'colormap',[]);
else
  G(loops) = struct('cdata',[],'colormap',[]);
end
for frameIdx = 1:loops
  for i = 1:n
    a = Pi(i, :);
    b = Gi(i, :);
    xit = a + v(i) * (frameIdx/30) * (b - a)/normI(i);
    xunit = xunitI + xit(1);
    yunit = yunitI + xit(2);
    hPiC(i).XData = xunit;
    hPiC(i).YData = yunit;
  end
  drawnow()
  if ~flagIcra
    %F(frameIdx) = getframe(gca, rect);
    file_name = strcat(folder_name, 'a',num2str(frameIdx));
    print(file_name, '-dpng', '-r100');
    if frameIdx == 1
      print -dpdf -fillpage rec2uncc_start.pdf 
    elseif frameIdx == loops/4
      print -dpdf -fillpage rec2uncc_mid1.pdf 
    elseif frameIdx == loops/2
      print -dpdf -fillpage rec2uncc_mid.pdf 
    elseif frameIdx == loops
      print -dpdf -fillpage rec2uncc_end.pdf 
    end
  else
    %G(frameIdx) = getframe(gca, rect);
    file_name = strcat(folder_name, 'b',num2str(frameIdx));
    print(file_name, '-dpng', '-r100');
    if frameIdx == 1
      print -dpdf -fillpage uncc2icra_start.pdf 
    elseif frameIdx == loops/2
      print -dpdf -fillpage uncc2icra_mid.pdf 
    elseif frameIdx == loops
      print -dpdf -fillpage uncc2icra_end.pdf 
    end
  end
end
ax.Units = 'normalized';
