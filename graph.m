clc
output = readFromFile ('result.txt');
output_Leach = readFromFile ('result_Leach.txt');
output
hold on
plot(output(1:10,1), output(1:10,2));
plot(output_Leach(1:10,1), output_Leach(1:10,2), 'red');
hold off