function  [TRL_condition, URL_condition]=create_condition_matrix(trialtype_TRL, trialtype_URL, stim_start_frame, startTime)
% stim_start_frame=stimulus presentation time in Datapixx time
%ExpStarttimeD=first flip after the trigger in datapixx clock time
%TrialStartTimeD=JitterEndTimeD=Trial start time in datapixx clock time

stim_start_time=stim_start_frame-startTime;
index_trial_type_attended=trialtype_TRL(1,:);
index_trial_type_unattended=trialtype_URL(1,:);
TRL_condition=stim_start_time(index_trial_type_attended);
URL_condition=stim_start_time(index_trial_type_unattended);
