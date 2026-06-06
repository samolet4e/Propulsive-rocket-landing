function [lon, lat, h] = enu2geodetic(x, y, z, lon0, lat0, h0)
  % ENU2GEODETIC
  %
  % Convert local ENU coordinates (x,y,z)
  % to geodetic coordinates (lon,lat,h)
  %
  % INPUTS:
  %   x,y,z   : local ENU coordinates [m]
  %             x = East
  %             y = North
  %             z = Up
  %
  %   lon0    : reference longitude [deg]
  %   lat0    : reference latitude  [deg]
  %   h0      : reference height    [m]
  %
  % OUTPUTS:
  %   lon     : longitude [deg]
  %   lat     : latitude  [deg]
  %   h       : height    [m]

  % WGS84 constants
  a  = 6378137.0;        % semi-major axis
  f  = 1./298.257223563; % flattening
  e2 = f*(2. - f);       % eccentricity squared

  % Convert reference coordinates to radians
  lon0r = deg2rad(lon0);
  lat0r = deg2rad(lat0);

  % ---- Reference point: geodetic -> ECEF ----

  N = a / sqrt(1 - e2 * sin(lat0r)^2);

  X0 = (N + h0) * cos(lat0r) * cos(lon0r);
  Y0 = (N + h0) * cos(lat0r) * sin(lon0r);
  Z0 = (N * (1 - e2) + h0) * sin(lat0r);

  % ---- ENU -> ECEF ----

  R = [ -sin(lon0r), ...
        -sin(lat0r)*cos(lon0r), ...
         cos(lat0r)*cos(lon0r);

         cos(lon0r), ...
        -sin(lat0r)*sin(lon0r), ...
         cos(lat0r)*sin(lon0r);

         0, ...
          cos(lat0r), ...
          sin(lat0r) ];

  ecef_offset = R * [x; y; z];

  X = X0 + ecef_offset(1);
  Y = Y0 + ecef_offset(2);
  Z = Z0 + ecef_offset(3);

  % ---- ECEF -> geodetic ----

  lonr = atan2(Y, X);

  p = sqrt(X^2 + Y^2);

  latr = atan2(Z, p * (1 - e2));

  % Iterative latitude refinement
  for k = 1:5
    N = a / sqrt(1 - e2 * sin(latr)^2);
    h = p / cos(latr) - N;
    latr = atan2(Z, p * (1 - e2 * N / (N + h)));
  end

  % Final height
  N = a / sqrt(1 - e2 * sin(latr)^2);
  h = p / cos(latr) - N;

  % Convert back to degrees
  lon = rad2deg(lonr);
  lat = rad2deg(latr);

end
