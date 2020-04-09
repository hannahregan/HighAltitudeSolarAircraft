clear all; close all; clc

% Variables

m = 7; % Mass, in kilograms
g = 9.81; % Acceleration due to gravity, in ms^2
cL = 0.02354; % Lift coefficient, taken from datcom out file
p = 0.08891; % Air density at altitude 20km, in kg/m^3
S = 9 + 0.25; % Top surface area of wing and tail in m^2. Might need to include body for accuracy but assumed to be negligible

cD = 0.05; % Dummy number, taken from https://www.engineeringtoolbox.com/drag-coefficient-d_627.html

% Calculating minimum speed

v = sqrt(2*m*g/cL*p*S);
disp(v)

% Calculating power for level flight

Plev = (cD/cL^(3/2))*sqrt(((m*g)^3)/S)*sqrt(1/p);
disp(Plev)