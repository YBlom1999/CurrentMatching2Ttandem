function J0 = calculateJ0(Eg,T,Eg_ref,J0_ref)
% calculateJ0 calculates the needed saturation current density (J0)
% corresponding to a certain bandgap energy.
% A reference bandgap energy and J0 is needed to get the constant
%
% Inputs:
% ------
%   Eg: double
%       The desired bandgap energy
%   T: double
%       The cell temperature
%   Eg_ref: double
%       The reference bandgap energy
%   J0_ref: double
%       The reference saturation current density
%
% Outputs:
% ------
%   J0: double
%       The updated saturation current density
%
% Author: Youri Blom

%Define constants
q = 1.602176634e-19; % C
h = 6.62607015e-34; % J*s
c = 2.99792458e8; % m/s
k = 1.380649e-23; % J/K

%Define wavelength and energy range
wav_range = (300:1200)*1e-9;
E_range = h*c./wav_range;

%Define integration function
Function = (2*pi/(h^3*c^2)) .* E_range.^2 ./(exp(E_range./(k*T)) - 1);


%Determine constant
Filter_ref = E_range > Eg_ref*q;
constant = J0_ref/(q * trapz(flip(E_range), flip(Function.*Filter_ref)));

%Calculate value
Filter = E_range > Eg*q;
J0 = constant*q * trapz(flip(E_range), flip(Function.*Filter));

end