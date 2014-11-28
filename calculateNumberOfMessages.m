function numMessages = calculateNumberOfMessages (Sn_length, Y) 
clusterSize = getClusterSizes (Sn_length, Y);
numMessages = 0;
for i = 1 : Sn_length
if (Y(i,i) == 1)
    numMessages = numMessages + clusterSize (i) ;
end
end

end