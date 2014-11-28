% function that allocates the Closest Cluster Head Position (That Is Already Selected) to Each Sensor Node %
function Y = assignClusterHead_withExtraParameters(Sn,D, Min_Energy, Sn_Energy,Y, BS, Packet_Size , Packet_Transmission_Cost , Amplification_Energy)
%Y = zeros(length(Sn),length(Sn)); % Initializing With Zero The Sensor Node -Cluster Head Allocation Matrix.
  for i = 1 : length(Sn)
  if(Y(i,i) ~= 1)
      Cost = inf ;
      MinIndex = 1;
    for j =  1 : length(Sn)  
        if ((Y(j,j)) == 1 && i ~= j)
          Cost_pair = getInverseCostPerTransmission(Sn(i,1),Sn(i,2),Sn(j,1),Sn(j,2),Sn_Energy(i), Packet_Size , Packet_Transmission_Cost , Amplification_Energy) + getInverseCostPerTransmission(Sn(j,1),Sn(j,2),BS(1,1),BS(1,2),Sn_Energy(j), Packet_Size , Packet_Transmission_Cost , Amplification_Energy);
          if(Cost > Cost_pair)
              Cost = Cost_pair ;
              MinIndex = j;
          end
        end
    end
    
    if(Sn_Energy(i)>Min_Energy)
    Y (i,MinIndex) = 1 ;
    end
  end  
  end
