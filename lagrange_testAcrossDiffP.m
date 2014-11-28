% Code For Homogeneous Adaptation To The Lagrangean Solution. %
clc
death_Percent = 0.0;
max_death_Percent = 1.0;
%currentRatio = 0.1
p = 1; 
while(p<10)
death_Percent = 1;
numDeadArray = zeros (2000, 1);
deadSensorNodeMatrix = zeros (2000, 100);
typeOfdeadSensorNodeMatrix = zeros (2000, 100);
clusterSizes = zeros (2000, 100);
totalSensorsAssigned = zeros (2000, 1);
L = 100;
Packet_Size = 4000; % packet size 500 Bytes => 4000 bits.
Packet_Transmission_Cost = 50 * (10 ^ -9); % Packet Transmission Cost = 50 nano Joule per Bit per Packet
Amplification_Energy_ClusterHead = 13 * (10 ^ -16);   % Packet Amplification Cost = 0.0013 pico Joule per Bit per metre squared
Amplification_Energy_SensorNode = 10  * (10 ^ (-12)); % 
Energy_Data_Aggregation = 5 * (10 ^ -9);
Min_Energy = 0.01;
Count_Max = 1;
count = 0;
t_init = 1;
n = 100; % Total Number Of Sensor Nodes.%
Transmission_Radius = (L) / (sqrt(3.14 * 0.05 *n));
 % Total Number Of Cluster Heads To Be Chosen.%
clusterHierarchicalFlag = 0;
%Sn = rand(n,2) * 100; %Sensor Nodes positions generated randomly, (array size of n*2) %
Sn_length = n; 
%Co-ordinates for the Base Station %
BS = [50 175];
% Array to store the inverse cost between a particular sensor node and a
% base station.
SN_BS_Cost = zeros(Sn_length);
Y = zeros(Sn_length, Sn_length);
%writeToFile(Sn,'SensorNode.txt');    %Code That Writes The Sensor Node Positions To The File.
Sn1 = readFromFile('SensorNode.txt');
Sn = Sn1(1:n,1:2);
Y_2 = zeros (Sn_length, Sn_length);
numClusterHeadMatrix = zeros (5000, 1);
numMessagesMatrix = zeros (5000, 1);
electedClusterHeadMatrix = zeros (5000, p);

%Updating the Distance Information%
D = zeros(Sn_length,Sn_length);   % Distance Matrix , n*n %
% CALCULATING THE COST Matrix %
    for i=1 : Sn_length
        for j=1 : Sn_length
            D(i,j) = getCost(Sn(i,1),Sn(i,2),Sn(j,1),Sn(j,2)); % Computing The Cost Function That Is The Distance Matrix Between The Sensor Node And The Cluster Head %
        end
    end
    
    
%Updating One Hop Neighbor Inforamtion%
oneHopNeighborInfo = zeros (Sn_length, Sn_length);

for i = 1 : Sn_length 
    k = i+1 ;
    for j = k : Sn_length
        if (D (i, j) <= 2* Transmission_Radius)
           oneHopNeighborInfo (i,j) = 1;     
           oneHopNeighborInfo (j,i) = 1;
        end
    end
end

isAliveMatrix = ones (Sn_length, 1);   
    
%while (count < Count_Max)
FirstDie_Iteration_Count_1 = 0;
FirstDie_Iteration_Count_2 = 0;
count = count + 1;
Sn_Energy = ones(n,1) * 0.5; %Initial Energy for each Sensor Node = 0.5 J.
%Calculates the inverse of the residual energy if a message is transmitted from sensor node i to sensor node j

InverseCost = getInverseCost(Sn_Energy,D,Sn_length,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode);
min_Lm = min(min(InverseCost));
Lm = ones(Sn_length,1)*min_Lm ; 
t = searchHeuristic(Sn_Energy, Sn, Lm, p, D, Packet_Size,Packet_Transmission_Cost,Amplification_Energy_SensorNode, Min_Energy, t_init, BS );
Is_Alive = 1;
%     Sn_Energy = ones(n,1) * 0.5; %Initial Energy for each Sensor Node = 0.5 J.
     num_it = 0;Dead_Count = 0;Last_Dead_Count = 0;index = 1;V_1 = zeros(30,2);STD_1 = zeros(10000,2);ARE_1 = zeros(10000,2);%it_max = 1000;Sn_Energy_STD = zeros(10,1);
     init = 0;
     while(true)
     %    if (mod(num_it, 100) == 0)
             %init = 0;
      %   end
%      while(num_it < it_max)
        num_it = num_it + 1;
        Lm = ones(n,1)*50;% Lagrangian Multipliers %    
        FirstDie_Iteration_Count_1 = FirstDie_Iteration_Count_1 + 1 ; 
        if(init == 0)
            [Y, clusterHead] = solve_p_median_centralized(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode, Amplification_Energy_ClusterHead, Min_Energy, t, BS);            
            init = 1;   
            if (clusterHierarchicalFlag == 1)
            [Y, clusterHead] = clusterHierarchically (Sn_length, Y, oneHopNeighborInfo, isAliveMatrix, Sn, BS, Packet_Size, Packet_Transmission_Cost, Amplification_Energy_ClusterHead, clusterHead, Sn_Energy);                     
            end
            [numClusterHead, electedClusterHead] = calculateNumberOfClusterHead (Y, Sn_length);
            electedClusterHeadMatrix (num_it, 1:numClusterHead) = electedClusterHead (1, 1:numClusterHead);
            numClusterHeadMatrix (num_it) =  numClusterHead ;
            numMessages = calculateNumberOfMessages (Sn_length, Y);
            numMessagesMatrix (num_it) = numMessages ;
            
        else
             [Y, clusterHead] = solve_p_median_homogeneous(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode, Min_Energy, t,BS, Y, isAliveMatrix, Amplification_Energy_ClusterHead);            
              if (clusterHierarchicalFlag == 1)
                [Y, clusterHead] = clusterHierarchically (Sn_length, Y, oneHopNeighborInfo, isAliveMatrix, Sn, BS, Packet_Size, Packet_Transmission_Cost, Amplification_Energy_ClusterHead, clusterHead, Sn_Energy);
              end
            [numClusterHead, electedClusterHead] = calculateNumberOfClusterHead (Y, Sn_length);
            electedClusterHeadMatrix (num_it, 1:numClusterHead) = electedClusterHead (1, 1:numClusterHead);
            numClusterHeadMatrix (num_it) =  numClusterHead ;
            numMessages = calculateNumberOfMessages (Sn_length, Y);
            numMessagesMatrix (num_it) = numMessages ;
        end  
   
             [Sn_Energy,Is_Alive, Dead_Count, isAliveMatrix] = updateEnergies (Sn_Energy, Y, Sn,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_ClusterHead, Amplification_Energy_SensorNode, D, Min_Energy, death_Percent, BS, clusterHead, Energy_Data_Aggregation, Transmission_Radius, clusterHierarchicalFlag);
             ratioDead = Dead_Count / Sn_length ;             
             if ((ratioDead) >= death_Percent)
                 p
                num_it
                break;
             end             
            % if ((ratioDead) >= max_death_Percent)  
             %    break;
             %end
             [numDeadArray, deadSensorNodeMatrix, typeOfdeadSensorNodeMatrix] = countNumDead (isAliveMatrix, num_it, numDeadArray, deadSensorNodeMatrix, typeOfdeadSensorNodeMatrix, Y);
             [clusterSizes, totalSensorsAssigned] = getClusteSize (Y, electedClusterHeadMatrix, num_it, clusterSizes, totalSensorsAssigned);
             %numDeadArray (num_it) = numDead;
            % deadSensorNodeMatrix (num_it) = deadSensorNodeArray;
      end
      %Sn_Energy_1 = Sn_Energy ;

p = p + 1;
'********************************************************************************************************************************************'
end

