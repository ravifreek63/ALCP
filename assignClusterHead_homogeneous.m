% function that allocates the Closest Cluster Head Position (That Is Already Selected) to Each Sensor Node %
function Y = assignClusterHead_homogeneous(Sn,D, Min_Energy, Sn_Energy,Y, oldChIndex, Yold)
%Y = zeros(length(Sn),length(Sn)); % Initializing With Zero The Sensor Node -Cluster Head Allocation Matrix.
  for i = 1 : length(Sn)
  if(Yold(i,oldChIndex) == 1 && Y(i,i) ~= 1)
      MinD = inf ;
      MinIndex = 1;
    for j =  1 : length(Sn)  
        if(Yold(i, oldChIndex) ==1 && (Y(j,j)) == 1 && i ~= j)
          Dis = D(i,j);
          if(MinD > Dis)
              MinD = Dis ;
              MinIndex = j;
          end
        end
    end
    
    if(Sn_Energy(i)>Min_Energy)
    Y (i,MinIndex) = 1 ;
    end
  end  
  end
