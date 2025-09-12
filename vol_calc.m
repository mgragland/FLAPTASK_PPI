function [num_vol, vol_times]=vol_calc(TR, TRwait)
num_vol=0;
vol_times=zeros(1,188); %should be 188= 282/TR
for i=1:length(TRwait)
    if TRwait(i)==0
        num_vol=num_vol+1;
    elseif TRwait(i)==1
        num_vol=num_vol+2;
    elseif TRwait(i)==2
        num_vol=num_vol+3;
    end
end


for ii=1:length(vol_times)
    if ii==1
        vol_times(ii)=TR
    else
        vol_times(ii)=vol_times(ii-1)+TR
    end
end
