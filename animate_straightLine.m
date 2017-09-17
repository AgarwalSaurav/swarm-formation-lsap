for i = 1:n
%  hPlot(i) = plot(NaN,NaN,'r','Linewidth', 1);
  %txtIdx(i) = text(NaN, NaN, num2str(i), 'FontSize', 14);
%  delete(hsjGC(i));
%  delete(hsjGM(i));
  delete(hfiC(i))
end
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
    if exist('txtIdx')
      set(txtIdx(i), 'Position', xit);
    end
    xunit = Rrad * cos(th) + xit(1);
    yunit = Rrad * sin(th) + xit(2);
    set(hPiC(i),'XData',xunit,'YData',yunit,'Linewidth', 1.5);
  end
  pause (0.005);

end
