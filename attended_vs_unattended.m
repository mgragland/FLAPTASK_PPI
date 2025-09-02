function [trialtype_attended,trialtype_unattended] =attended_vs_unattended(trialtype, att_location, unatt_location, rispo)


trialtype_attended=trialtype(att_location)
trialtype_attended(2,:)=rispo(trialtype_attended)
trialtype_attended(3,1) = sum(trialtype_attended(2,:) == 1);

trialtype_unattended=trialtype(unatt_location)
trialtype_unattended(2,:)=rispo(trialtype_unattended)
trialtype_unattended(3,1) = sum(trialtype_unattended(2,:) == 1);
end



