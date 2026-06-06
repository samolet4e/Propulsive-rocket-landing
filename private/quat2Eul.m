% https://automaticaddison.com/how-to-convert-a-quaternion-into-euler-angles-in-python/
function [y] = quat2Eul(q) % sequence ZYX only

    q = q / norm(q,2);
    qw = q(1);
    qx = q(2);
    qy = q(3);
    qz = q(4);

    theta = asin(2.*(qw*qy - qx*qz));
    if (theta >= pi/2.)
        phi = 0.; psi = -2.*atan2(qx,qw);
    elseif (theta <= -pi/2.)
        phi = 0.; psi = 2.*atan2(qx,qw);
    else
        phi = atan2(2.*(qw*qx + qy*qz),qw^2. - qx^2. - qy^2. + qz^2.);
        psi = atan2(2.*(qw*qz + qx*qy),qw^2. + qx^2. - qy^2. - qz^2.);
    end

    y = [phi,theta,psi];

endfunction
