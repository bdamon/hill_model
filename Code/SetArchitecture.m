function SetArchitecture
% SetFiberLength

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