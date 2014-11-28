function Cost = getInverseCost(Sn_Energy,D,Sn_length,Packet_Transmission_Cost, Packet_Size, Amplification_Energy)
Cost = zeros(Sn_length, Sn_length);
for i = 1 : Sn_length
    for j = 1 : Sn_length
        Cost(i,j) = 1/((Sn_Energy (i) - Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (D(i,j) ^2))));
    end
end