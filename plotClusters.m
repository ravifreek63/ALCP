function plotClusters(Y,X,Sn,Ch)
count = 0;
for j = 1 : length(Ch)    
    if (sum(X(j,:)) > 0)
        count = count + 1;
         x = getcolor(count);
         plot(Ch(j,1),Ch(j,2),'d','MarkerFaceColor',x);
        for i = 1 : length(Sn)
            if(Y(i,j) == 1)
               plot(Sn(i,1),Sn(i,2),'s','MarkerFaceColor',x);
            end
        end
    end
end
