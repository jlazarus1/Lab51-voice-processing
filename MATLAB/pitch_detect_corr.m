function [pitch] = pitch_detect_corr(x)
% this function receives an input x and returns the pitch that correlates
% to that input
%   Detailed explanation goes here
r=xcorr(x);
[pks,locs]=findpeaks(r,8*10^3,'MinPeakHeight',1/(8*10^3));
pitch_limit=[50 400]; %human voice pitch range
elements=find(locs>pitch_limit(1) & locs<pitch_limit(2));
pks=pks(elements);
locs=locs(elements);
MAX_peak=max(pks);
pitch=locs(MAX_peak);

end

