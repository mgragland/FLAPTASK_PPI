% This function organizes the correct and incorrect responses based on
% the TRL/URL location 
function [trialtype_TRL,trialtype_URL] =attended_vs_unattended(trialtype, TRL, rispo)
if TRL==1
        TRL_location=trialtype{1};
        URL_location=trialtype{2};
    elseif TRL==2
        TRL_location=trialtype{2};
        URL_location=trialtype{1};
end

    
trialtype_TRL(1,:)=TRL_location; % Trials at that location 
trialtype_TRL(2,:)=rispo(TRL_location); % Correct vs Incorrect Responses 
trialtype_TRL(3,1) =sum(trialtype_TRL(2,:) == 1); % Number of Correct Responses

trialtype_URL(1,:)=URL_location; % Trials at that Location
trialtype_URL(2,:)=rispo(URL_location); % Correct vs Incorrect Responses 
trialtype_URL(3,1) =sum(trialtype_URL(2,:) == 1); % Number of Correct Responses
end



