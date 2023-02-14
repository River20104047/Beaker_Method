%% This is used for calculating coordinates for beaker method
% 20221025 Created by Zijiang Yang

%% Preparework Space
clc, clear, close all

%% Input data
% Coorinate of Point A and B [Xa,Ya;Xb,Yb]
XY  = [-12504.9	-2896.5
-2904.7	15930.1];

%% Calculation
% Coordinates
Xa  = XY(1,1); Ya = XY(1,2);
Xb  = XY(2,1); Yb = XY(2,2);
D   = sqrt((Xa-Xb)^2 + (Ya-Yb)^2); % distance between A and B

% (1) Solve for Co (center of the plate)
syms x y
eqn1 = sqrt( (x-Xa)^2 + (y-Ya)^2 ) == D/sqrt(2);
eqn2 = sqrt( (x-Xb)^2 + (y-Yb)^2 ) == D/sqrt(2);
sol  = solve([eqn1, eqn2], [x, y]);

Xo   = double(sol.x(1));
Yo   = double(sol.y(1));

% (2) Solve for C0_hat (center of beaker)
syms x y
eqn1 = sqrt((x - Xo)^2 + (y - Yo)^2) == 500;
eqn2 = (Yb - Yo) / (Xb - Xo) == (Yb - y) / (Xb - x);
sol  = solve([eqn1, eqn2], [x, y]);

X0   = double(sol.x(1));
Y0   = double(sol.y(1));

% Results
Z_xy   = [Xo,Yo;X0,Y0];


%% Plot
figure
scatter(Xa,Ya,'filled');
hold on
scatter(Xb,Yb,'filled');
scatter(Xo,Yo,'filled');
scatter(X0,Y0,'filled');
scatter(X0+1000,Y0,'filled');
scatter(X0+2000,Y0,'filled');

text(Xa+500,Ya+500,'A');
text(Xb+500,Yb-700,'B')
text(Xo+500,Yo+500,'Co')
text(X0-500,Y0-500,'C0')
text(X0-500+1000,Y0-500,'C1')
text(X0-500+2000,Y0-500,'C2')

xlabel('X'); ylabel('Y')
axis equal

%% Add plate shape for fun

Xc   = Xo - ( D/sqrt(2) - 2000 );
Yc   = Yo - ( D/sqrt(2) - 2000 );
Dc   = 26000 ; % 2* (D/sqrt(2) - 2000); 
rectangle('Position',[Xc,Yc,Dc,Dc],'Curvature',1)

Xb   = X0 - 12500;
Yb   = Y0 - 12500;
Db   = 12500 * 2;
rectangle('Position',[Xb,Yb,Db,Db],'Curvature',1)

% figure
% scatter(Xo,Yo,'filled');
% hold on
% scatter(X0,Y0,'filled');
% text(Xo+1,Yo-1,'Co')
% text(X0+1,Y0+1,'C0')
% xlabel('X'); ylabel('Y')
% axis equal


grid on





























