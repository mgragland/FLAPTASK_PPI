% This function organizes the correct and incorrect responses based on
% the TRL/URL location 
function [trialtype_TRL,trialtype_URL] =attended_vs_unattended(trialtype, TRL, rispo, num_run)
if TRL==1
        TRL_location=trialtype{1}
        URL_location=trialtype{2}
    elseif TRL==2
        TRL_location=trialtype{2}
        URL_location=trialtype{1}
end

    

trialtype_TRL(1,:, num_run)=TRL_location;
trialtype_TRL(2,:, num_run)=rispo(TRL_location);
trialtype_TRL(3,1, num_run) =sum(trialtype_TRL(2,:) == 1);

trialtype_URL(1,:,num_run)=URL_location;
trialtype_URL(2,:, num_run)=rispo(URL_location);
trialtype_URL(3,1, num_run) =sum(trialtype_URL(2,:) == 1);
end



