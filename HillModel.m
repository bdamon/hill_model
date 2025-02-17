function Hill_Model

%Copyright (c)2011 Bruce M. Damon
%May be distributed for educational purposes

%initialize matlab
clear all
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

%% CaTimeCourse
function GenerateTimeCourse

global h_fig params contract_params timecourse ca_timecourse data_plots

%time step for simulations is dt = 0.01 ms
dt=.00001;

%set contraction duration and vector with time increments
contract_params.dur=1.5;
timecourse=0:dt:contract_params.dur;

%find number of twitches and associated params
v2=get(params.ca_freq, 'Value');
v2_list=[1 100];
contract_params.freq=v2_list(v2);
contract_params.ntwitches=floor(contract_params.freq*contract_params.dur);
contract_params.ntwitches=contract_params.freq;
contract_params.twitch_times=0:1/contract_params.freq:(contract_params.ntwitches)/contract_params.freq;

%get parameters for excitation timecourse
v3=get(params.ca_tau_on, 'Value');
v3_list=2:6;
contract_params.tau_on=v3_list(v3)/1000;        %convert to s
v5=get(params.ca_tau_off, 'Value');
v5_list=(30:10:60)/1000;
contract_params.tau_off=v5_list(v5);

%generate single twtich timecourse
ca_up=1-exp(-(0:dt:0.006)./contract_params.tau_on);
ca_down=max(ca_up)*exp(-(0:dt:(contract_params.dur))./contract_params.tau_off);
singletwitch=[ca_up ca_down];

%find indices corresponding to twitch times
twitch_idx=zeros(1, contract_params.ntwitches);
for k=1:contract_params.ntwitches
    twitch_idx(k)=min(find(timecourse>=contract_params.twitch_times(k)));
end
% twitch_idx=twitch_idx+1000;      %add initial 10 ms latency

% ca_timecourse=zeros(1,2*length(timecourse));
ca_timecourse=singletwitch;
if contract_params.ntwitches>1
    for k=2:contract_params.ntwitches
        ca_timecourse(twitch_idx(k):twitch_idx(k)+length(ca_up)-1)=ca_timecourse(twitch_idx(k)-1)+ca_up;
        ca_timecourse(ca_timecourse>1)=1;
        loop_ca_down=max(ca_timecourse)*exp(-(0:dt:(contract_params.dur))./contract_params.tau_off);
        ca_timecourse(twitch_idx(k):twitch_idx(k)+length(loop_ca_down)-1)=loop_ca_down;
    end
else
    ca_timecourse(1:length(singletwitch))=singletwitch;
    ca_timecourse=ca_timecourse(1:min(length(timecourse), 2*length(singletwitch)));
    timecourse=timecourse(1:length(ca_timecourse));
end
ca_timecourse=ca_timecourse(1:length(timecourse));
ca_timecourse=(ca_timecourse*0.999999) + 0.000001;              %prevent 0 activation so that weird dynamics won't occur

%plot data
figure(h_fig)
subplot(2,4,1)
plot(timecourse, ca_timecourse)
set(data_plots.a, 'box', 'on')
title('Excitation Function', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Excitation Level (AU)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)



return

%% SetFiberLength
function SetArchitecture

global h_fig params contract_params 

%get some of the initial architectural params
figure(h_fig)
v1=get(params.penn, 'Value');
v1_list=[10 15 20 25];
penn=v1_list(v1);
penn=penn/180*pi;

v2=get(params.mwidth, 'Value');
v2_list=[2 2.5 3 3.5];
mwidth=v2_list(v2)/100;

v3=get(params.mlength, 'Value');
v3_list=[20 25 30 35 40];
mlength=v3_list(v3)/100;

%calculate other initial architectural params
flength=mwidth/sin(penn);
muscle_diag=sqrt(mlength^2 + mwidth^2);
flength=(round(1000*min(flength, muscle_diag)))/1000;
pcsa=(round((mlength*mwidth*mwidth)/flength * cos(penn)*100000))/100000;

%put into a structure
contract_params.flength=flength;
contract_params.pcsa=pcsa;
contract_params.penn=penn;
contract_params.mwidth=mwidth;
contract_params.mlength=mlength;

flength=num2str(100*flength);
pcsa=num2str(100*100*pcsa);
set(params.flength, 'String', flength);
set(params.pcsa, 'String', pcsa);

return;

%% TendonStressStrain
function TendonStressStrain(show_data)

if exist('show_data')==0
    show_data=1;
end

global h_fig params stress strain contract_params

figure(h_fig)

v1=get(params.tc1, 'Value');
v1_list=6:10;
contract_params.C1=v1_list(v1);

v2=get(params.tc2, 'Value');
v2_list=6:2:14;
contract_params.C2=v2_list(v2);

strain=0:.005:.05;
stress=contract_params.C1*exp(strain.*contract_params.C2)-contract_params.C1;
if show_data==1
    figure
    plot(strain, stress)
    xlabel('Strain (decimal)')
    ylabel('Stress (MPa)')
end

return;

%% ViewLT
function ViewLT

global h_fig params

figure(h_fig)

v1=get(params.lnought, 'Value');
v1_list=[69.2 76.6 92.1 100 102.7 115 121.2];
i_length=v1_list(v1);

p_fit=[-12.9085   95.3997 -283.4835  434.2551 -365.4251  162.3221  -29.1533];

m_lengths=.5:.01:1.5;
m_forces=polyval(p_fit, m_lengths);
m_forces(m_forces<0)=0;
m_forces(m_forces>1.0)=1;

figure
plot(m_lengths*100, m_forces*100)
hold on
plot(i_length, 100*polyval(p_fit, i_length/100), 'r.');
xlabel('Muscle Length (% Optimal Length)')
ylabel('Force (% Optimal Tetanic Tension)')
text(60, 25, [num2str(round(100*polyval(p_fit, i_length/100))) '% Maximal Tetanic Tension'])

return;

%% RunModel
function RunModel

global h_fig params contract_params timecourse ca_timecourse data_plots all_muscle_lengths ...
    all_flengths all_forces all_tendon_lengths all_penns all_mwidths shortening_ratio

%assumptions
contract_params.I_Po=15*1E4;                    %N/m^2
contract_params.II_Po=23*1E4;                   %N/m^2
%also assume that Hill a=0.25*Po, Hill b=0.25*Vmax - see below

%user-determined params not already obtained from the dashboard
figure(h_fig)
v1=get(params.Ipct, 'Value');
v1_list=[0 10 20 30 40 50 60 70 80 90 100];
contract_params.Ipct=v1_list(v1);

v2=get(params.tlength, 'Value');
v2_list=5:2.5:15;
contract_params.tlength=v2_list(v2)/100;

v3=get(params.tcsa, 'Value');
v3_list=5:2.5:15;
contract_params.tcsa=v3_list(v3)/1E6;

v4=get(params.lnought, 'Value');
v4_list=[69.2 76.6 92.1 100 102.7 115 121.2];
contract_params.lnought=v4_list(v4);
contract_params.lnought=contract_params.lnought/100;        %convert to fractional length
contract_params.lnought=contract_params.lnought*contract_params.mlength; %convert to m

%other assumed or calculated parameters
contract_params.Po=((contract_params.Ipct*contract_params.I_Po) + ((100-contract_params.Ipct)*contract_params.II_Po))/100;
contract_params.Po=contract_params.Po*contract_params.pcsa;
contract_params.I_vmax=5*contract_params.flength;
contract_params.II_vmax=15*contract_params.flength;
contract_params.Vmax=((contract_params.Ipct*contract_params.I_vmax) + ((100-contract_params.Ipct)*contract_params.II_vmax))/100;
contract_params.b=.25*contract_params.Vmax;

%assume polynomial coefficients for the length-tendon curve (fitted previously);
p_fit=[-12.9085   95.3997 -283.4835  434.2551 -365.4251  162.3221  -29.1533];

%run model for all time values

%initialize variables
dt=timecourse(2)-timecourse(1);
all_muscle_lengths=zeros(size(timecourse));
all_muscle_lengths(:)=contract_params.mlength;
all_tendon_lengths=zeros(size(timecourse));
all_tendon_lengths(:)=contract_params.tlength;
all_forces=zeros(size(timecourse));
strain_tendon=0;
muscle_vol=contract_params.mlength*contract_params.mwidth*contract_params.mwidth;
all_mwidths=zeros(size(timecourse));
all_mwidths(:)=contract_params.mwidth;
all_flengths=zeros(size(timecourse));
all_flengths(:)=contract_params.flength;
loop_penn=contract_params.penn;
fiber_run=all_mwidths/tan(loop_penn);
loop_Po=contract_params.Po;
all_penns=ones(size(timecourse))*contract_params.penn;
shortening_ratio=ones(size(timecourse));

%contraction loop
for t=1:length(timecourse);
    stress_tendon=contract_params.C1*exp(strain_tendon.*contract_params.C2)-contract_params.C1;
    force_tendon=stress_tendon*1E6*contract_params.tcsa;
    force_muscle=force_tendon;
    if force_muscle<0
        force_muscle=0;
    end
    loop_mlength=all_muscle_lengths(t);
    loop_LT=loop_mlength/contract_params.lnought;
    loop_LT=min(1, polyval(p_fit, loop_LT));                                %LT value can't be >1
    loop_LT=max(loop_LT, 0);                                                %LT value can't be <0
    loop_ca=ca_timecourse(t);
    loop_Po=loop_ca*loop_LT*loop_Po;
    loop_a=.25*loop_Po;
    if t==1
        loop_v=contract_params.Vmax;
    else
        loop_v=(contract_params.b*(loop_Po-force_muscle))/(force_muscle+loop_a);
    end
    dl=loop_v*dt;
    all_forces(t)=force_muscle;
    all_muscle_lengths(t+1)=all_muscle_lengths(t)-dl;
    all_tendon_lengths(t+1)=all_tendon_lengths(t)+dl;
    strain_tendon=(all_tendon_lengths(t+1)-contract_params.tlength)/contract_params.tlength;
    all_mwidths(t+1)=sqrt(muscle_vol/all_muscle_lengths(t+1));
    shortening_ratio(t)=all_muscle_lengths(t+1)/all_muscle_lengths(t);
    fiber_run(t+1)=fiber_run(t)*shortening_ratio(t);
    muscle_diag=sqrt(all_muscle_lengths(t+1)^2 + all_mwidths(t+1)^2);
    all_flengths(t+1)=min(muscle_diag, sqrt(all_mwidths(t+1)^2 + fiber_run(t+1)^2));
    loop_penn=asin(all_mwidths(t+1)/all_flengths(t+1));
    all_penns(t+1)=loop_penn;
    loop_pcsa=muscle_vol/all_flengths(t+1) * cos(loop_penn);
    loop_Po=loop_pcsa*((contract_params.Ipct*contract_params.I_Po) + ((100-contract_params.Ipct)*contract_params.II_Po))/100;
end
all_muscle_lengths=all_muscle_lengths(1:length(timecourse));
all_forces=all_forces(1:length(timecourse));
all_tendon_lengths=all_tendon_lengths(1:length(timecourse));
all_flengths=all_flengths(1:length(timecourse));
all_penns=all_penns(1:length(timecourse));

figure(h_fig)
subplot(2,4,2)
hold off
plot(timecourse, 100*all_muscle_lengths, 'b')
hold on
plot(timecourse, 100*all_tendon_lengths, 'k')
legend('Muscle Length', 'Tendon Length')
set(data_plots.a, 'box', 'on')
title('Muscle and Tendon Length', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Length (cm)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)
axis([0 max(timecourse) 0 1.5*contract_params.mlength*100])

subplot(2,4,8)
hold off
plot(timecourse, all_forces, 'b')
set(data_plots.e, 'box', 'on')
title('Muscle Force', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Force (N)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

subplot(2,4,3)
hold off
plot(timecourse, all_flengths*100, 'b')
set(data_plots.c, 'box', 'on')
title('Fiber Length', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Fiber Length (cm)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

subplot(2,4,4)
hold off
plot(timecourse, all_penns/pi*180, 'b')
set(data_plots.d, 'box', 'on')
title('Pennation Angle', 'FontSize', 11, 'FontWeight', 'Bold')
ylabel('Pennation Angle (deg.)', 'FontSize', 10)
xlabel('Time (s)', 'FontSize', 10)

return

%% SaveData
function SaveData

global contract_params timecourse ca_timecourse all_muscle_lengths all_forces all_tendon_lengths all_flengths ...
    max_force min_muscle_length max_tendon_length time2peakforce all_penns all_mwidths shortening_ratio %#ok<NUSED>

[fn, pn]=uiputfile('*.mat', 'Save Data File');
cd(pn)
eval(['save ' fn ' shortening_ratio contract_params timecourse ca_timecourse all_muscle_lengths all_forces all_tendon_lengths all_flengths max_force min_muscle_length max_tendon_length time2peakforce all_penns all_mwidths'])

return

%% ViewData
function ViewData

global timecourse all_muscle_lengths all_forces all_tendon_lengths ...
    max_force min_muscle_length max_tendon_length time2peakforce ...
    all_penns all_flengths min_fiber_length max_penn

max_force=max(all_forces);
min_muscle_length=100*min(all_muscle_lengths);
min_fiber_length=100*min(all_flengths);
max_tendon_length=100*max(all_tendon_lengths);
time2_50pctpeakforce=timecourse(min(find(all_forces>=(0.5*max_force))));
time2_50pctpeakforce=1000*time2_50pctpeakforce(1);
max_penn=max(all_penns)/pi*180;
max_penn=(round(100*max_penn))/100;
max_force=(round(100*max_force))/100;
min_muscle_length=(round(100*min_muscle_length))/100;
min_fiber_length=(round(100*min_fiber_length))/100;
max_tendon_length=(round(100*max_tendon_length))/100;
time2peakforce=(round(100*time2peakforce))/100;

dfig=figure('Position', [1100 200 425 450], 'Color', [.75 .75 .75]);

figure(dfig)
%gui's for titles
uicontrol('Position', [50 400 160 25], 'Style', 'Text', 'String', 'Parameter', 'FontSize', 11, 'FontWeight', 'Bold', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 400 115 25], 'Style', 'Text', 'String', 'Value (Unit)', 'FontSize', 11, 'FontWeight', 'Bold', ...
    'BackgroundColor', [.75 .75 .75])

%gui's for muscle force
uicontrol('Position', [50 360 160 25], 'Style', 'Text', 'String', 'Peak Muscle Force', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 370 75 25], 'Style', 'Edit', 'String', num2str(max_force), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 360 25 25], 'Style', 'Text', 'String', '(N)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');

uicontrol('Position', [50 310 160 25], 'Style', 'Text', 'String', 'Time to 50% Peak Tension', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 320 75 25], 'Style', 'Edit', 'String', num2str(time2_50pctpeakforce), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 310 25 25], 'Style', 'Text', 'String', '(ms)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');

%gui's for structural parameters
uicontrol('Position', [50 260 160 25], 'Style', 'Text', 'String', 'Min. Muscle Length', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 270 75 25], 'Style', 'Edit', 'String', num2str(min_muscle_length), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 260 25 25], 'Style', 'Text', 'String', '(cm)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');

uicontrol('Position', [50 210 160 25], 'Style', 'Text', 'String', 'Max. Tendon Length', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 220 75 25], 'Style', 'Edit', 'String', num2str(max_tendon_length), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 210 25 25], 'Style', 'Text', 'String', '(cm)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');

uicontrol('Position', [50 160 160 25], 'Style', 'Text', 'String', 'Min. Fiber Length', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 170 75 25], 'Style', 'Edit', 'String', num2str(min_fiber_length), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 160 25 30], 'Style', 'Text', 'String', '(cm)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');

uicontrol('Position', [50 110 160 25], 'Style', 'Text', 'String', 'Max. Pennation', 'HorizontalAlignment', 'Left', ...
    'BackgroundColor', [.75 .75 .75])
uicontrol('Position', [210 120 75 25], 'Style', 'Edit', 'String', num2str(max_penn), 'HorizontalAlignment', 'Left');
uicontrol('Position', [300 110 35 25], 'Style', 'Text', 'String', '(Deg.)', 'BackgroundColor', [.75 .75 .75], 'HorizontalAlignment', 'Left');


return



