   1.
      --- solve_problems.m
   2.
       
   3.
      function report = solve_problems()
   4.
      % data_files={'Alberta';'Galvao100';'Galvao100';'Galvao150';'Galvao150';'Galvao150'};
   5.
      % p=[10 10 15 5 15 20];
   6.
      % data_files={'TestData'};
   7.
      % p=[2];
   8.
      data_files={'Alberta'};
   9.
      p=[10];
  10.
      for i=1:length(data_files)
  11.
      data_file=char(data_files(i));
  12.
      dist=distances([data_file '_distances.txt']);
  13.
      demand=load([data_file '_demands.txt']);
  14.
      [bestLB,iterations,debug]=solve_p_median(dist,demand,p(i));
  15.
      report(i).bestLB=bestLB;
  16.
      report(i).iterations=iterations;
  17.
      report(i).debug=debug;
  18.
      dlmwrite([data_file '_p' int2str(p(i)) '_iterations.txt'],iterations);
  19.
      dlmwrite([data_file '_p' int2str(p(i)) '_debug.txt'],debug);
  20.
      end
  21.
       
  22.
      --- distances.m
  23.
       
  24.
      function distances=distances(data_file)
  25.
      distance_data=load(data_file);
  26.
      distances=zeros(distance_data(end,1)+1);
  27.
      for row=1:length(distance_data)
  28.
      from=distance_data(row,1);
  29.
      to=distance_data(row,2);
  30.
      distance=distance_data(row,3);
  31.
      distances(to,from)=distance;
  32.
      distances(from,to)=distance;
  33.
      end
  34.
       
  35.
      --- solve_p_median.m
  36.
       
  37.
      function [bestLB,iterations,debug]=solve_p_median(dist,demand,p)
  38.
      bestLB=0;
  39.
      bestUB=inf;
  40.
      currentLB=0;
  41.
      currentUB=inf;
  42.
      iterations(1,:)=[0 currentLB bestLB currentUB bestUB];
  43.
      pi=2;
  44.
      n_c=length(demand); % number of customers
  45.
      n_s=length(dist(:,1)); % number of sites
  46.
      u=ones(n_c,1); % LR (Lagrangean Relaxation) multipliers
  47.
      zero=zeros(n_c,1);
  48.
      x=zeros(n_s,n_c); % site/customer assignments
  49.
      i=1;
  50.
      piUpdateTime=1;
  51.
      improvementOccurred=0;
  52.
      debug=[0 0 2 zeros(1,p) u']; % parameters stored for debugging (iteration, step_size, pi, open facilities, u)
  53.
      while(~stoppingCondition(pi,bestLB,bestUB,i))
  54.
      for s=1:n_s
  55.
      cost=dist(:,s).*demand;
  56.
      newCost=cost-u;
  57.
      z_LR(s)=sum(min(zero,newCost));
  58.
      x(s,find(newCost<0))=1; % x_{s,c} = 1 if cost negative
  59.
      end
  60.
      [z_sorted,order]=sort(z_LR);
  61.
      currentLB=sum(z_sorted(1:p))+sum(u); % z_{LR}(u) value is current LB
  62.
      facilities=order(1:p); % open p facilities where z is smallest
  63.
      x(setdiff(1:n_s,facilities),:)=0; % x_{s,c} \leq y_s \forall s,c constraint
  64.
      if(currentLB>bestLB)
  65.
      bestLB=currentLB;
  66.
      end
  67.
      currentUB=findUB(facilities,dist,demand);
  68.
      if(currentUB<bestUB)
  69.
      bestUB=currentUB;
  70.
      end
  71.
      iterations(i+1,:)=[i currentLB bestLB currentUB bestUB];
  72.
      normOfRelaxedCsts=sum((1-sum(x)).^2);
  73.
      if(normOfRelaxedCsts == 0) % hit the lower bound
  74.
      break
  75.
      end
  76.
      step=pi*(bestUB-currentLB)/normOfRelaxedCsts; % s^t = {\pi (UB* - z_{LR}(u^t)) \over \sum_c (1-\sum_s x_{sc})^2}
  77.
      u=u+step*(1-sum(x))'; % u_c^{t+1} = u_c^t + s^t (1-\sum_s x_{sc}^t)
  78.
      if(~improvementsOccur(iterations,piUpdateTime))
  79.
      pi=pi/2;
  80.
      piUpdateTime=i;
  81.
      end
  82.
      debug(i+1,:)=[i step pi facilities u'];
  83.
      i=i+1
  84.
      end
  85.
       
  86.
      function result=stoppingCondition(pi,bestLB,bestUB,iterationNo)
  87.
      result = (pi < 0.005) | (bestUB == bestLB);
  88.
      % result = iterationNo > 15000 | (bestUB == bestLB);
  89.
       
  90.
      function result=improvementsOccur(iterations,piUpdateTime)
  91.
      n=30;
  92.
      currentTime=length(iterations(:,1));
  93.
      timeSinceLastPiUpdate=currentTime-piUpdateTime;
  94.
      if(currentTime <= n | timeSinceLastPiUpdate <= n)
  95.
      result = 1;
  96.
      else
  97.
      lastImpForLB=whenDidLastImprovementOccur(iterations(end-n:end,3));
  98.
      lastImpForUB=whenDidLastImprovementOccur(iterations(end-n:end,5));
  99.
      if(lastImpForLB <= n | lastImpForUB <= n)
 100.
      result = 1;
 101.
      else
 102.
      result = 0;
 103.
      end
 104.
      end
 105.
       
 106.
      function lastImp=whenDidLastImprovementOccur(iterations)
 107.
      lastValue=iterations(end);
 108.
      ixLastImp=length(find(iterations~=lastValue));
 109.
      lastImp=length(iterations)-ixLastImp;
 110.
       
 111.
      function currentUB=findUB(facilities,dist,demand)
 112.
      feasibleAssignments=assignCustomers(facilities,dist);
 113.
      currentUB=sum(feasibleAssignments.*dist)*demand;
 114.
       
 115.
      function customerAssignments=assignCustomers(facilities,dist)
 116.
      n_s=length(dist(:,1)); % number of sites
 117.
      n_c=length(dist(1,:)); % number of customers
 118.
      customerAssignments=zeros(n_s,n_c);
 119.
      distOpenFacilities=dist(facilities,:);
 120.
      [minDist,order]=min(distOpenFacilities);
 121.
      for c=1:n_c
 122.
      customerAssignments(facilities(order(c)),c)=1;
 123.
      end