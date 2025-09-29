function [block_matrix]=build_block_matrix(mixtr)
block_matrix=[];
for i=1:length(mixtr)
    if mixtr(i,1)==1 % gabor
        if mixtr(i,2)==1 % left
            block_matrix(i)=1
        elseif mixtr(i,2)==2 % right
            block_matrix(i)=2
        end
    elseif  mixtr(i,1)==2
        if mixtr(i,2)==1 % left
            block_matrix(i) = 3;
        elseif mixtr(i,2)==2 % right
            block_matrix(i) = 4;
        end
        % some other condition for mixtr(i,1) == 2
    end
end
end
