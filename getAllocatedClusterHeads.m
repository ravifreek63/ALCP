function Ch2 = getAllocatedClusterHeads(Ch,X,p)
Ch2 = zeros(p,2);
j = 1;
for i = 1 : length(Ch)
    if(sum(X(i,:) > 0))
    Ch2(j,:) = Ch(i,:);
    j = j + 1;
    end
end