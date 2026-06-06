function u = pidQuat(quat,W,dt)

  global setPointQuat

    % Init PID controller
%    persistent errSum = [0.,0.,0.];

    Kp = [0.,5e-02,0.];
%    Ki = [0.,0.,0.];
    Kd = [0.,5e-02,0.];

    error = qMult(quatConj(setPointQuat),quat);
    error = error(2:4);
%    errSum += error*dt;
    dErr = -W';

    u = Kp.*error + Kd.*dErr;

endfunction
