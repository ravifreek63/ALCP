function Y = formClusters_LEACH(Sn,Y, D, Sn_Energy, Min_Energy)
Sn_len = length(Sn);
for i = 1: Sn_len
if(Y(i,i) ~= 1)  % The Node Should Not Be A Cluster Head
if(Sn_Energy(i) > Min_Energy)  % The Node Should Be Alive
MinDis = inf;
MinDis_Index = i;
%Calculating Index (MinDis_Index) Of The Closest Cluster Head
for j = 1:Sn_len
    if(i ~= j && Y(j,j) == 1)%The Cluster Head And Sensor Node should Not Be the same && j Should be A Cluster Head 
    currDis = D(i,j);
        if(currDis < MinDis)
            MinDis_Index = j;
            MinDis = currDis;
        end
    end
end 
Y(i, MinDis_Index) = 1;     
end
end
end
end
