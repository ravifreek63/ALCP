function [numClusterHead, electedClusterHead] = calculateNumberOfClusterHead (Y, Sn_length, clusterHeadElected)
electedClusterHead = zeros (1, 10);
numClusterHead = 0;
for i = 1 : Sn_length 
    if (Y(i,i) == 1)
        numClusterHead = numClusterHead + 1;
        electedClusterHead (1, numClusterHead) = i ;
        fprintf (clusterHeadElected, '%d\t', i);
    end
end
fprintf (clusterHeadElected, '\r\n');
end