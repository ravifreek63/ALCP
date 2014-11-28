function Lb = findLB(D,Sn,Lm,Y,t,BS)
Lb = 0 ;
%Y = zeros(length(Sn), length(Ch));  
 for j = 1: length(Sn)
     if(Y(j,j) == 1)
         Lb = Lb + getCost(BS(1,1),BS(1,2),Sn(j,1),Sn(j,2));  %Adding to the Lower Bound the Cost For The Cluster Head Also here.
        for i = 1 : length(Sn)
          x1 = D(i,j) - (t*Lm(i));       % Costij  – t* lambdai  %
          if(x1 < 0)
            %Y(i,j) = 1;
            Lb = Lb + D(i,j);
          else 
            %Y(i,j) = 0;
          end                    
        end    
     end
 end
 