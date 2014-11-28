% Allocating The Cluster Heads Based On The Least Value In The Array %
function Y = allocateClusterHeadPositions(B,p,Y)
 %X = zeros(length(Ch),p);          % Cluster Head Position - Cluster Head Matrix. m*p%
   for i = 1 : p
       index = B(i,1);          % Taking The value Of The ith index in the sorted array.
       Y(index,index) = 1;          % Assigning ith index in B to Nay particular Cluster Head.
   end