%n is the index of the new cluster head from the present cluster formed,
%using a  centralized approach on the present cluster head.
function ch_index = calculate_new_cluster_head(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode, Min_Energy, t, Y, r, isAliveMatrix, BS, Amplification_Energy_ClusterHead)
 bestLB = 0;
 bestUB = inf ;
 currentLB=0;
 currentUB=inf ;
 Sn_length = length(Sn);
 iterations(1,:)=[0 currentLB bestLB currentUB bestUB];
 pi = 2 ;
 B = zeros(Sn_length,2); 
 it_count = 0;
 Yold = Y;
  while(~stoppingCondition(it_count,bestLB,bestUB)) 
    it_count = it_count + 1;
    InverseCost = getInverseCost(Sn_Energy,D,Sn_length,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_SensorNode);
    % Step II Of The Code %
    for j = 1: Sn_length
        cost = 0;
        if (isAliveMatrix (j) ~= 1)
            continue
        end
%We are trying to find out the best cluster head for the next round from the current cluster's sensor node.        
        if(Yold(j,r) == 1)
               for i = 1 : Sn_length
                if (isAliveMatrix (i) ~= 1)
                    continue
                end   
                    if (Yold(i,r) == 1)
                        if ( i == j)
                            continue
                        end
                        if(Sn_Energy(i)> Min_Energy)
                          x1 = InverseCost(i,j) - (t*Lm(i));       % Costij  – t* lambdai  %
                          B(j,2) = B(j,2) +  min([0,x1]); % B stores (index, value), Summation(Bi) being done %      
                          if(x1<0 )
                            Y(i,j) = 1;
                            cost = cost + Packet_Size * (Packet_Transmission_Cost + Amplification_Energy_SensorNode * (D(i,j) ^2));
                          else 
                            Y(i,j) = 0;
                          end                    
                        end
                    end
               end     
              cost = cost + Packet_Size * (Packet_Transmission_Cost + Amplification_Energy_ClusterHead * (getCost(Sn(i,1),Sn(i,2),BS(1,1),BS(1,2)) ^4));
              %B(j,2) = B(j,2) + getInverseCostFromBaseStation(Sn_Energy,BS,Sn,j,Packet_Transmission_Cost, Packet_Size, Amplification_Energy_ClusterHead);
              %B(j,2) = 1 /(Energy Remaining After The Next Round); 
              residualEnergy =  Sn_Energy(j) - cost;
              B(j,2) = 1 / (residualEnergy);
              B(j,1) = j;
        end
    end
    
    %  STEP III %
    B = sortrows(B,2); % sorting the rows on 2nd column to get the first p solutions %
    % Allocating The Cluster Head Positions Cluster Heads %
  %  X = allocateClusterHeadPositions(B,Ch,p);  

     % Lower Bound Is The Sum Over 'p' smallest values of Bj.
   currentLB = sum(B(1:p,2));% sum(B((1:p),2))+ t*sum(Lm); %Calculating the Lower Bound = sum of first p and Lambda.%trace(D * transpose(Y));
    if(currentLB > bestLB)        % Current Lower Bound always has to be lesser than or equal to  Best Lower Bound %
      bestLB=currentLB;
    end

    % Calculating the Upper Bound %
     currentUB = findUB_homogeneous(D,Sn,Sn_Energy, Min_Energy, Y, B, p,r, Yold);
    if(currentUB < bestUB)
      bestUB = currentUB;
    end
    
    iterations(it_count+1,:)=[it_count currentLB bestLB currentUB bestUB];
    % STEP IV : MODIFICATION OF THE LAGRANGEAN MULTIPLIERS. USING
    % SUBGRADIENT OPTIMIZATION TECHNIQUE.http://www.hyuan.com/java/how.html
    Y2 = transpose(Y);
    norm = sum((1-sum(Y2)).^2);
    if(norm == 0) % hit the lower bound
     break
    end
    step = pi*(bestUB-currentLB)/norm; 
    x = Lm + step*(1-transpose(sum(Y2))); 
    Lm = max(0,x);
  end
  
  
ch_index = B(1,1);
if(ch_index == 0)
     for k=1:Sn_length
        ch_index = B(k,1);      
        if(ch_index ~= 0 && Yold(ch_index,r) == 1)
             break;
        end
    end
end

if (ch_index == 0)
'there'
end
end


    
   