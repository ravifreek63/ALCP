function [X,Y,value] = solve_k_means(Sn_Energy,Sn,Ch,p,D,Min_Energy)
%Sn = readFromFile('SensorNode.txt');
%Ch_2 = readFromFile('ClusterHead.txt');
%k = 10;
%Ch =  Ch_2(1:k,:);
%p = 5; % number of clusters to be formed
length_CH = length(Ch);
X = zeros(length_CH,p);
[cidx, ctrs] = k_means(Sn, p);
% selecting closest cluster head positions
allocated = zeros(length_CH,1);
for j =1: p % iterating over all the centroid positions
    MIN_DIS = inf;
    MIN_DIS_IDX = 1;
    for i = 1 : length_CH
        if(allocated(i) == 0)
            d = getCost(ctrs(j,1),Ch(i,1),ctrs(j,2),Ch(i,2));
            if(d < MIN_DIS)
                d = MIN_DIS ;
                MIN_DIS_IDX = i;
                
             %   allocated(i) = 1;
            end
        end
    end
 % We are here aproximating the selected centroid location by the closest
 % cluster head  location 
 X(MIN_DIS_IDX,j) = 1;   
 allocated(MIN_DIS_IDX) = 1;
end
Y = assignClusterHead(X,Sn,Ch,D, Min_Energy,Sn_Energy);
value  = sum((Y * transpose (D)));
%plot(Sn(cidx==1,1),Sn(cidx==1,2),'r.',Sn(cidx==2,1),Sn(cidx==2,2),'b.', ctrs(:,1),ctrs(:,2),'kx');