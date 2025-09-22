function  [TRL_condition_matrix, URL_condition_matrix]=create_condition_matrix(trialtype_TRL, trialtype_URL, stim_start_frame, startTime, totalduration_session, num_run, concat, stimulustype);
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

if concat==1 
    TRL_condition=concatenate_files(TRL_condition, totalduration_session, num_run)
end

% creating the design matrix to indicate 0 for no trial in that volume and
% 1/stimulus onset time for the volume where the trial is conducted
TRL_condition_matrix=zeros(length(TRL_condition), 3);
TRL_condition_matrix(:,1)=TRL_condition';
TRL_condition_matrix(:,2)=0.2;

if stimulustype==2;
    TRL_condition_matrix(:,3)=0;
else
    TRL_condition_matrix(:,3)=1;
end

URL_condition_matrix=zeros(length(URL_condition), 3);
URL_condition_matrix(:,1)=URL_condition';
URL_condition_matrix(:,2)=0.2;
if stimulustype==2;
    URL_condition_matrix(:,3)=0;
else
    URL_condition_matrix(:,3)=1;
end
end



