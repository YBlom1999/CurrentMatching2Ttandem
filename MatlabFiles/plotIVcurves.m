function [fig] = plotIVcurves(fig,V_top,I_top,V_bot,I_bot)
% plotIVcurves plots the IV curve custom cell
%
% Inputs:
% ------
%   fig: figure
%       The figure
%   V_top: double
%       The voltage of the top cell
%   I_top: double
%       The current of the top cell
%   V_bot: double
%       The voltage of the bottom cell
%   I_bot: double
%       The current of the bottom cell
%
% Outputs:
% ------
%   fig: figure
%       The figure
%
% Author: Youri Blom

% Initialize the figure
cla(fig);
hold(fig,"on");
box(fig,"on");
grid(fig,"on");

%Find maximum power point
[Vmpp_top,Impp_top] =findMPP(V_top,I_top);
[Vmpp_bot,Impp_bot] =findMPP(V_bot,I_bot);
[Vmpp_tan,Impp_tan] =findMPP(V_top+V_bot,I_top);

%Top cell
p1 = plot(fig,V_top,I_top,'Color','b','LineWidth',2);
plot(fig,[0,Vmpp_top],[Impp_top,Impp_top],'Color','b','LineStyle','--')
plot(fig,[Vmpp_top,Vmpp_top],[0,Impp_top],'Color','b','LineStyle','--')

%Bottom cell
p2 = plot(fig,V_bot,I_bot,'Color','r','LineWidth',2);
plot(fig,[0,Vmpp_bot],[Impp_bot,Impp_bot],'Color','r','LineStyle','--')
plot(fig,[Vmpp_bot,Vmpp_bot],[0,Impp_bot],'Color','r','LineStyle','--')

%Combined
p3 = plot(fig,V_bot+V_top,I_bot,'Color',[0,0.5,0],'LineWidth',2);
plot(fig,[0,Vmpp_tan],[Impp_tan,Impp_tan],'Color',[0,0.5,0],'LineStyle','--')
plot(fig,[Vmpp_tan,Vmpp_tan],[0,Impp_tan],'Color',[0,0.5,0],'LineStyle','--')

% Specify limits of axis and labels
xlim(fig,[0,2])
ylim(fig,[0,250])
xlabel(fig,'Voltage [V]')
ylabel(fig,'Current density [A/m^2]')
title(fig,'');
legend(fig,[p1,p2,p3],{'Top','Bottom','Tandem'},'Location','north','NumColumns',3)
fig.FontSize = 14;

end