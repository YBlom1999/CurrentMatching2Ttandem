function [fig] = plotAM(fig,AM_range,Pmpp,FF,Isc,Voc,Iph_top,Iph_bot,Impp_top,Impp_bot,choiceCurrent,choiceIVchar)
% plotEg plots the bandgap optimization
%
% Inputs:
% ------
%   fig: figure
%       The figure
%   AM_range: double
%       The range of simulated air masses
%   Pmpp: double
%       The maximum power points at different air masses
%   FF: double
%       The fill factor at different air masses
%   Isc: double
%       The short circuit current at different air masses
%   Voc: double
%       The open circuit voltage at different air masses
%   Iph_top: double
%       The photogenerated current of the top cell at different air masses
%   Iph_bot: double
%       The photogenerated current of the bottom cell at different air masses
%   Impp_top: double
%       The maximum power point current of the top cell at different air masses
%   Impp_bot: double
%       The maximum power point current of the bottom cell at different air masses
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
    p1 = plot(fig,AM_range,Iph_top,'Color','b');
    p2 = plot(fig,AM_range,Iph_bot,'Color','b','LineStyle',':');
    [~,match_ind] = min(abs(Iph_top-Iph_bot));
    p3 = xline(fig,AM_range(match_ind),'Color','b','LineStyle','--');
elseif strcmp(choiceCurrent,'MPP')
    p1 = plot(fig,AM_range,Impp_top,'Color','b');
    p2 = plot(fig,AM_range,Impp_bot,'Color','b','LineStyle',':');
    [~,match_ind] = min(abs(Impp_top-Impp_bot));
    p3 = xline(fig,AM_range(match_ind),'Color','b','LineStyle','--');
end
ylim(fig,[150,250])
ylabel(fig,'Current density [A/m^2]')
fig.YAxis(1).Color = 'b';

%Plot output power/fill factor
yyaxis(fig,	"right")
cla(fig);
hold(fig,"on");
fig.YAxis(2).Color = 'r';
if strcmp(choiceIVchar,'Pmpp')
    plot(fig,AM_range,Pmpp,'Color','r')
    maxValue = max(Pmpp);
    minValue = min(Pmpp);
    ylabel(fig,'Power output [W/m^2]')
elseif strcmp(choiceIVchar,'FF')
    plot(fig,AM_range,FF,'Color','r')
    maxValue = max(FF);
    minValue = min(FF);
    ylabel(fig,'Fill factor [%]')
elseif strcmp(choiceIVchar,'Voc')
    plot(fig,AM_range,Voc,'Color','r')
    maxValue = max(Voc);
    minValue = min(Voc);
    ylabel(fig,'V_{oc} [V]')
elseif strcmp(choiceIVchar,'Jsc')
    plot(fig,AM_range,Isc,'Color','r')
    maxValue = max(Isc);
    minValue = min(Isc);
    ylabel(fig,'J_{sc} [A/m^2]')
end
[~,max_ind] = max(Pmpp);
p4 = xline(fig,AM_range(max_ind),'Color','r','LineStyle','--');
ylim(fig,[0.9*minValue,1.05*maxValue])


% Specify limits of axis and labels
xlim(fig,[AM_range(1),AM_range(end)])
xlabel(fig,'AM [-]')

title(fig,'');
legend(fig,[p1,p2,p3,p4],{'Top','Bottom',append('Match ',choiceCurrent),'Opt. Power'},'Location','northoutside','NumColumns',2)
fig.FontSize = 14;

end