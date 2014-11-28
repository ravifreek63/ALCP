function n = clusterHeadsElected(Y, Sn_length)
n = 0; 
for i = 1 : Sn_length
     if(Y(i,i) == 1)
      n = n + 1;
     end
end