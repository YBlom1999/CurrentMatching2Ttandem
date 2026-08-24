function [app] = simulateCustom(app)
% simulateCustom executes the script for custom parameters
%
% Inputs:
% ------
%   app: matlab-object
%       All information and details of the current state of the application
%
% Outputs:
% ------
%   app: matlab-object
%       All information and details of the current state of the application
%
% Author: Youri Blom

%Read values from GUI
Iph_top = app.Iph_top.Value;
I0_top = app.I0_top.Value;
n_top = app.n_top.Value;
Rsh_top = app.Rsh_top.Value;
Rs_top = app.Rs_top.Value;
Iph_bot = app.Iph_bottom.Value;
I0_bot = app.I0_bottom.Value;
n_bot = app.n_bottom.Value;
Rsh_bot = app.Rsh_bottom.Value;
Rs_bot = app.Rs_bottom.Value;

%Calculate IV curves
[V_top,I_top] = calculateIV(Iph_top,I0_top,n_top,Rsh_top,Rs_top);
[V_bot,I_bot] = calculateIV(Iph_bot,I0_bot,n_bot,Rsh_bot,Rs_bot);

%Find maximum power point
[Vmpp_top,Impp_top] =findMPP(V_top,I_top);
[Vmpp_bot,Impp_bot] =findMPP(V_bot,I_bot);
[Vmpp_tan,Impp_tan] =findMPP(V_top+V_bot,I_top);

%Determine IV characteristics
Pmpp_top = Vmpp_top*Impp_top;
Pmpp_bot = Vmpp_bot*Impp_bot;
Pmpp_tan = Vmpp_tan*Impp_tan;

Isc_top = interp1(V_top,I_top,0,'linear','extrap'); Voc_top = interp1(I_top,V_top,0,'linear','extrap');
Isc_bot = interp1(V_bot,I_bot,0,'linear','extrap'); Voc_bot = interp1(I_bot,V_bot,0,'linear','extrap');
Isc_tan = interp1(V_top+V_bot,I_top,0,'linear','extrap'); Voc_tan = interp1(I_top,V_top+V_bot,0,'linear','extrap');

FF_top = 100*Pmpp_top/Isc_top/Voc_top;
FF_bot = 100*Pmpp_bot/Isc_bot/Voc_bot;
FF_tan = 100*Pmpp_tan/Isc_tan/Voc_tan;

%Make figure
app.CustomFigure = plotIVcurves(app.CustomFigure,V_top,I_top,V_bot,I_bot);

% Update values
app.JscTop.Value = round(Isc_top,1);
app.JscBot.Value = round(Isc_bot,1);
app.JscTandem.Value = round(Isc_tan,1);

app.VocTop.Value = round(Voc_top,2);
app.VocBot.Value = round(Voc_bot,2);
app.VocTandem.Value = round(Voc_tan,2);

app.JmppTop.Value = round(Impp_top,1);
app.JmppBot.Value = round(Impp_bot,1);
app.JmppTandem.Value = round(Impp_tan,1);

app.VmppTop.Value = round(Vmpp_top,2);
app.VmppBot.Value = round(Vmpp_bot,2);
app.VmppTandem.Value = round(Vmpp_tan,2);

app.FFTop.Value = round(FF_top,1);
app.FFBot.Value = round(FF_bot,1);
app.FFTandem.Value = round(FF_tan,1);

app.PowerTop.Value = round(Pmpp_top,1);
app.PowerBot.Value = round(Pmpp_bot,1);
app.PowerTandem.Value = round(Pmpp_tan,1);
end