function [gabor_trials,pd_trials, egg_trials]=sort_trials(mixtr)

gabor_trials={};
egg_trials={};
pd_trials={};

gabor_left=[];
gabor_right=[];
eggs_left=[];
eggs_right=[];
pd_left=[];
pd_right=[];

% Sort Trials based on shape
for i=1:length(mixtr)
    if mixtr(i,1)==1 % gabor
        if mixtr(i,2)==1 % left
            gabor_left(end+1)=i;
        elseif mixtr(i,2)==2 % right
            gabor_right(end+1)=i;
        end
    elseif mixtr(i, 1)==2 && mixtr(i,3)==1 %eggs
        if mixtr(i,2)==1 % left
            eggs_left(end+1)=i;
        elseif mixtr(i,2)==2 % right
            eggs_right(end+1)=i;
        end
    elseif mixtr(i,1)==2 && mixtr(i,3)==2 %pd
        if mixtr(i,2)==1 % left
            pd_left(end+1)=i;
        elseif mixtr(i,2)==2 % right
            pd_right(end+1)=i;
        end
    end
end
   
              

gabor_trials{1}=gabor_left;
gabor_trials{2} = gabor_right;
egg_trials{1} = eggs_left;
egg_trials{2} = eggs_right;
pd_trials{1} = pd_left;
pd_trials{2} = pd_right;
end


