function GenerateTimeCourse
% CaTimeCourse

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