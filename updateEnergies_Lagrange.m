%Function that updates the energies of the Sensor Nodes For The Current
%Round According to the Allocation Done.
function [Sn_Energy,Is_Alive, Dead_Count]=  updateEnergies_Lagrange(Sn_Energy, Y, Sn, Packet_Transmission_Cost, Packet_Size, Amplification_Energy, D,Min_Energy, death_Percent, BS)
Is_Alive = 1;
Dead_Count = 0 ;
Sensor_Nodes_Number = length(Sn_Energy); 
 for i = 1 : Sensor_Nodes_Number
   if(Sn_Energy(i) > Min_Energy)   % Whenever Energy Is Reduced Below Min_Energy (0.1 Joules Here) The Sensor Node Dies.
    for j = 1 : length(Sn)
        if(Y(i,j) == 1)         
                Cost = 2*Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (D(i,j) ^2));
     %Each Sensor Node transmits a control Message and then it also
     %transmits the corresponding collected data packet
                Sn_Energy(i) = max(0,Sn_Energy(i) - Cost) ; 
        end        
    end
    if(Y(i,i) == 1)
          Cost = 2*Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (getCost(Sn(i,1),Sn(i,2),BS(1,1),BS(1,2)) ^2));    
          %assuming cost for the broadcast as well as the Base Station
          %Packet
    end
   else
      %Is_Alive = 0;
     Dead_Count = Dead_Count + 1;
    end
 end
 if(((Dead_Count) / (Sensor_Nodes_Number)) >= death_Percent) 
    Is_Alive = 0;
 end
 