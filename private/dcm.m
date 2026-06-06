% R = quat2rotm(q); // MatLab equivalent
function [R] = dcm(q)
%{
    q1 = q*q';
    sqrt1 = sqrt(q1);
    q = q/sqrt1;
%}

    q = q / norm(q,2);

    qw = q(1); qx = q(2); qy = q(3); qz = q(4);

    expr = 'inhomogeneous';

    switch expr

    case 'inhomogeneous'

        r11 = 1. - 2.*(qy^2 + qz^2);
        r12 = 2.*(qx*qy - qw*qz);
        r13 = 2.*(qw*qy + qx*qz);

        r21 = 2.*(qx*qy + qw*qz);
        r22 = 1. - 2.*(qx^2 + qz^2);
        r23 = 2.*(qy*qz - qw*qx);

        r31 = 2.*(qx*qz - qw*qy);
        r32 = 2.*(qw*qx + qy*qz);
        r33 = 1. - 2.*(qx^2 + qy^2);

    case 'homogeneous'

        r11 = qw^2 + qx^2 - qy^2 - qz^2;
        r12 = 2.*(qx*qy - qw*qz);
        r13 = 2.*(qw*qy + qx*qz);

        r21 = 2.*(qx*qy + qw*qz);
        r22 = qw^2 - qx^2 + qy^2 - qz^2;
        r23 = 2.*(qy*qz - qw*qx);

        r31 = 2.*(qx*qz - qw*qy);
        r32 = 2.*(qw*qx + qy*qz);
        r33 = qw^2 - qx^2 - qy^2 + qz^2;

    case 'kuipers'

        r11 = 2.*(qw^2. + qx^2.) - 1.;
        r12 = 2.*(qx*qy - qw*qz);
        r13 = 2.*(qx*qz + qw*qy);

        r21 = 2.*(qx*qy + qw*qz);
        r22 = 2.*(qw^2. + qy^2) - 1.;
        r23 = 2.*(qy*qz - qw*qx);

        r31 = 2.*(qx*qz - qw*qy);
        r32 = 2.*(qy*qz + qw*qx);
        r33 = 2.*(qw^2. + qz^2) - 1.;

    case 'ala-bala'

        p = [qx,qy,qz];
        px = [[0.,qz,-qy];[-qz,0.,qx];[qy,-qx,0.]];
        y = diag(2.*qw^2. - 1.) + 2.*p'*p + 2.*qw*px;
%        vx = [0.,-qz,qy; qz,0.,-qx; -qy,qx,0.];
%        y = v'*v + qw^2.*eye(4) + 2.*qw*vx + vx^2.;
%        y = eye(3) - 2.*qw*vx + 2.*vx^2.;
        r11 = y(1,1); r12 = y(1,2); r13 = y(1,3);
        r21 = y(2,1); r22 = y(2,2); r23 = y(2,3);
        r31 = y(3,1); r32 = y(3,2); r33 = y(3,3);

    endswitch

    R = [r11,r12,r13; r21,r22,r23; r31,r32,r33];

endfunction
