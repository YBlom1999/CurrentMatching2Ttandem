function [fig] = plotEg(fig,Eg_range,Pmpp,FF,Isc,Voc,Iph_top,Iph_bot,Impp_top,Impp_bot,choiceCurrent,choiceIVchar)
% plotEg plots the bandgap optimization
%
% Inputs:
% ------
%   fig: figure
%       The figure
%   Eg_range: double
%       The range of simulated bandgap energies
%   Pmpp: double
%       The maximum power points at different bandgap energies
%   FF: double
%       The fill factor at different bandgap energies
%   Isc: double
%       The short circuit current at different bandgap energies
%   Voc: double
%       The open circuit voltage at different bandgap energies
%   Iph_top: double
%       The photogenerated current of the top cell at different bandgap
%       energies
%   Iph_bot: double
%       The photogenerated current of the bottom cell at different bandgap
%       energies
%   Impp_top: double
%       The maximum power point current of the top cell at different bandgap
%       energies
%   Impp_bot: double
%       The maximum power point current of the bottom cell at different bandgap
%       energies
%   choiceCurrent: char
%       The choice of which type of current should be plotted
%   choiceIVchar: char
%       The choice of which IV characteristic should be plotted
%
% Outputs:
% ------
%   fig: figure
%       The figure
%
% Author: Youri Blom

% Initialize the figure
yyaxis(fig,"left")
cla(fig);

hold(fig,"on");
box(fig,"on");
grid(fig,"off");

%Plot currents
fig.YAxis(1).Color = 'b';
if strcmp(choiceCurrent,'PH')
    p1 = plot(fig,Eg_range,Iph_top,'Color','b');
    p2 = plot(fig,Eg_range,Iph_bot,'Color','b','LineStyle',':');
    [~,match_ind] = min(abs(Iph_top-Iph_bot));
    p3 = xline(fig,Eg_range(match_ind),'Color','b','LineStyle','--');
elseif strcmp(choiceCurrent,'MPP')
    p1 = plot(fig,Eg_range,Impp_top,'Color','b');
    p2 = plot(fig,Eg_range,Impp_bot,'Color','b','LineStyle',':');
    [~,match_ind] = min(abs(Impp_top-Impp_bot));
    p3 = xline(fig,Eg_range(match_ind),'Color','b','LineStyle','--');
end
maxValue = max([Iph_bot,Impp_bot,Iph_top,Impp_top]);
minValue = min([Iph_bot,Impp_bot,Iph_top,Impp_top]);
ylim(fig,[0.9*minValue,1.05*maxValue])
ylabel(fig,'Current density [A/m^2]')
fig.YAxis(1).Color = 'b';

%Plot IV characteristics
yyaxis(fig,	"right")
cla(fig);
hold(fig,"on");
fig.YAxis(2).Color = 'r';
if strcmp(choiceIVchar,'Pmpp')
    plot(fig,Eg_range,Pmpp,'Color','r')
    maxValue = max(Pmpp);
    minValue = min(Pmpp);
    ylabel(fig,'Power output [W/m^2]')
    
elseif strcmp(choiceIVchar,'FF')
    plot(fig,Eg_range,FF,'Color','r')
    maxValue = max(FF);
    minValue = min(FF);
    ylabel(fig,'Fill factor [%]')
elseif strcmp(choiceIVchar,'Voc')
    plot(fig,Eg_range,Voc,'Color','r')
    maxValue = max(Voc);
    minValue = min(Voc);
    ylabel(fig,'V_{oc} [V]')
elseif strcmp(choiceIVchar,'Jsc')
    plot(fig,Eg_range,Isc,'Color','r')
    maxValue = max(Isc);
    minValue = min(Isc);
    ylabel(fig,'J_{sc} [A/m^2]')
end
[~,max_ind] = max(Pmpp);
p4 = xline(fig,Eg_range(max_ind),'Color','r','LineStyle','--');
ylim(fig,[0.9*minValue,1.05*maxValue])


% Specify limits of axis and labels
xlim(fig,[Eg_range(1),Eg_range(end)])
xlabel(fig,'E_{g,top} [eV]')

title(fig,'');
legend(fig,[p1,p2,p3,p4],{'Top','Bottom',append('Match ',choiceCurrent),'Opt. Power'},'Location','northoutside','NumColumns',2)
fig.FontSize = 14;

end