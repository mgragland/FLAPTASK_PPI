function  [TRL_condition, URL_condition, TRL_condition_matrix, URL_condition_matrix]=create_condition_matrix(trialtype_TRL, trialtype_URL, stim_start_frame, startTime, vol_times)
% stim_start_frame=stimulus presentation time in Datapixx time
%ExpStarttimeD=first flip after the trigger in datapixx clock time
%TrialStartTimeD=JitterEndTimeD=Trial start time in datapixx clock time
% if the trial=1; TrialStartTime(trial,1)=startTime+TR;
%stimulusduration=0.200

% finding the stimulus onset time of the trials 
stim_start_time=stim_start_frame-startTime;
index_trial_type_attended=trialtype_TRL(1,:);
index_trial_type_unattended=trialtype_URL(1,:);
TRL_condition=stim_start_time(index_trial_type_attended);
URL_condition=stim_start_time(index_trial_type_unattended);


% creating the design matrix to indicate 0 for no trial in that volume and
% 1/stimulus onset time for the volume where the trial is conducted
TRL_condition_matrix=zeros(1,length(vol_times));
for i = 1:length(TRL_condition)
    for j = 2:length(vol_times)-1 
        if TRL_condition(i) > vol_times(j-1) && TRL_condition(i) < vol_times(j+1)
            TRL_condition_matrix(j) = TRL_condition(i);
        end
    end
end

URL_condition_matrix=zeros(1,length(vol_times));
for i = 1:length(URL_condition)
    for j = 2:length(vol_times)-1 
        if URL_condition(i) > vol_times(j-1) && URL_condition(i) < vol_times(j+1)
            URL_condition_matrix(j) = URL_condition(i);
        end
    end
end
    

