function currentUB = findUB_homogeneous(D,Sn,Sn_Energy, Min_Energy,Y, B, p,oldChIndex, Yold)
 % Assigning The Closest Selected Cluster Head Position To The Sensor Node %
Sn_len = length(Sn);
 Y = zeros (Sn_len, Sn_len);
 for i=1:p
 index = B(i,1);
 if(index ==0)
 for k=1:Sn_len
 index = B(k,1);      
 if(index ~= 0 && Yold(index,oldChIndex) == 1)
     break;
 end
 end
 end
 Y(index,index) = 1;
 end
 Y = assignClusterHead_homogeneous(Sn,D,Min_Energy,Sn_Energy,Y, oldChIndex, Yold);
currentUB = 0 ; 
for i = 1 : length(Sn)
     for j= 1 : length(Sn)
        if (Y(i,j) == 1 && Yold(i,j) == 1)
            currentUB = currentUB + D(i,j);
        end
     end
end
%currentUB = currentUB + t*sum(Lm);