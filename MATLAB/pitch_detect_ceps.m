function [pitch] = pitch_detect_ceps(x)
%returns pitch detected by ceps
%   Detailed explanation goes here
Sf=20*log(abs(fft(x)));
Cn=real(ifft(abs(Sf)));
[pks,locs] = findpeaks(Cn,8*10^3);
pitch_limit=[50 400]; %human voice pitch range
elements=find(locs>pitch_limit(1) & locs<pitch_limit(2));
pks=pks(elements);
locs=locs(elements);
Max_peak=max(pks);
pitch=locs(Max_peak);
end

