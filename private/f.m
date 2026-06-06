function [xdot] = f(t,x)

  global invI I m g
  global controller
  persistent t0 = 0.;

  dt = t - t0;

  X = x(1:3);
  V = x(4:6);
  W = x(7:9);
  quat = x(10:13);

  [CLLB] = dcm(quat); % body -> inertial
  rdot = CLLB*V;

  switch (controller)
    case 'pid'
      F = CLLB'*pidX(X,rdot,dt)';
      M = pidQuat(quat,W,dt)';
    case 'smc'
      F = smcX(X,rdot,CLLB);
      M = smcQuat(W,quat);
    otherwise
    % Code to run if no other cases match
  endswitch
%{
%  F = CLLB'*pidX(X,rdot,dt)';
  F = smcX(X,rdot,CLLB);

%  M = pidQuat(quat,W,dt)';
  M = smcQuat(W,quat);
%}
  G = CLLB'*[0.,0.,-m*g]';

  vdot = (F + G)/m - cross(W,V);
  wdot = invI*(M - cross(W,I*W));

  p = W(1); q = W(2); r = W(3);
  quatdot = qMult(quat,[0.,p,q,r])'*0.5;

  t0 = t;

  xdot = [rdot;vdot;wdot;quatdot];

endfunction
