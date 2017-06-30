figure(1)

hold on
xlimL = min([min(Pi(:,1)), min(Gi(:,1)), min(sjG(:,1))])-2*Rrad;
xlimU = max([max(Pi(:,1)), max(Gi(:,1)), max(sjG(:,1))])+2*Rrad;
ylimL = min([min(Pi(:,2)), min(Gi(:,2)), min(sjG(:,2))])-2*Rrad;
ylimU = max([max(Pi(:,2)), max(Gi(:,2)), max(sjG(:,2))])+2*Rrad;
lLim = min(xlimL, ylimL);
uLim = max(xlimU, ylimU);
%axis([xlimL, xlimU, ylimL, ylimU]);
%axis([lLim, uLim, lLim, uLim])
for i = 1:n
%  hPlot(i) = plot(NaN,NaN,'r','Linewidth', 1);
  %txtIdx(i) = text(NaN, NaN, num2str(i), 'FontSize', 14);
%  delete(hsjGC(i));
%  delete(hsjGM(i));
  delete(hfiC(i))
  hfiM(i).Color = [0.5, 0.5, 0.5];
end
delete(hPolyPi);
delete(hPolyf);
th = 0:pi/100:2*pi;
global FAILED;
if(FAILED)
  return;
end
tic
tRun = 10;
while(toc<tRun)
  for i = 1:n
    a = Pi(i, :);
    b = Gi(i, :);
    v = norm(b - a)/tRun;
    xit = a + v * (toc) * (b - a)/norm(b - a);
    set(txtIdx(i), 'Position', xit);
    xunit = Rrad * cos(th) + xit(1);
    yunit = Rrad * sin(th) + xit(2);
    set(hPiC(i),'XData',xunit,'YData',yunit,'Linewidth', 1);
  end
  pause (0.005);

end
