function [cat_condition]=concatenate_files(condition, totalduration_session, num_run)

if num_run>1
    cat_condition=zeros(length(condition),1)
    for i=1:length(condition)
        cat_condition(i) = condition(i) + totalduration_session(num_run-1); % Initialize cat_condition with the first condition
    end
else
    cat_condition=condition;
end