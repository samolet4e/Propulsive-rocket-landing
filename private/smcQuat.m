function [y] = smcQuat(W,q)

  global I setPointQuat

  q = q/norm(q);
  q_conj = [setPointQuat(1),-setPointQuat(2:4)];
  q_err = qMult(q_conj,q);

  % Ensure shortest rotation
  if q_err(1) < 0
     q_err = -q_err;
  end

  qv = q_err(2:4)';

  % Sliding surface
  lambda_att = diag([4 4 4]);
  s_att = W + lambda_att*qv;

  % Saturation
  phi_att = 0.1;
  sat_att = zeros(3,1);

  for i = 1:3

    if abs(s_att(i)/phi_att) <= 1
        sat_att(i) = s_att(i)/phi_att;
    else
        sat_att(i) = sign(s_att(i));
    end

  end

  % Gain
  K_att = diag([2 2 2]);

  % Sliding mode torque
  M = ...
    -lambda_att*W ...
    -K_att*sat_att ...
    + cross(W, I*W);

  [y] = M;
end
