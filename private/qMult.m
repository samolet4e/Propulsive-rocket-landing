function [q] = qMult(r, s)

    qw = r(1)*s(1) - r(2)*s(2) - r(3)*s(3) - r(4)*s(4);
    qx = r(1)*s(2) + r(2)*s(1) + r(3)*s(4) - r(4)*s(3);
    qy = r(1)*s(3) - r(2)*s(4) + r(3)*s(1) + r(4)*s(2);
    qz = r(1)*s(4) + r(2)*s(3) - r(3)*s(2) + r(4)*s(1);

    q = [qw,qx,qy,qz];

endfunction
