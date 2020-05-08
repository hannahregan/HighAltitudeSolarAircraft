%clear all; close all; clc

V_max = 30;
V_min = 0;

% AERODYNAMIC PARAMETERS XFLR5
% AoA set to 2 deg
% Cl = 0.815;
A_ref_w = 1.768;      % reference area m^2
lvl_v_min = 8.76;     % minimum speed for level flight 
V_step = 0.01;

% coefficents corespond to 2m/s steps from 0 m/s - 30 m/s
Cd_wing = [0.000,0.156,0.068,0.049,...
    0.037,0.032,0.029,0.026,0.025,0.023,...
    0.022,0.022,0.021,0.021,0.020,0.020]; 

% AERO DYNAMIC PARAMETERS OPEN ROCKET
% surface roughness Rs = 60 uF
a = 343; % sea level
d_ref = 0.09;
A_ref_b = pi * (d_ref/2)^2;

% One to one correspondance between Mach and coefficents
Mach = [0,0.01,0.02,0.04,0.05,0.06,0.07,0.08,0.1]; 
Cd_fuse = [0.48,0.20,0.17,0.15,0.15,0.15,0.15,0.15,0.15];

% DRAG FROM WING
velocity_w = (V_min:2:V_max); % m/s
rho = 1.225;       % air density kg/m^3
F_w = (1/2*A_ref_w*rho)*Cd_wing.*velocity_w.^2;

% DRAG FROM BODY
velocity_b = Mach.*a; % m/s
F_b = (1/2*A_ref_b*rho)*Cd_fuse.*velocity_b.^2;

% INTERPOLATING
velocity = (V_min:V_step:V_max);
F_w_interp = interp1(velocity_w,F_w,velocity, 'spline');
F_b_interp = interp1(velocity_b,F_b,velocity, 'spline');

F = F_w_interp + F_b_interp;

total_P = velocity.*F;
wing_P = velocity.*F_w_interp;
body_P = velocity.*F_b_interp;

lvl_ii = lvl_v_min/V_step;

figure(1)
hold on

p_Luke=plot(velocity,total_P,'r',velocity,wing_P,'r--',velocity,body_P,'r-.');
plot(velocity(lvl_ii),total_P(lvl_ii),'r*')

title('Power Consumption at Level Flight, AOA = 2 deg');


hold off

