function [BOOL] = vu_classify(frame1,frame2)
%vu_classify this function recieves two frames, one original and one
%preprocessed, and returns if the frame is Voiced or Unvoiced
%   Detailed explanation goes here


%short-time energy function
N=256;
count=0;
En=frame1.^2;
Fs=8*10^(3);
Ts=1/Fs;
En=(1/N)*sum(En);
max_frame = abs(max(frame1));
if En<10^(-5)
    
    BOOL=false;
    return; 
end

if zero_cross(frame1)>(N/2)
    count=count+1;
end

if En<0.1*max_frame
    count=count+1;
end


autocorr=xcorr(frame2);
autocorr=autocorr(256:end);


%figure; plot(autocorr);
TF=islocalmin(autocorr);
TF1=find(TF);
TF1=TF1(1);

[pks ,locs] = findpeaks(autocorr(TF1:end),Fs);
auto_zero = sum(frame2.^2);
max_peak=max(pks);

max_loc=locs(pks==max_peak);

if max_loc>1/50 || max_loc<1/400 
    count=count+1;
end

if max_peak/auto_zero<0.35
    count=count+1;
end

if count<2
    
   BOOL=1;
   
else 
    BOOL=0;
end




    
end

