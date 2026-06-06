function [y] = smcX(X,rdot,CLLB)

  global g m setPointX setPointV

  e_r = X    - setPointX';
  e_v = rdot - setPointV';

  lambda = diag([1.5 1.5 1.5]);
  K = diag([20 20 20]);
  phi = 0.5;
  sat_s = zeros(3,1);

  s = e_v + lambda*e_r;

  for i = 1:3
    if abs(s(i)/phi) <= 1
        sat_s(i) = s(i)/phi;
    else
        sat_s(i) = sign(s(i));
    end
  end

  g_inertial = [0,0,-g]';

  F_inertial = ...
    -m*lambda*e_v ...
    -m*K*sat_s ...
    -m*g_inertial;

  F = CLLB'*F_inertial;

  [y] = F;
end
