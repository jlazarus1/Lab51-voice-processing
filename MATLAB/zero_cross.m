function [crosses] = zero_cross(n)
%Calculates the amount of zero crossing in n
%   Detailed explanation goes here
zci =find(n(:).*circshift(n(:), [-1 0]) <= 0);
crosses=size(zci);
end

