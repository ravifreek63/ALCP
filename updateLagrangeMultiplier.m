%function that calculates the value of Lagrangian Multiplier.
function Lm = updateLagrangeMultiplier (Sn_Energy, reduction_Factor,Packet_Transmission_Cost, Packet_Size, Amplification_Energy)
Lm = zeros(length(Sn_Energy),1);
   for i = 1 : length(Sn_Energy)
    Lm(i) = sqrt((((Sn_Energy(i) * reduction_Factor)/(Packet_Size)) - Packet_Transmission_Cost)/(Amplification_Energy));
   end