function [pitch] = pitch_detect_ceps(x)
%returns pitch detected by ceps
%   Detailed explanation goes here
pitch_limit=[50 400]; %human voice pitch range


Sf=20*log(abs(fftshift(fft(x))));
Cn=real(ifft(abs(Sf)));

[pks,locs,~,~] = findpeaks(Cn,8*10^3);

elements=find(locs<(1/pitch_limit(1)));
elements=find(locs>(1/pitch_limit(2)));
[~ ,index]=max(pks(elements));
pitch = 1/locs(index);


end

