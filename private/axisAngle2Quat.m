% [q0] = axisAngle2Quat([7.5,-9.1,-0.25], -31.*%pi/180.);
% [q1] = CL_rot_axAng2quat([7.5,-9.1,-0.25]', -31.*%pi/180.); // CelestLab counterpart

function [q] = axisAngle2Quat(r, theta)

    r = r / norm(r);

    theta05 = theta*0.5;
    qw = cos(theta05);
    qx = r(1)*sin(theta05);
    qy = r(2)*sin(theta05);
    qz = r(3)*sin(theta05);

    q = [qw,qx,qy,qz];

endfunction
