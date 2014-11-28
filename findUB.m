function currentUB = findUB(D,Sn,Sn_Energy, Min_Energy,Y, B, p)
 % Assigning The Closest Selected Cluster Head Position To The Sensor Node %
Sn_len = length(Sn);
 Y = zeros (Sn_len, Sn_len);
 for i=1:p
 index = B(i,1);
 Y(index,index) = 1;
 end
 Y = assignClusterHead(Sn,D,Min_Energy,Sn_Energy,Y);
currentUB = 0 ; 
for i = 1 : length(Sn)
     for j= 1 : length(Sn)
        if (Y(i,j) == 1)
            currentUB = currentUB + D(i,j);
        end
     end
end
%currentUB = currentUB + t*sum(Lm);