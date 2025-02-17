function ViewData
% ViewData

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

