% Function to Find the TRL Location w/n Participant Assignment Table 
% written by Madeline Ragland, September 2025
function TRL=ptassignmenttable(subject, pt_assignment) 
pt_name=pt_assignment(:,1);
pt_row_index = find(strcmp(pt_name, subject));
TRL_loc=pt_assignment(pt_row_index,2);

if strcmp(TRL_loc,'L')
    TRL=1;
elseif strcmp(TRL_loc,'R')
    TRL=2;
end

end
