function transmissionCost = getTransmissionCost (srcX, srcY, dstX, dstY, Packet_Size, Packet_Transmission_Cost, Amplification_Energy)
    transmissionCost = Packet_Size * (Packet_Transmission_Cost + Amplification_Energy * (getCost(srcX, srcY, dstX, dstY) ^4));
end