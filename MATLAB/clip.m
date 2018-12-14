function [n_clipped] = clip(x)
%clip clips x with C_l of 65%
%   Detailed explanation goes here
 Cl=0.65*max(x);
 greater=find(x>Cl);
 smaller=find(x<-Cl);
 n_clipped=zeros(1,length(x));
 n_clipped(greater)=x(greater)-Cl;
 n_clipped(smaller)=x(smaller)+Cl;

end

