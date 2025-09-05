% Main Script for PPI Design Matrix for fMRI FLAP Task
% Written by Madeline Ragland, September 2025

% Important Variables
% condtr: 1 is gabor, 2 is eggs, 3 is pd, 4 is rest.
% the ans: 1= left and 2=right
% mixtr 1: assessment type gabor (1) vs CI (2)
% mixtr 2: stimulus location left (1) vs right (2)
% mixtr 3: shape type (only for CI), Eggs (1) vs 6/9 (2)


subject='fb1009'

%% Part 1: Determine TRL Location
% Add Participant Assignment Table:
addpath(['C:\Users\raglandm\Desktop\FLAP DATA']);
pt_assignment=table2cell(readtable('ParticipantAssignmentsUAB_corr'));
TRL=ptassignmenttable(subject, pt_assignment); %TRL=1 is LEFT and TRL=2 is RIGHT

%% Part 2: Import Data and Clear Irrelevant Variables in Workspace
% Specify the directory containing your data
dataFolder = ['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Raw_Data\'  subject];
% Get a list of all files in the folder
files = dir(fullfile(dataFolder, '*.mat')); % Change '*.txt' to match the file extension of your data
savefigures = ['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject];

% If any sessions need to be removed
remove_session=5;

relevantFiles={};


% Loop through each file

for num_run = 1:numel(files)
    if num_run==remove_session
        gabor_TRL(1,1,num_run)=0;
        gabor_URL(1,1,num_run)=0;
        continue
    end
    % Get the file name
    filename = files(num_run).name;
    % Construct the full file path
    filepath = fullfile(dataFolder, filename);
    %load the filename
    load(filepath)
    clearvars -except subject TRL condtr theans mixtr rispo theothershape respTime num_run files savefigures dataFolder remove_session

    %% Part 3: Sort Location of Target into TRL and URL location based on ATTENDED CUE
    % location_target=mixtr(:,2);
    % location_left=[];
    % location_right=[];
    % 
    % for j=1:length(location_target)
    %     if location_target(j)==1
    %         location_left(end+1)=j;
    %     elseif location_target(j)==2
    %         location_right(end+1)=j;
    %     end
    % end
    % 
    % if TRL==1
    %     TRL_location=location_left
    %     URL_location=location_right
    % elseif TRL==2
    %     TRL_location=location_right
    %     URL_location=location_left
    % end

    %% Part 4: Sort based on trial type
    [gabor_trials,pd_trials, egg_trials]=sort_trials(mixtr)

    %% Part 5: Determine trials with correct answer based on TRL vs URL location
    [gabor_TRL,gabor_URL]=attended_vs_unattended(gabor_trials,TRL, rispo, num_run)

    %% Graph Accuracy
    % graph_accuracy(TRL,URL)

    %% Part 4: Build Design Matrix based on chosen parameters
end