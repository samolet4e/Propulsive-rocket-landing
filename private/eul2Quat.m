% q = eul2quat([0.1829,0.8082,-2.75],'ZYX'); // MatLab equivalent
function [y] = eul2Quat(eul,seq)

  switch seq

    case 'ZYX' s = [[0.,0.,1.];[0.,1.,0.];[1.,0.,0.]];
    case 'ZYZ' s = [[0.,0.,1.];[0.,1.,0.];[0.,0.,1.]];
    case 'ZXY' s = [[0.,0.,1.];[1.,0.,0.];[0.,1.,0.]];
    case 'ZXZ' s = [[0.,0.,1.];[1.,0.,0.];[0.,0.,1.]];
    case 'YXY'  s = [[0.,1.,0.];[1.,0.,0.];[0.,1.,0.]];
    case 'YZX'  s = [[0.,1.,0.];[0.,0.,1.];[1.,0.,0.]];
    case 'YXZ'  s = [[0.,1.,0.];[1.,0.,0.];[0.,0.,1.]];
    case 'YZY'  s = [[0.,1.,0.];[0.,0.,1.];[0.,1.,0.]];
    case 'XYX'  s = [[1.,0.,0.];[0.,1.,0.];[1.,0.,0.]];
    case 'XYZ'  s = [[1.,0.,0.];[0.,1.,0.];[0.,0.,1.]];
    case 'XZX'  s = [[1.,0.,0.];[0.,0.,1.];[1.,0.,0.]];
    case 'XZY'  s = [[1.,0.,0.];[0.,0.,1.];[0.,1.,0.]];

  otherwise disp('Invalid sequence.');
  endswitch

  [q1] = axisAngle2Quat(s(1,:), eul(1));
  [q2] = axisAngle2Quat(s(2,:), eul(2));
  [q3] = axisAngle2Quat(s(3,:), eul(3));

  [q] = qMult(qMult(q1, q2), q3);

  y = q;

endfunction
