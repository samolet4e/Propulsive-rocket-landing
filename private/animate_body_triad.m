function animate_body_triad(t,x)

r = x(:,1:3);

q = x(:,10:13);

%% ---------------- FIGURE ----------------
fig = figure(1);

axis equal;
grid on;
hold on;

xlabel('X');
ylabel('Y');
zlabel('Z');

title('Rigid Body Triad Animation');

%% ---------------- TRAJECTORY ----------------
plot3(r(:,1), r(:,2), r(:,3), 'k--', 'LineWidth', 1);
%% ---------------- AXIS LIMITS ----------------

margin = 250;

xmin = min(r(:,1)) - margin;
xmax = max(r(:,1)) + margin;

ymin = min(r(:,2)) - margin;
ymax = max(r(:,2)) + margin;

zmin = min(r(:,3)) - margin;
zmax = max(r(:,3)) + margin;

axis([xmin xmax ymin ymax zmin zmax]);

%view(3);

%% ---------------- TRIAD SIZE ----------------
L = 200;

%% ---------------- INITIAL TRIAD ----------------
R = dcm(q(1,:)');

origin = r(1,:)';

ex = R(:,1);
ey = R(:,2);
ez = R(:,3);

hx = quiver3(origin(1),origin(2),origin(3), ...
             L*ex(1),L*ex(2),L*ex(3), ...
             'r','LineWidth',2);

hy = quiver3(origin(1),origin(2),origin(3), ...
             L*ey(1),L*ey(2),L*ey(3), ...
             'g','LineWidth',2);

hz = quiver3(origin(1),origin(2),origin(3), ...
             L*ez(1),L*ez(2),L*ez(3), ...
             'b','LineWidth',2);

%% ---------------- ANIMATION LOOP ----------------
for k = 1:length(t)

%    if ~isvalid(fig) % Matlab
    if ~isgraphics(fig) % Octave
        disp('Animation stopped: figure closed by user.');
        return;
    end

    origin = r(k,:)';

    R = dcm(q(k,:)');

    ex = R(:,1);
    ey = R(:,2);
    ez = R(:,3);

    %% Update X-axis
    set(hx,...
        'XData',origin(1),...
        'YData',origin(2),...
        'ZData',origin(3),...
        'UData',L*ex(1),...
        'VData',L*ex(2),...
        'WData',L*ex(3));

    %% Update Y-axis
    set(hy,...
        'XData',origin(1),...
        'YData',origin(2),...
        'ZData',origin(3),...
        'UData',L*ey(1),...
        'VData',L*ey(2),...
        'WData',L*ey(3));

    %% Update Z-axis
    set(hz,...
        'XData',origin(1),...
        'YData',origin(2),...
        'ZData',origin(3),...
        'UData',L*ez(1),...
        'VData',L*ez(2),...
        'WData',L*ez(3));

    drawnow;
    view(60, 30); % Azimuth = 60 deg, Elevation = 30 deg

end

end
