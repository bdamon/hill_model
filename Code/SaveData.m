function SaveData
% SaveData

global contract_params timecourse ca_timecourse all_muscle_lengths all_forces all_tendon_lengths all_flengths ...
    max_force min_muscle_length max_tendon_length time2peakforce all_penns all_mwidths shortening_ratio %#ok<NUSED>

[fn, pn]=uiputfile('*.mat', 'Save Data File');
cd(pn)
eval(['save ' fn ' shortening_ratio contract_params timecourse ca_timecourse all_muscle_lengths all_forces all_tendon_lengths all_flengths max_force min_muscle_length max_tendon_length time2peakforce all_penns all_mwidths'])

return

