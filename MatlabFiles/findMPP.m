function [Vmpp,Impp] = findMPP(Voltage,Current)
% findMPP identifies the maximum power point of an IV curve
%
% Inputs:
% ------
%   Voltage: double
%       The voltage of the cell IV curve
%   Current: double
%       The current of the cell IV curve
%
% Outputs:
% ------
%   Vmpp: double
%       The maximum power point voltage
%   Impp: double
%       The maximum power point current
%
% Author: Youri Blom

[~,ind] = max(Voltage.*Current);
Vmpp = Voltage(ind);
Impp = Current(ind);
end