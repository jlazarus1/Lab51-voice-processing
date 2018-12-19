function [x] = P_seg(segment_length,P,segment_num)
%creates a periodic impuls train
% inputs
% x = signal
% N = # of samples
% P = # of prtitions
%outputs
% y = unifide segmented signals vector(continues)


%create delta of lenght segment_length
x=zeros(1,segment_length);
x(1:P:segment_length)=1;

%here we concatenate the segments
for i=2:segment_num
    delta_placement = P+1-mod(segment_length*(i-1),P);
    if delta_placement>P
        delta_placement=1;
    end
    x((i-1)*segment_length+delta_placement:P:i*segment_length)=1;
end




end


