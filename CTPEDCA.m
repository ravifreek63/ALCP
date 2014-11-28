% Code For Implementing LEACH. %
clc
death_Percent = 0.1;
%while(death_Percent <= 0.9)
%death_Percent = death_Percent + 0.1;
%death_Percent 
Packet_Size = 2000; % packet size 2000 units.
Packet_Transmission_Cost = 50 * (10 ^ -9); % Packet Transmission Cost = 50 nano Joule per Bit per Packet
Amplification_Energy = 100 * (10 ^ -12);   % Packet Amplification Cost = 100 pico Joule per Bit per metre squared
Min_Energy = 0.01;
Count_Max = 1;
count = 0;
t_init = 1;
n = 100; % Total Number Of Sensor Nodes.%
p = 5;  % Total Number Of Cluster Heads To Be Chosen.%
%Sn = rand(n,2) * 100; %Sensor Nodes positions generated randomly, (array size of n*2) %
Sn_length = n; 
%Co-ordinates for the Base Station %
BS = zeros(1,2);
% Array to store the inverse cost between a particular sensor node and a
% base station.
SN_BS_Cost = zeros(Sn_length);
Y = zeros(Sn_length, Sn_length);
%writeToFile(Sn,'SensorNode.txt');    %Code That Writes The Sensor Node Positions To The File.
Sn1 = readFromFile('SensorNode.txt');
%length(Sn);
Sn = Sn1(1:n,1:2);
D = zeros(Sn_length,Sn_length);   % Distance Matrix , n*n %

% CALCULATING THE COST Matrix %
    for i=1 : Sn_length
        for j=1 : Sn_length
            D(i,j) = getCost(Sn(i,1),Sn(i,2),Sn(j,1),Sn(j,2)); % Computing The Cost Function That Is The Distance Matrix Between The Sensor Node And The Cluster Head %
        end
    end

LS = zeros(length(Sn));    
Iteration_Count = 0;
count = count + 1;
Sn_Energy = ones(n,1) * 0.5; %Initial Energy for each Sensor Node = 0.5 J.
%Calculates the inverse of the residual energy if a message is transmitted
%from sensor node i to sensor node j
Is_Alive = 1;
     num_it = 0;Dead_Count = 0;Last_Dead_Count = 0;index = 1;V_1 = zeros(30,2);STD_1 = zeros(10000,2);ARE_1 = zeros(10000,2);%it_max = 1000;Sn_Energy_STD = zeros(10,1);
     init = 0;
     while(Is_Alive == 1)
  
        num_it = num_it + 1;
        Iteration_Count = Iteration_Count + 1 ; 
%Stage I: Cluster Head Election Phase
        [Y,Ls] = electClusterHead_LEACH(num_it, Sn, LS,p, Sn_Energy, Min_Energy);
%Formation Of Clusters Based On The Closest Distance Parameter        
        Y = formClusters_LEACH(Sn,Y, D, Sn_Energy, Min_Energy);
%Form The Minimum Spanning Tree        
        
%The Steady State Phase Considered Here        
        [Sn_Energy,Is_Alive, Dead_Count] = updateEnergies_LEACH(Sn_Energy, Y, Sn,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, D, Min_Energy, death_Percent,BS);
 
      end
      Sn_Energy_1 = Sn_Energy ;

Iteration_Count
'Average Residual Energy LEACH'
sum(Sn_Energy)/n
'Standard deviation Residual Energy LEACH'
std(Sn_Energy)
'********************************************************************************************************************************************'
%end