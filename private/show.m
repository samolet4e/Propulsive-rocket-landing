function [y] = show(t,x)
%{
  figure(1);
  plot3(x(:,1),x(:,2),x(:,3),'-','linewidth',2);
  xlabel('X, m'); ylabel('Y, m'); zlabel('Z, m');
  grid on

  figure(2);
  subplot(2,2,1);
  plot(t,x(:,10)); grid on;
  subplot(2,2,2);
  plot(t,x(:,11)); grid on;
  subplot(2,2,3);
  plot(t,x(:,12)); grid on;
  subplot(2,2,4);
  plot(t,x(:,13)); grid on;
%}
  figure(3);
  plot(t,x(:,3)); grid on;

  y = 0;
endfunction
