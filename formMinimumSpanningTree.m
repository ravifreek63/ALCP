function tree = formMinimumSpanningTree(Y, Sn,  Sn_length, BS, num_heads)
       tree = zeros(num_heads,1);
       distance = zeros(num_heads, 2);
% tree = {Base Station}
       currNode = BS;      %currNode = BS
% The Columns are xpos, ypos, id, distance, isInCLuster or Not from the spanning tree set of nodes       
       headsElected = zeros(num_heads, 3, 4);   
       currPos = 1;
% Building The tree of the elected cluster head nodes here       
       for i = 1 : Sn_length
            if(Y(i,i) == 1)
                headsElected(currPos, 1) = Sn(i,1);
                headsElected(currPos, 2) = Sn(i,2);
                headsElected(currPos, 3) = i;
                headsElected(currPos, 4) = inf;
%Bool used to differentiate the set of elected nodes from the set of
%remaining nodes.
                headsElected(currPos, 5) = 0;
            end
       end
%updating the tree here
for j = 1 : num_heads    
%update the position for each node in the tree from the present set of nodes
for i = 1 : num_heads
   if(headsElected ~= 0)
        dis = getCost(headsElected(i,1), headsElected(i,2), currNode(1), currNode(2));
%updating the distance of each node in the remaining set         
        if (dis < headsElected(i, 4))
        headsElected(i,4) = dis;
        end
   end
end
%selecting the closest node from the set of nodes
minDis = inf;
minDis_Index = 0;
for i = 1 : num_heads
  if(headsElected(i, 5) ~= 1)
      if (minDis > headsElected(i, 4))
          minDis = headsElected(i, 4);
          minDis_Index = i;
      end
  end
end
%for debugging only
distance(j, 1) = headsElected(minDis_Index, 1);
distance(j, 2) = headsElected(minDis_Index, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
currNode(1) = headsElected(minDis_Index, 1);
currNode(2) = headsElected(minDis_Index, 2);
tree(j) =     headsElected(minDis_Index, 3);
end
distance
end