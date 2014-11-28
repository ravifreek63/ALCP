function value = checkIfallDead(Sn_Energy, Y, r, Min_Energy)
value = 1;
Sn_len = length(Sn_Energy);
for i=1:Sn_len
    if((Y(i,r) == 1))
        if ((Sn_Energy(i) > Min_Energy))
            value = 0;
             break;
        end
    end
end