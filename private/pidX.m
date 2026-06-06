function u = pidX(X,V,dt)

  global setPointX

    % Init PID controller
    persistent errSum = [0.,0.,0.];
%{
    Kp = [0.5,0.5,1];
    Ki = [0.,0.,0.25];
    Kd = [1.,1.,1.5];
%}
    Kp = [0.25,0.25,5];
    Ki = [0.,0.,2];
    Kd = [1.,1.,5];

    error = setPointX - X';
    errSum += error*dt;
    dErr = -V';

    u = Kp.*error + Ki.*errSum + Kd.*dErr;

endfunction

