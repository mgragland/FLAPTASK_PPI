% Main Script for PPI Design Matrix for fMRI FLAP Task
% Written by Madeline Ragland, September 2025

% Important Variables
% condtr: 1 is gabor, 2 is eggs, 3 is pd, 4 is rest.
% the ans: 1= left and 2=right
% mixtr 1: assessment type gabor (1) vs CI (2)
% mixtr 2: stimulus location left (1) vs right (2)
% mixtr 3: shape type (only for CI), Eggs (1) vs 6/9 (2)


subject='fb1009'
concat=1;
CI_nonspecific=1;


savefigures = ['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\plots'];
savedata=['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\data'];

%% Part 1: Determine TRL Location
% Add Participant Assignment Table:
addpath(['C:\Users\raglandm\Desktop\FLAP DATA']);
pt_assignment=table2cell(readtable('ParticipantAssignmentsUAB_corr'));
TRL=ptassignmenttable(subject, pt_assignment); %TRL=1 is LEFT and TRL=2 is RIGHT


%% Part 2: Import Data and Clear Irrelevant Variables in Workspace
for N=1:2
    if N==1
        % Specify the directory containing your data
        dataFolder = ['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Raw_Data\'  subject '\pre'];
        % If any sessions need to be removed
        remove_session=5;
        run_num='pre';

        % Intitialize Variables
        total_time=188*1.5;
        vol_times=1:1.5:total_time;
        count=0;
        totalduration_session=[];
    elseif N==2
        clearvars -except subject TRL savefigures savedata N concat CI_nonspecific
        dataFolder = ['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Raw_Data\'  subject '\post'];
        remove_session=0;
        run_num='post';

        % Intitialize Variables
       total_time=188*1.5;
        vol_times=1:1.5:total_time;
        count=0;
        totalduration_session=[];
    end
    % Get a list of all files in the folder
    files = dir(fullfile(dataFolder, '*.mat')); % Change '*.txt' to match the file extension of your data

    relevantFiles={};

    % Loop through each file
    for num_run = 1:numel(files)
        if num_run==remove_session
            gabor_TRL_session(3,1,num_run)=0;
            gabor_URL_session(3,1,num_run)=0;
            continue
        end
        % Get the file name
        filename = files(num_run).name;
        % Construct the full file path
        filepath = fullfile(dataFolder, filename);
        %load the filename
        load(filepath)
        count=count+1;
        clearvars -except N CI_nonspecific concat count CI_nonspecific totalduration totalduration_session run_num vol_times subject num_vol gabor_URL_cue_session gabor_TRL_cue_session gabor_URL_condition_session  gabor_TRL_condition_session TRL condtr theans mixtr rispo theothershape respTime num_run files CueOnsetTime stim_start_frame startTime savefigures dataFolder remove_session gabor_TRL_session gabor_URL_session N savedata CueOnsetTime

        % if concatenating, change timeduration
         if concat==1
             if num_run==1
                 totalduration_session(end+1)=totalduration*60;
             else
                 totalduration_session(end+1)=(totalduration_session(count-1)+(totalduration*60)); 
             end
         end

        %% Part 3: Sort based on trial type
        [gabor_trials,pd_trials, eggs_trials]=sort_trials(mixtr);

        %% Part 4: Determine trials with correct answer based on TRL vs URL location
        [gabor_TRL,gabor_URL]=attended_vs_unattended(gabor_trials,TRL, rispo);
        gabor_TRL_session(:,:,num_run)=gabor_TRL;
        gabor_URL_session(:,:,num_run)=gabor_URL;

        [pd_TRL,pd_URL]=attended_vs_unattended(pd_trials,TRL, rispo);
        pd_TRL_trials= pd_TRL(1,:);
        pd_URL_trials= pd_URL(1,:);
        pd_TRL_session(:,:,num_run)=pd_TRL;
        pd_URL_session(:,:,num_run)=pd_URL;
       


        [eggs_TRL,eggs_URL]=attended_vs_unattended(eggs_trials,TRL, rispo);
        eggs_TRL_trials= eggs_TRL(1,:);
        eggs_URL_trials= eggs_URL(1,:);
        eggs_TRL_session(:,:,num_run)=eggs_TRL;
        eggs_URL_session(:,:,num_run)=eggs_URL;

        %% Part 4: Build Design Matrix based on Gabor
        if CI_nonspecific==1
            CI_TRL=sort([pd_TRL_trials, eggs_TRL_trials])
            CI_URL=sort([pd_URL_trials, eggs_URL_trials])
        end

        [TRL_condition_matrix, URL_condition_matrix]=create_condition_matrix(gabor_TRL, gabor_URL, stim_start_frame, startTime, totalduration_session, num_run, concat, 1);
        % convert to TXT file
        filename = sprintf('Gabor_TRL_event_%d.txt', num_run);
        savedata_TRL=['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\data\txt\' run_num '\TRL'];
        fullpath = fullfile(savedata_TRL, filename);  % Creates platform-independent path
        writematrix(TRL_condition_matrix, fullpath, 'Delimiter', 'tab');

        filename = sprintf('Gabor_URL_event_%d.txt', num_run);
        savedata_URL=['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\data\txt\' run_num '\URL'];
        fullpath = fullfile(savedata_URL, filename);  % Creates platform-independent path
        writematrix(URL_condition_matrix, fullpath, 'Delimiter', 'tab');

        % CI
        [TRL_condition_matrix, URL_condition_matrix]=create_condition_matrix(CI_TRL, CI_URL, stim_start_frame, startTime, totalduration_session, num_run, concat, 2);        % convert to TXT file
        filename = sprintf('CI_TRL_event_%d.txt', num_run);
        savedata_TRL=['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\data\txt\' run_num '\TRL'];
        fullpath = fullfile(savedata_TRL, filename);  % Creates platform-independent path
        writematrix(TRL_condition_matrix, fullpath, 'Delimiter', 'tab');

        filename = sprintf('CI_URL_event_%d.txt', num_run);
        savedata_URL=['C:\Users\raglandm\Desktop\FLAP DATA\MRI_Behavior\Analyzed\' subject '\data\txt\' run_num '\URL'];
        fullpath = fullfile(savedata_URL, filename);  % Creates platform-independent path
        writematrix(URL_condition_matrix, fullpath, 'Delimiter', 'tab');


%% cue not relevant for analysis
%         [gabor_TRL_cue, gabor_URL_cue]=create_cue_condition_matrix(gabor_TRL, gabor_URL, CueOnsetTime, startTime)
%         gabor_TRL_cue_session(1,:,num_run)=gabor_TRL_cue;
%         gabor_URL_cue_session(1,:,num_run)=gabor_URL_cue;
    end
    %% Graph Accuracy
    graph_accuracy(gabor_TRL_session,gabor_URL_session, num_run, remove_session, 'Gabor', savedata, N, subject, savefigures);
    graph_accuracy(pd_TRL_session,pd_URL_session, num_run, remove_session, 'P/D', savedata, N, subject, savefigures);
    graph_accuracy(eggs_TRL_session,eggs_URL_session, num_run, remove_session, 'Eggs', savedata, N, subject, savefigures);
end



