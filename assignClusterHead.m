% function that allocates the Closest Cluster Head Position (That Is Already Selected) to Each Sensor Node %
function [Y,clusterHead] = assignClusterHead(Sn,D, Min_Energy, Sn_Energy,Y)
clusterHead = zeros (length(Sn),1);
  for i = 1 : length(Sn)
      if(Y(i,i) ~= 1)
              MinD = inf ;
              MinIndex = 1;
            for j =  1 : length(Sn)  
                if ((Y(j,j)) == 1 && i ~= j)
                  Dis = D(i,j);
                  if(MinD > Dis)
                      MinD = Dis ;
                      MinIndex = j;
                  end
                end
            end

            if(Sn_Energy(i)>Min_Energy)
            Y (i,MinIndex) = 1 ;
            clusterHead (i) = MinIndex ;
            end
          else 
              clusterHead (i) = i;
      end  
  end
end