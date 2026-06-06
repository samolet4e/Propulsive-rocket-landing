function [y] = flightGearAnime(t,X)

  % pkg load instrument-control

  u = udp("127.0.0.1", 5500);
  fopen(u);

  tSize = size(t);
  i = 1;

  while (i <= tSize(1))

    % quaternion
    quat = X(i,10:13);
    % quat -> Euler angles
    [y] = quat2Eul(quat)*180./pi;
    phi = y(1);
    theta = y(2);
    psi = y(3);

    tt = t(i);

    % POSITION
    lat0 = 42.68;
    lon0 = 23.4;
    alt0 = 3000;

    x = X(i,1);
    y = X(i,2);
    z = X(i,3);
    [lon, lat, alt] = enu2geodetic(x, y, z, lon0, lat0, alt0);

    % ATTITUDE
    roll  = phi;
    pitch = theta;
    yaw   = psi;
%{
    roll  = 10;
    pitch = 2;
    yaw   = 90;
%}
msg = sprintf("%.3f %.8f %.8f %.2f %.3f %.3f %.3f\n", ...
tt, ...
lat, lon, alt, ...
roll, pitch, yaw);

    fwrite(u, msg);

    pause(0.025);
    i += 1;

  end

  y = 0;
end
