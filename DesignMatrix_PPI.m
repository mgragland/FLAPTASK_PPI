% Main Script for PPI Design Matrix for fMRI FLAP Task 
% Written by Madeline Ragland, September 2025
 
% Important Variables
% condtr: 1 is gabor, 2 is eggs, 3 is pd, 4 is rest. 
% the ans: 1= left and 2=right
% mixtr 1: assessment type gabor (1) vs CI (2)
% mixtr 2: stimulus location left (1) vs right (2)
% mixtr 3: shape type (only for CI), Eggs (1) vs 6/9 (2)



%% Part 1: Import Data and Clear Irrelevant Variables in Workspace 
% Specify the directory containing your data
dataFolder = '/Users/madelineragland/Downloads/MATLAB_outputs'
% Get a list of all files in the folder
files = dir(fullfile(dataFolder, '*.mat')); % Change '*.txt' to match the file extension of your data
savefigures = ['/Users/madelineragland/FLAP DATA/DataPPI']

% If any sessions need to be removed 
remove_session=0; 

relevantFiles={};
% Loop through each file

for i = 1:numel(files)
    % Get the file name
    filename = files(i).name;
    % Construct the full file path
    filepath = fullfile(dataFolder, filename);
    %load the filename
    load(filepath)
    clearvars -except condtr theans mixtr rispo theothershape respTime

    %% Part 2: Determine TRL Location
    % insert participant assignment table 

    location_target=mixtr(:,2);
    for j=1:location_target
        if location_target(i)==1
            location_left=i;
        elseif location_target(i)==2
            location_right=i;
        end
    end

    if TRL==1
        att_location=location_left
        unatt_location=location_right
    elseif TRL==2
        att_location=location_right
        unatt_location=location_left
    end

    %% Part 3: Sort based on trial type
    [gabor_trials,pd_trials, egg_trials]=sort_trials(mixtr)

    %% Part 3: Determine trials with correct answer based on attended vs unattended location
    [trialtype_attended,trialtype_unattended]=attended_vs_unattended(gabor_trials, att_location, unatt_location, rispo)

    %% Part 4: Build Design Matrix based on chosen parameters
end