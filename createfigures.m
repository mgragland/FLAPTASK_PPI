function createfigures(loadedData, trialtype, total_correct_TRL, total_correct_URL, savefigures)

figure
x=1:2;
y=[loadedData.total_correct_TRL, total_correct_TRL; loadedData.total_correct_URL, total_correct_URL];
b=bar(x,y);
ylim([0,1.1]);
xticks([1 2]);
xticklabels({'TRL', 'URL'})
ylabel('Percentage Correct')
if strcmp(trialtype, 'Gabor')
    title('Accuracy on Gabor Trials')
    filename = ['post_gabor'];

elseif strcmp(trialtype, 'P/D')
    title('Accuracy on P/D Trials')
    filename = ['post_PD'];
    % save current figure as JPEG


elseif strcmp(trialtype, 'Eggs')
    title('Accuracy on Egg Trials')
    filename = ['post_Eggs'];
    % save current figure as JPEG

end
savepath = fullfile(savefigures, filename);
saveas(gcf, savepath)

end

       