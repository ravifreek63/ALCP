% Code For Homogeneous Adaptation To The Lagrangean Solution. %
clc
death_Percent = 0.0;
while(death_Percent <= 0.9)
death_Percent = death_Percent + 0.1;
death_Percent
L = 100;
Packet_Size = 2000; % packet size 2000 units.
Packet_Transmission_Cost = 50 * (10 ^ -9); % Packet Transmission Cost = 50 nano Joule per Bit per Packet
Amplification_Energy = 100 * (10 ^ -12);   % Packet Amplification Cost = 100 pico Joule per Bit per metre squared
Min_Energy = 0.01;
Count_Max = 1;
count = 0;
t_init = 1;
n = 100; % Total Number Of Sensor Nodes.%
Transmission_Radius = ( L) / (sqrt(3.14 * 0.05 *n));
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
Sn = Sn1(1:n,1:2);
%length(Sn);
%Sn = Sn1(1:10,1:2);
D = zeros(Sn_length,Sn_length);   % Distance Matrix , n*n %
% CALCULATING THE COST Matrix %
    for i=1 : Sn_length
        for j=1 : Sn_length
            D(i,j) = getCost(Sn(i,1),Sn(i,2),Sn(j,1),Sn(j,2)); % Computing The Cost Function That Is The Distance Matrix Between The Sensor Node And The Cluster Head %
        end
    end
%death_Percent = 0.3;
%death_Percent*100;
while (count < Count_Max)
FirstDie_Iteration_Count_1 = 0;
FirstDie_Iteration_Count_2 = 0;
count = count + 1;
Sn_Energy = ones(n,1) * 0.5; %Initial Energy for each Sensor Node = 0.5 J.
%Calculates the inverse of the residual energy if a message is transmitted
%from sensor node i to sensor node j
InverseCost = getInverseCost(Sn_Energy,D,Sn_length,Packet_Transmission_Cost, Packet_Size, Amplification_Energy);
min_Lm = min(min(InverseCost));
Lm = ones(Sn_length,1)*min_Lm ; 
%'Lm' 
%Lm
%Lm = ones(n,1)* 50;% Lagrangian Multipliers %  
t = searchHeuristic(Sn_Energy, Sn, Lm, p, D, Packet_Size,Packet_Transmission_Cost,Amplification_Energy, Min_Energy, t_init, BS );
Is_Alive = 1;
%     Sn_Energy = ones(n,1) * 0.5; %Initial Energy for each Sensor Node = 0.5 J.
     num_it = 0;Dead_Count = 0;Last_Dead_Count = 0;index = 1;V_1 = zeros(30,2);STD_1 = zeros(10000,2);ARE_1 = zeros(10000,2);%it_max = 1000;Sn_Energy_STD = zeros(10,1);
     init = 0;
     while(Is_Alive == 1)
      %while(num_it < it_max)
        num_it = num_it + 1;
        Lm = ones(n,1)*50;% Lagrangian Multipliers %    
        FirstDie_Iteration_Count_1 = FirstDie_Iteration_Count_1 + 1 ; 
        if(init == 0)
            Y = solve_p_median_centralized(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);
            init = 1;
        else
             Y = solve_p_median_homogeneous(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t,BS, Y);
        end
   
      %  [X,Y,value] = solve_p_median_homogeneous(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);
        [Sn_Energy,Is_Alive, Dead_Count, isAliveMatrix] = updateEnergies(Sn_Energy, Y, Sn,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, D, Min_Energy, death_Percent, BS);
      end
      Sn_Energy_1 = Sn_Energy ;

Number_Of_Iterations_Inverse_Cost_Method =  (FirstDie_Iteration_Count_1);
%Number_Of_Iterations_Static_Method =  (FirstDie_Iteration_Count_2);
%ratio = Number_Of_Iterations_Inverse_Cost_Method/Number_Of_Iterations_Static_Method;

Number_Of_Iterations_Inverse_Cost_Method
%Number_Of_Iterations_Static_Method
%ratio

Avg_Residual_Energy_Lagrange = (sum (Sn_Energy_1))/n;
%Avg_Residual_Energy_Static_Method = (sum (Sn_Energy))/n

Standard_Dev_Energy_Lagrange = std (Sn_Energy_1(:));
%Standard_Dev_Energy_Static_Method = std (Sn_Energy(:));

'Avg_Residual_Energy'
Avg_Residual_Energy_Lagrange
'Standard_Dev_Energy'
Standard_Dev_Energy_Lagrange

%Standard_Dev_Energy_Inverse_Cost_Method
%Standard_Dev_Energy_Static_Method
end
'********************************************************************************************************************************************'
end

