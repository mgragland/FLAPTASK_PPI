function graph_accuracy(gabor_TRL,gabor_URL, num_run, remove_session, trialtype, savedata, N, subject, savefigures)

% Total Accuracy Across Trials 
if strcmp(trialtype, 'Gabor')
    total_trials=16*(num_run-length(remove_session));
elseif strcmp(trialtype, 'P/D')
    total_trials=8*(num_run-length(remove_session));
elseif strcmp(trialtype, 'Eggs')
    total_trials=8*(num_run-length(remove_session));
end

accuracy_run_TRL=[];
accuracy_run_URL=[];

for i=1:num_run
    if gabor_TRL(3,1,i)~=0
        accuracy_run_TRL(end+1)=gabor_TRL(3,1,i);
    end
    if gabor_URL(3,1,i)~=0
        accuracy_run_URL(end+1)=gabor_URL(3,1,i);
    end
end

total_correct_TRL=sum(accuracy_run_TRL)/total_trials;
total_correct_URL=sum(accuracy_run_URL)/total_trials;

if N==1
    if strcmp(trialtype, 'Gabor')
        filename = ['pre_gabor.mat'];

    elseif strcmp(trialtype, 'P/D')
        filename = ['pre_PD.mat'];

    elseif strcmp(trialtype, 'Eggs')
        filename = ['pre_EGGS.mat'];

    end
    % Full path
    savepath = fullfile(savedata, filename);
    save(savepath, 'total_correct_TRL', 'total_correct_URL')
elseif N==2
    addpath(savedata)
    if strcmp(trialtype, 'Gabor')
        loadedData = load('pre_gabor.mat');  % savedata is the file path
        createfigures(loadedData, trialtype, total_correct_TRL, total_correct_URL, savefigures)

    elseif strcmp(trialtype, 'P/D')
        loadedData = load('pre_PD.mat');  % savedata is the file path
        createfigures(loadedData, trialtype, total_correct_TRL, total_correct_URL, savefigures)

    elseif strcmp(trialtype, 'Eggs')
        loadedData = load('pre_EGGS.mat');  % savedata is the file path
        createfigures(loadedData, trialtype, total_correct_TRL, total_correct_URL, savefigures)

    end
end
end



