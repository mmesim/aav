function [cha_val,val]=aav(waveforms,type,co,window)


%Loop through each channel
for k=1:length(waveforms)
    j=1;
    %Window: From seconds to samples
    win=window*(1./waveforms(k).DELTA);
    %Loop through each chunk
 
        for i=1:win:length(waveforms(k).WAVEFORM)-win

        y=waveforms(k).WAVEFORM(round(i):round(i+win));
        % Remove trend
        yr=my_detrend(y,1);
        % Remove mean
        ym=yr-mean(yr);
        % Filter
        yf=my_filter(ym,type,waveforms(k).DELTA,co);
        %absolute value
        yabs=abs(yf);
        
        %store mean values
        cha_val(j,k)=mean(yabs);
        j=j+1;
        end
        %Calculate mean value and display results
        val(k,1)=mean(cha_val(:,k));
        fprintf('%s.%s : %7.4f \n',waveforms(k).KSTNM,waveforms(k).KCMPNM, val(k))
        
        
end
end