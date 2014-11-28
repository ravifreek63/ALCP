
E1 = readFromFile('Energy_algo1.txt');
E2 = readFromFile('Energy_algo2.txt');
hold on
title('Comparison of ENERGY DISTRIBUTIONS IN Algorithms 1, 2.');
ylabel('Standard Deviation');
xlabel('Number Of Rounds');
plot (E1);
plot (E2);
hold off
