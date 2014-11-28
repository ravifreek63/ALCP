function clusterSize = getClusterSizes (Sensor_Nodes_Number, Y)
clusterSize = zeros (Sensor_Nodes_Number, 1);
% updating the number of sensor nodes per cluster head %
for i = 1 : Sensor_Nodes_Number
    for j = 1 : Sensor_Nodes_Number
    if ((Y (i,j) == 1) && (i ~= j))
        clusterSize (j) = clusterSize (j) + 1;
    end
    end
end
end