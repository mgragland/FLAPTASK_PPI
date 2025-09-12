function [TRL_cue, URL_cue]=create_cue_condition_matrix(trialtype_TRL,trialtype_URL, CueOnsetTime, startTime)

% preCueISI=0.200, CueDuration=0.250, postCueISI=0.500, 
cue_start_time=CueOnsetTime-startTime;
index_trial_type_attended=trialtype_TRL(1,:);
index_trial_type_unattended=trialtype_URL(1,:);
TRL_cue=cue_start_time(index_trial_type_attended);
URL_cue=cue_start_time(index_trial_type_unattended);
