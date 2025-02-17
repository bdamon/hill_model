function RunModel
% RunModel

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