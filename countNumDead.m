function [numDeadArray, deadSensorNodeMatrix, typeOfdeadSensorNodeMatrix] = countNumDead (isAliveMatrix, num_it, numDeadArray, deadSensorNodeMatrix, typeOfdeadSensorNodeMatrix, Y)
numberDead = 0;
l = length (isAliveMatrix);
for i = 1 : l
    if (isAliveMatrix(i) == 0)
        numberDead = numberDead + 1;
        deadSensorNodeMatrix(num_it, numberDead) = i;
        if (Y(i,i) == 1)
            typeOfdeadSensorNodeMatrix(num_it, numberDead) = 1;
        else
            typeOfdeadSensorNodeMatrix(num_it, numberDead) = 0;
        end        
    end
end
numDeadArray (num_it) = numberDead;
end
