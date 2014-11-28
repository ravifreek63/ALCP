function  [Last_Dead_Count, V, index] = updateDeadCount (Dead_Count,Last_Dead_Count,V, index, num_it, Sn_Energy)
 if(Dead_Count > Last_Dead_Count)
            Last_Dead_Count = Dead_Count;
            V(index,1) = num_it;
            V(index,2) = Dead_Count;
            index = index + 1;
 end