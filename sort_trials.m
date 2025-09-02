function [gabor_trials,pd_trials, egg_trials]=sort_trials(mixtr)

gabor_trials=[];
egg_trials=[];
pd_trials=[];

% Sort Trials based on shape
for i=1:length(mixtr)
    if mixtr(i,1)==1 %gabor
        gabor_trials(end+1)=i;
    elseif mixtr(i, 1)==2 && mixtr(i,3)==1 %eggs
        egg_trials(end+1)=i;
    elseif mixtr(i,1)==2 && mixtr(i,3)==2 %eggs
        pd_trials(end+1)=i;
    end
end

end

