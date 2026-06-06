clear all;

% pkg load instrument-control

global invI I m g X_set
global setPointX setPointV setPointQuat
global controller

controller = 'pid'; % Type either 'pid' or 'smc'

Ixy = Iyz = Ixz = 0.;
m = 1.; R = 0.5;
Ixx = Iyy = Izz = 2./5.*m*R^2.; % sphere
I = [
    [Ixx,-Ixy,-Ixz];
    [-Ixy,Iyy,-Iyz];
    [-Ixz,-Iyz,Izz]
    ];
invI = inv(I);

g = 9.80665;

t = linspace(0.,15.,150);

setPointX = [50.,50.,40.];
setPointV = [0.,0.,0.];
setPointQuat = eul2Quat([0.,0.,0.]*pi/180.,'ZYX'); %[1.,0.,0.,0.];

r0 = [0.,0.,100.];
v0 = [0.,0.,0.];
w0 = [0.,0.,0.];
q0 = eul2Quat([0.,180.,0.]*pi/180.,'ZYX'); % ZYX -> psi, theta, phi
q0 = q0/norm(q0);
% Body reference frame, mind! No trigs are necessary.
%    [x, y, z, u, v, w, p, q, r, quat] % Only x,y,z are in inertial frame
ic = [r0,v0,w0,q0];
[t,x] = ode45(@(t,x)f(t,x),t,ic);

T = t; X = x;

t = linspace(15.1,20.,49);

setPointX = [50.,50.,10.];
setPointQuat = eul2Quat([0.,0.,0.]*pi/180.,'ZYX'); %[1.,0.,0.,0.];

r0 = x(end,1:3);
v0 = x(end,4:6);
w0 = x(end,7:9);
q0 = x(end,10:13);
q0 = q0/norm(q0);

ic = [r0,v0,w0,q0];
[t,x] = ode45(@(t,x)f(t,x),t,ic);

T = [T;t]; X = [X;x];
X *= 25;
X(:,3) -= 1295; % FlightGear only

%show(T,X);
animate_body_triad(T,X);
y = flightGearAnime(T,X);
