function pitch = pitch_detect_corr( x )
%

% Consts
Fs = 8e3; % [Hz]
F_max = 400; % [Hz] - maximum possible pitch frequency
F_min = 50; % [Hz] - minimum possible pitch frequency

pitch_min = Fs/F_max;
pitch_max = Fs/F_min;

[r,lags] = xcorr (x);

r = r(lags >= 0);

local_max = (r(1:(end-2)) <= r (2:(end-1))) & (r(3:(end)) <= r (2:(end-1)));
local_max = [false; local_max(:); false]; % add leading and ending zeros to keep the length

local_max (1:pitch_min) = false; % pitch not possible at these offsets
local_max (pitch_max:end) = false; % pitch not possible at these offsets

local_max_offsets = find (local_max);

[r_pitch,index] = max (r (local_max) );

pitch = local_max_offsets(index) - 1; % offset 1 is lag 0, so "-1" is needed

end