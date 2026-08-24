function [Voltage,Current] = calculateIV(Iph,I0,n,Rsh,Rs)
% calculateIV simulates the current/voltage (IV) characteristic of a cell
% based on its equivalent circuit parameters
%
% Inputs:
% ------
%   Iph: double
%       The photo-generated current
%   I0: double
%       The saturation current
%   n: double
%       The ideality factor
%   Rsh: double
%       The shunt resistance
%   Rs: double
%       The series resistance
%
% Outputs:
% ------
%   Voltage: double
%       The voltage of the cell IV curve
%   Current: double
%       The current of the cell IV curve
%
% Author: Youri Blom

%Define ranges for voltage and currents
V_range = 0:0.01:2;
Current = 0:0.1:450;

%Define constants
k=1.3806e-23;
q = 1.60217662e-19;
T = 298.15;
Vth=k*T/q;

%Simulate current as a function of voltage
z=(Rs*I0/(n*Vth*(1+Rs/Rsh)))*exp((Rs*(Iph+I0)+V_range)./(n*Vth*(1+Rs/Rsh)));
I=(Iph+I0-V_range/(Rsh))/(1+Rs/Rsh)-lambertw(z).*(n*Vth)/Rs;

%Interpolate to voltage as a function of current
Voltage = interp1(I,V_range,Current,"linear","extrap");

end
