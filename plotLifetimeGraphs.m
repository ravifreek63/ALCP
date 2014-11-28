function plotLifetimeGraphs()
L1 = readFromFile('Plot1.txt');
L2 = readFromFile ('Plot2.txt');
I = [10;20;30;40;50;60;70;80;90];
hold on
title('Comparison of LIFETIME IN Algorithms 1, 2.');
ylabel('NUMBER OF ROUNDS');
xlabel('PERCENTAGE OF NODES DYING.');
%L2
plot (I,L1);
plot (I,L2);
hold off