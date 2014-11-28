function result = stoppingCondition(it_count,bestLB,bestUB)
result = (it_count > 10) | (bestUB == bestLB);
% result = iterationNo > 15000 | (bestUB == bestLB);