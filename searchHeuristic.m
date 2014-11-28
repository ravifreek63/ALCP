function T = searchHeuristic(Sn_Energy, Sn, Lm, p, D, Packet_Size,Packet_Transmission_Cost,Amplification_Energy, Min_Energy, t_init, BS)
S = 0.5;    % Initial Step Size
s = S ;      % Current step size %
%k = 0 ;      % current number of iterations %
kmax = 5 ;  % maximum number of iterations %
to = 0 ; % already passed by the function - initial value of the lagrangian surrogate multiplier %
t = to ; %current value of the Lagrangian Surrogate Multiplier%
T = t ; %the Lagrangian Surrogate Multiplier %
z = 0 ; % maximum value of the Obective Function %
tplus =-1 ;%undefined 
tminus = -1; %undefined 

%min_Lm
for k = 1 : kmax
    t = t + s;
    [Y,value] =  solve_p_median_searchHeuristic(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);
    if(value > z)
        T = t;
        z = value;    
        mu_lambda = 0;
        for i  = 1 : length (Sn)
              s1 = sum(Y(i,:));
              s2 = 1 - s1;
              mu_lambda = mu_lambda + Lm(i) * s2;    %mu_lambda is the slope of lagrange surrogate 
        end  
         if(mu_lambda < 0)
             tminus = t; %if slope is decreasing the current t,z = start range%
             zminus = z;
             if((tplus == -1))
                 t = t + s;             
             else
                 t = (zplus * tplus + zminus * tminus )/(zplus + zminus);
                  [Y,value]  =  solve_p_median_searchHeuristic(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);                  
                 if(value > z)
                     T = t;
                 end
                     break;
             end
         else
             tplus = t;
             zplus = z;
             if((tminus == -1))
                 t = t - s;
             else
                   t = (zplus * tplus + zminus * tminus )/(zplus + zminus);
                    [Y,value] =  solve_p_median_searchHeuristic(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);   
                     if(value > z)
                         T = t;
                     end
                     break;
             end
         
         end
    else
         t = t - s/2;
           [Y,value]  =  solve_p_median_searchHeuristic(Sn_Energy,Sn,Lm,p,D,Packet_Transmission_Cost, Packet_Size, Amplification_Energy, Min_Energy, t, BS);         
           if(value > z)
                         T = t;
           end
           break;
    end 
  
end
%here tplus and tminus gives us the range of Lagrange Surrogate Multiplier%
