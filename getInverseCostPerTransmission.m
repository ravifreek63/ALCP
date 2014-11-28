function Cost = getInverseCostPerTransmission(Sx, Sy, Dx, Dy, Se, Packet_Size , Packet_Transmission_Cost , Amplification_Energy)
distance = (((Sx - Dx)^2 + (Sy - Dy)^2)^0.5) ;
EnergyRequired = Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (distance) ^2);
Cost = 1 / (Se - EnergyRequired);