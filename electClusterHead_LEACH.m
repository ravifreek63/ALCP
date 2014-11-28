function [Y, LS] = electClusterHead_LEACH(num_it, Sn, LS,p, Sn_Energy, Min_Energy)
Sn_len = length(Sn);
Y = zeros(Sn_len);
r = Sn_len/p;
% r = 100 / 5  = 20 % problem for the first 20 rounds
prob = 1/(r - mod(num_it,r)); 
for i = 1: Sn_len
%Y(i,i)=0;
if(Sn_Energy(i) > Min_Energy)
if(LS(i)+r <= num_it)
    if(random('unif',0,1) <= prob)
        LS(i) = num_it;
        Y(i,i)=1;
    end
end
end
end
