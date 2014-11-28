function [clusterSizes, totalSensorsAssigned] = getClusteSize (Y, electedClusterHead, num_it, clusterSizes, totalSensorsAssigned)
l = length (Y);
for i = 1 : l
   for j = 1 : 5
        chIndex = electedClusterHead (num_it, j);
        if (chIndex ~= 0)
            if (Y(i, chIndex) == 1)
                clusterSizes(num_it, chIndex) = clusterSizes(num_it, chIndex) + 1;
                totalSensorsAssigned(num_it) = totalSensorsAssigned(num_it) + 1;
                break
            end
        end        
   end
end
end
