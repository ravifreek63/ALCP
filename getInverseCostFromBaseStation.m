function Cost = getInverseCostFromBaseStation(Sn_Energy,BS,Sn,j,Packet_Transmission_Cost, Packet_Size, Amplification_Energy)
        D = getCost(BS(1,1),BS(1,2),Sn(j,1),Sn(j,2));
        Cost = 1/((Sn_Energy(j) - Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (D ^4))))^1;
%'inverse cost from the Base Station' 
%Cost