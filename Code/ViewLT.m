function ViewLT
% ViewLT

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