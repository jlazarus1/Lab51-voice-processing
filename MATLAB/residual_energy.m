function [Eu] = residual_energy(frame,A_vec)
%UNTITLED Recieves a frame and a vector of a filter and returns the average
%energy of the linear aprox. 
%   Detailed explanation goes here
filtered=filter(A_vec,1,frame);
Eu=sum(abs(filtered).^2)/(length(filtered));
end

