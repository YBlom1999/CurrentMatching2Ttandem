function [app] = simulateEg(app)
% simulateEg executes the script needed to show the bandgap optimization
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

%Define constants
h = 6.62607004e-34;
q = 1.60217662e-19;
c = 299792458;
T = 298.15;

%Define reference values
Eg_top_ref = 1.68;
I0_top_ref = 4e-14;
Eg_bot_ref = 1.12;
I0_bot_ref = 6e-8;

%Load AM spectra
load('Data\spectraSMARTS.mat','smartsSpec')
AM = smartsSpec.airMass;
wav = smartsSpec.lambda;
AM_sel = app.AirmassSlider.Value;
Irr = smartsSpec.global;
Irr = Irr./trapz(wav,Irr)*1000;
Irr = interp1(AM,Irr',AM_sel)';
photon_flux = q*Irr./(h*c./(wav*1e-9));

%Read values from GUI
Eg_range = 1.4:0.001:1.8;
n_top = app.n_top_Eg.Value;
Rsh_top = app.Rsh_top_Eg.Value;
Rs_top = app.Rs_top_Eg.Value;
Eg_bot = app.Eg_bottom_Eg.Value; lambda_bot = h*c/Eg_bot/q; N_bot = find(wav>lambda_bot*1e9,1);
n_bot = app.n_bottom_Eg.Value;
Rsh_bot = app.Rsh_bottom_Eg.Value;
Rs_bot = app.Rs_bottom_Eg.Value;

%Initialize matrices
Pmpp = zeros(1,length(Eg_range));
FF = zeros(1,length(Eg_range));
Isc_tan = zeros(1,length(Eg_range));
Voc_tan = zeros(1,length(Eg_range));
Iph_top = zeros(1,length(Eg_range));
Iph_bot = zeros(1,length(Eg_range));
Impp_top = zeros(1,length(Eg_range));
Impp_bot = zeros(1,length(Eg_range));

%Calculate performance for different bandgap energies
for Eg_i = 1:length(Eg_range)
    Eg_top = Eg_range(Eg_i); lambda_top = h*c/Eg_top/q; N_top = find(wav>lambda_top*1e9,1);
    
    %Calculate photogenerated currents
    Iph_top(Eg_i) = trapz(wav(1:N_top),photon_flux(1:N_top));
    Iph_bot(Eg_i) = trapz(wav(N_top:N_bot),photon_flux(N_top:N_bot));

    %Calculate saturation current densities
    I0_top = calculateJ0(Eg_top,T,Eg_top_ref,I0_top_ref);
    I0_bot = calculateJ0(Eg_bot,T,Eg_bot_ref,I0_bot_ref);

    %Calculate IV curves
    [V_top,I_top] = calculateIV(Iph_top(Eg_i),I0_top,n_top,Rsh_top,Rs_top);
    [V_bot,I_bot] = calculateIV(Iph_bot(Eg_i),I0_bot,n_bot,Rsh_bot,Rs_bot);
    
    %Find maximum power point
    [~,Impp_top(Eg_i)] =findMPP(V_top,I_top);
    [~,Impp_bot(Eg_i)] =findMPP(V_bot,I_bot);
    [Vmpp_tan,Impp_tan] =findMPP(V_top+V_bot,I_top);
    
    %Determine IV characteristics
    Pmpp(Eg_i) = Vmpp_tan*Impp_tan;
    Isc_tan(Eg_i) = interp1(V_top+V_bot,I_top,0,'linear','extrap'); 
    Voc_tan(Eg_i) = interp1(I_top,V_top+V_bot,0,'linear','extrap');
    FF(Eg_i)= 100*Pmpp(Eg_i)/Isc_tan(Eg_i)/Voc_tan(Eg_i);

end

%Make figure
choiceCurrent = app.CurrentChoice_Eg.Value;
choiceIVchar = app.TandemParameter_Eg.Value;
app.EgFigure = plotEg(app.EgFigure,Eg_range,Pmpp,FF,Isc_tan,Voc_tan,Iph_top,Iph_bot,Impp_top,Impp_bot,choiceCurrent,choiceIVchar);
end