function TendonStressStrain(show_data)
% TendonStressStrain

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