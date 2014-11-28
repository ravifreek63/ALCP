function [Y, clusterHead] = solve_p_median_homogeneous(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode, Min_Energy, t, BS,  Y, isAliveMatrix, Amplification_Energy_ClusterHead)
   % t = 1; %Initially Lagrangean Multiplier assumed to be 1 --> solving Lagrangian and not Surrogate here.%
 Sn_length = length(Sn);
 ar = zeros(p,1);
 count = 0;
 
 % For the calculation of X
   for r = 1 : Sn_length
        if(Y(r,r) == 1) % if the rth sensor node is currently the cluster head Here X is updated so that the sensor node with the greater amount of energy in the current cluster gets chosen.
            if (isAliveMatrix (r) ~= 1)
                'CH died after the last round'                
                continue 
            end
            
            if(~checkIfallDead(Sn_Energy, Y, r, Min_Energy)) 
                  count = count + 1;          
                ar(count) = calculate_new_cluster_head(Sn_Energy,Sn,Lm,1,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode, Min_Energy, t, Y, r, isAliveMatrix, BS, Amplification_Energy_ClusterHead);                              
            else
                count = count+1;
                ar(count) = r;                
            end    
            
        end
   end
   
Y = zeros(Sn_length);
for i = 1: count  
    index = ar(i);
    if (index == 0)
        'there'
    end
        
    Y(index, index) = 1;    
end

%For the calculation of Y
[Y, clusterHead] = assignClusterHead(Sn,D, Min_Energy,Sn_Energy,Y);
%Y = assignClusterHead_withExtraParameters(Sn,D, Min_Energy,Sn_Energy,Y,BS, Packet_Size , Packet_Transmission_Cost , Amplification_Energy);
%    value  = sum((Y * transpose (D)));
 %'homogeneous'
% Y



