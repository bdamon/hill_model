function HillModel

%Copyright (c)2011 Bruce M. Damon
%May be distributed for educational purposes

%initialize matlab
clear 
close all
clc

%declare global variables
global h_fig params data_plots 

%define main figure window
close all
h_fig=figure('Position', [50 200 1500 700], 'Name', 'Hill Model - Dashboard', 'Color', [.75 .75 .75]);

%define frames for the three plots
data_plots.a=subplot(2,4,1);
set(data_plots.a, 'xticklabel', [], 'yticklabel', [], 'box', 'on')
title('Excitation Function', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Excitation Level (AU)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

data_plots.b=subplot(2,4,2);
set(data_plots.b, 'xticklabel', [], 'yticklabel', [], 'box', 'on')
title('Muscle and Tendon Length', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Length (cm)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

data_plots.c=subplot(2,4,3);
set(data_plots.c, 'xticklabel', [], 'yticklabel', [], 'box', 'on')
title('Fiber Length', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Fiber Length (cm)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

data_plots.d=subplot(2,4,4);
set(data_plots.d, 'xticklabel', [], 'yticklabel', [], 'box', 'on')
title('Pennation Angle', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Pennation Angle (deg.)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

data_plots.e=subplot(2,4,8);
set(data_plots.e, 'xticklabel', [], 'yticklabel', [], 'box', 'on')
title('Muscle Force', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Muscle force (N)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)


%GUI's for excitation parameters
strings.ca_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Excitation Parameters', 'Position', [115 340 250 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 11, 'FontWeight', 'Bold', 'HorizontalAlignment', 'Left');

%Strings and values for excitation on time constant
strings.ca_tau_on_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Calcium tau on', 'Position', [115 300 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.ca_tau_on=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '2|3|4|5|6', 'Position', [280 305 50 20], ...
    'Callback', 'GenerateTimeCourse', 'Value', 1);
strings.ca_tau_on_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'ms', 'Position', [332.5 300 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');


%Strings and values for excitation off time constant
strings.ca_tau_off_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Calcium tau off', 'Position', [115 260 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.ca_tau_off=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '30|40|50|60', 'Position', [280 265 50 20], 'Value', 1, ...
    'Callback', 'GenerateTimeCourse');
strings.ca_tau_off_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'ms', 'Position', [332.5 260 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for excitation frequency
strings.ca_freq_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Stimulation frequency', 'Position', [115 220 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.ca_freq=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '1|100', 'Position', [280 225 50 20], ...
    'Callback', 'GenerateTimeCourse', 'Value', 1);
strings.ca_freq_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Hz', 'Position', [332.5 220 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');






%GUI's for muscle and tendon structural parameters
strings.mt_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Muscle-Tendon Structural Parameters', 'Position', [420 340 300 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 11, 'FontWeight', 'Bold', 'HorizontalAlignment', 'Left');

%Strings and values for msucle length
strings.mlength_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Initial muscle length', 'Position', [420 300 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.mlength=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '20|25|30|35|40', 'Position', [595 305 50 20], ...
    'Value', 1, 'Callback', 'SetArchitecture');
strings.mlength_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'cm', 'Position', [647.5 300 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for pennation angle
strings.penn_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Pennation angle', 'Position', [420 260 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.penn=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '10|15|20|25', 'Position', [595 265 50 20], ...
    'Value', 1, 'Callback', 'SetArchitecture');
strings.penn_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'deg.', 'Position', [647.5 260 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for muscle width
strings.mwidth_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Muscle width', 'Position', [420 220 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.mwidth=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '2|2.5|3|3.5', 'Position', [595 225 50 20], ...
    'Value', 3, 'Callback', 'SetArchitecture');
strings.mwidth_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'cm', 'Position', [647.5 220 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for fiber length
strings.flength_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Fiber length', 'Position', [420 180 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.flength=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', '11.6', 'Position', [595 185 50 20]);
strings.flength_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'cm', 'Position', [647.5 180 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for initial PCSA
strings.pcsa_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Initial PCSA', 'Position', [420 140 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.pcsa=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', '7.5', 'Position', [595 145 50 20]);
strings.pcsa_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'cm2', 'Position', [647.5 140 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for tendon length
strings.tlength_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Tendon length', 'Position', [420 100 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.tlength=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '5|7.5|10|12.5|15', 'Position', [595 105 50 20],...
    'Value', 3);
strings.tlength_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'cm', 'Position', [647.5 100 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

%Strings and values for tendon csa
strings.tcsa_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Tendon X-sectional area', 'Position', [420 60 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.tcsa=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '5|7.5|10|12.5|15', 'Position', [595 65 50 20], 'Value', 1);
strings.tcsa_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'mm2', 'Position', [647.5 60 30 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');




%GUI's for mechanical parameters
strings.mech_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Muscle-Tendon Mechanical Parameters', 'Position', [760 340 300 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 11, 'FontWeight', 'Bold', 'HorizontalAlignment', 'Left');


%Strings and values for muscle fiber type
strings.tc1_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Tendon stress-strain C1', 'Position', [760 300 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.tc1=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '4|5|6|7|8', 'Position', [925 305 50 20], ...
    'Callback', 'TendonStressStrain', 'Value', 2);
strings.tc1_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'MPa', 'Position', [977.5 300 35 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

strings.tc2_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Tendon stress-strain C2', 'Position', [760 260 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.tc2=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '6|8|10|12|14', 'Position', [925 265 50 20], ...
    'Callback', 'TendonStressStrain', 'Value', 2);
strings.tc2_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', ' ', 'Position', [977.5 260 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

strings.Ipct_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Type I fibers', 'Position', [760 220 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.Ipct=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '0|10|20|30|40|50|60|70|80|90|100', 'Position', [925 225 50 20], 'Value', 1);
strings.Ipct_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', '%', 'Position', [977.5 220 25 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');

strings.lnought_title=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', 'Muscle initial length is', 'Position', [760 180 175 25], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');
params.lnought=uicontrol('Parent', h_fig, 'Style', 'Popupmenu', 'String', '69.2|76.6|92.1|100|102.7|115|121.2', 'Position', [925 185 50 20], 'Value', 4, ...
    'Callback', 'ViewLT');
strings.lnought_unit=uicontrol('Parent', h_fig, 'Style', 'Text', 'String', '% optimal length', 'Position', [977.5 160 60 50], ...
    'BackgroundColor', [.75 .75 .75], 'FontSize', 10, 'HorizontalAlignment', 'Left');






% GUI's involved in running hte model
cb.run=uicontrol('Parent', h_fig, 'Style', 'Pushbutton', 'String', 'Run Model', 'Position',  [165 10 200 25], ...
    'Callback', 'RunModel', 'BackgroundColor', [0.5 0.5 1], 'HorizontalAlignment', 'Left');
cb.viewdata=uicontrol('Parent', h_fig, 'Style', 'Pushbutton', 'String', 'View Data', 'Position',  [835 40 200 25], ...
    'Callback', 'ViewData', 'BackgroundColor', [1 0.5 0.5], 'HorizontalAlignment', 'Left');
cb.save=uicontrol('Parent', h_fig, 'Style', 'Pushbutton', 'String', 'Save Data', 'Position',  [835 10 200 25], ...
    'Callback', 'SaveData', 'BackgroundColor', [1 1 0.5], 'HorizontalAlignment', 'Left');


SetArchitecture
GenerateTimeCourse
TendonStressStrain(0);

pause
return;
